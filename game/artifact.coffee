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
    Game.next()


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