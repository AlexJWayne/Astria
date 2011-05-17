# Base class for all artifacts
class @Artifact
  constructor: (@scene) ->
    @subObjects = @createSubObjects()
    for obj in @subObjects
      obj.artifact = this
  
  # Override to return an array of Artifact.SubObject instances that compose the artifact
  createSubObjects: ->
    [new SubObject(@scene)]
  
  complete: ->
    Game.next()


# Artifacts are composed of Artifact.SubObject instances
class @Artifact.SubObject extends THREE.Mesh
  constructor: (@scene, options = {}) ->
    super @geometry(), @material()
    @scene.addObject(this)
    
  geometry: -> new THREE.Cube(10, 10, 10)
  material: -> new THREE.MeshBasicMaterial(color: 0xff00ff)
  
  # Override with a method here if the the object performs an action when touched
  onTouch: null