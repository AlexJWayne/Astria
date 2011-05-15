class Artifact.Test1 extends Artifact
  createSubObjects: ->
    [
      new Wall @scene, v(200, 200, 20), v(0, 0,  110), 0
      new Wall @scene, v(200, 200, 20), v(0, 0, -110), 0
      new Wall @scene, v(200, 20, 200), v(0,  110, 0), 1
      new Wall @scene, v(200, 20, 200), v(0, -110, 0), 1
      new Wall @scene, v(20, 200, 200), v( 110, 0, 0), 2
      new Wall @scene, v(20, 200, 200), v(-110, 0, 0), 2
    ]
  
  activateWall: (wall) ->
    # Abort if we are still animating
    return if @poppedWall?.animator.animating
    
    if @poppedWall is wall
      @poppedWall.animate off
      @poppedWall = null
    
    else
      @poppedWall?.animate off
      @poppedWall = wall
      @poppedWall.animate on




class Wall extends Artifact.SubObject
  mats = [
    new THREE.MeshLambertMaterial(color: 0xff0000, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x00ff00, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x0000ff, shading: THREE.FlatShading)
  ]
  
  constructor: (@scene, @size, position, @matIndex, options = {}) ->
    super @scene, options
    @position.copy(position)
    @popped = no
  
  geometry: -> new THREE.Cube(@size.x, @size.y, @size.z)
  material: -> mats[@matIndex]
  
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
    
    