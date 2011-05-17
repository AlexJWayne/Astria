# Base class for all artifacts
class @Artifact extends THREE.Object3D
  constructor: ->
    THREE.Object3D.call(this) # THREE Constructor
    
    @subObjects = @createSubObjects()
    for obj in @subObjects
      obj.artifact = this
      @addChild(obj) 
  
  # Override to return an array of Artifact.SubObject instances that compose the artifact
  createSubObjects: ->
    [new SubObject()]
  
  complete: ->
    Game.camera.winSpin()
    @exitAnimation -> Game.next()
    this
  
  birthAnimation: (callback) ->
    @scale.setLength(0)
    _.defer =>
      Game.camera.winSpin()
      anim = new Animator 2, curve: Animator.easeout, (progress) =>
        @scale.setBetween v(0,0,0), v(1,1,1), progress
      anim.complete = callback
  
  exitAnimation: (callback) ->
    setTimeout =>
      anim = new Animator 2, curve: Animator.easein, (progress) =>
        @scale.setBetween v(1,1,1), v(0,0,0), progress
      anim.complete = -> Game.next()
    , 2000


# Artifacts are composed of Artifact.SubObject instances
class @Artifact.SubObject extends THREE.Mesh
  constructor: ->
    THREE.Mesh.call this, @geometry(), @material() # THREE Constructor
  
  geometry: -> new THREE.Cube(10, 10, 10)
  material: -> new THREE.MeshBasicMaterial(color: 0xff00ff)
  
  # Pointer to the owning artifact object
  artifact: null
  
  # Override with a method here if the the object performs an action when touched
  onTouch: null