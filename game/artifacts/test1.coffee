class Artifact.Test1 extends Artifact
  constructor: ->
    super
    @activatedWalls = []
  
  createSubObjects: ->
    [
      new Wall v(200, 200, 20), v(0, 0,  110), 0
      new Wall v(200, 200, 20), v(0, 0, -110), 3
      new Wall v(200, 20, 200), v(0,  110, 0), 5
      new Wall v(200, 20, 200), v(0, -110, 0), 2
      new Wall v(20, 200, 200), v( 110, 0, 0), 1
      new Wall v(20, 200, 200), v(-110, 0, 0), 4
    ]
  
  deactivateOtherWalls: (wall) ->
    for obj in @subObjects when obj.popped && obj isnt wall
      obj.animator?.expire()
      obj.animate(no)
  
  activateWall: (wall) ->
    if wall.order == @activatedWalls.length
      @activatedWalls.push(wall)
      wall.animate(yes) unless wall.popped
      @deactivateOtherWalls(wall) if @activatedWalls.length == 1
    
    else
      @activatedWalls = []
      @deactivateOtherWalls(wall)
      wall.animate(!wall.popped)
    
    # Win condition
    if @activatedWalls.length == 6
      setTimeout _.bind(@complete, this), 500
      
      
    
    




class Wall extends Artifact.SubObject
  mats = [
    new THREE.MeshLambertMaterial(color: 0x000000, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x2a2a2a, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x444444, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x555555, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x888888, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0xffffff, shading: THREE.FlatShading)
  ]
  
  constructor: (@size, position, @order, options = {}) ->
    super @scene, options
    @position.copy(position)
    @popped = no
    
    @targets =
      open:   @position.clone().addSelf(@position.clone().normalize().multiplyScalar 75)
      closed: @position.clone()
    
  
  geometry: -> new THREE.Cube(@size.x, @size.y, @size.z)
  material: -> mats[@order]
  
  onTouch: ->
    @artifact.activateWall(this)
  
  animate: (outward) ->
    # Save the activated sate
    @popped = outward
    
    # Fast out, slow/sloppy in
    duration = if outward
      0.3
    else
      0.6 + Math.random()*0.6
    
    # Setup the active and inactive positions
    startPos = @position.clone()
    endPos   = if outward then @targets.open else @targets.closed
    
    # Move faster near the cube
    options = curve: if outward then Animator.easeout else Animator.easein
    
    # Animate
    @animator = new Animator(duration, options, (progress) =>
      @position.setBetween(startPos, endPos, progress)
    )
    
    