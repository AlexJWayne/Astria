class Artifact.Test1 extends Artifact
  constructor: (args...) ->
    super(args...)
    @activatedWalls = []
  
  createSubObjects: ->
    [
      new Wall @scene, v(200, 200, 20), v(0, 0,  160), 0
      new Wall @scene, v(200, 200, 20), v(0, 0, -160), 3
      new Wall @scene, v(200, 20, 200), v(0,  160, 0), 4
      new Wall @scene, v(200, 20, 200), v(0, -160, 0), 2
      new Wall @scene, v(20, 200, 200), v( 160, 0, 0), 1
      new Wall @scene, v(20, 200, 200), v(-160, 0, 0), 5
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
    new THREE.MeshLambertMaterial(color: 0x333333, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x666666, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x999999, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0xcccccc, shading: THREE.FlatShading)
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
    goal  = @position.clone().addSelf(@position.clone().normalize().multiplyScalar(if outward then -50 else 50))
    curve = if outward then Animator.easeout else Animator.easein
    
    # Animate
    @animator = new Animator 0.5, curve: Animator.easeout, (progress) =>
      @position.setBetween(start, goal, progress)
    
    