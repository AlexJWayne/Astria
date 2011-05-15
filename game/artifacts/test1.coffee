class Artifact.Test1 extends Artifact
  constructor: (args...) ->
    super(args...)
    @activatedWalls = []
  
  createSubObjects: ->
    [
      new Wall @scene, v(200, 200, 20), v(0, 0,  110), 0
      new Wall @scene, v(200, 200, 20), v(0, 0, -110), 3
      new Wall @scene, v(200, 20, 200), v(0,  110, 0), 5
      new Wall @scene, v(200, 20, 200), v(0, -110, 0), 2
      new Wall @scene, v(20, 200, 200), v( 110, 0, 0), 1
      new Wall @scene, v(20, 200, 200), v(-110, 0, 0), 4
    ]
  
  deactivateOtherWalls: (wall) ->
    for obj in @subObjects
      obj.animate(off) if obj.popped and obj isnt wall
  
  activateWall: (wall) ->
    # Abort if we are still animating
    for obj in @subObjects
      return if wall.animator?.animating
    
    if wall.order == @activatedWalls.length
      @activatedWalls.push(wall)
      wall.animate(on) unless wall.popped
      @deactivateOtherWalls(wall) if @activatedWalls.length == 1
    
    else
      @activatedWalls = []
      @deactivateOtherWalls(wall)
      wall.animate(!wall.popped)
    
    # Win condition
    if @activatedWalls.length == 6
      setTimeout =>
        alert 'A winner is you! Resetting...'
        @activatedWalls = []
        setTimeout =>
          @deactivateOtherWalls()
        , 500
      , 500
      
      
    
    




class Wall extends Artifact.SubObject
  mats = [
    new THREE.MeshLambertMaterial(color: 0x000000, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x2a2a2a, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x444444, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x555555, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x888888, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0xffffff, shading: THREE.FlatShading)
  ]
  
  constructor: (@scene, @size, position, @order, options = {}) ->
    super @scene, options
    @position.copy(position)
    @popped = no
  
  geometry: -> new THREE.Cube(@size.x, @size.y, @size.z)
  material: -> mats[@order]
  
  onTouch: ->
    @artifact.activateWall(this)
  
  animate: (outward) ->
    # Save the activated sate
    @popped = outward
    
    # Setup the activae and inactive positions
    start = @position.clone()
    goal  = @position.clone().addSelf(@position.clone().normalize().multiplyScalar(if outward then 50 else -50))
    curve = if outward then Animator.easeout else Animator.easein
    
    # Animate
    @animator = new Animator 0.5, curve: Animator.easeout, (progress) =>
      @position.setBetween(start, goal, progress)
    
    