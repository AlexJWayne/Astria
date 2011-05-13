class @Artifact
  constructor: (@scene) ->
    @subObjects = [
      new Wall @scene, v(200, 200, 20), v(0, 0,  110), 0
      new Wall @scene, v(200, 200, 20), v(0, 0, -110), 0
      new Wall @scene, v(200, 20, 200), v(0,  110, 0), 1
      new Wall @scene, v(200, 20, 200), v(0, -110, 0), 1
      new Wall @scene, v(20, 200, 200), v( 110, 0, 0), 2
      new Wall @scene, v(20, 200, 200), v(-110, 0, 0), 2
    ]



class SubObject
  constructor: (@scene, options = {}) ->
    @mesh = @mesh() # load the mesh and replace the method with the object
    @mesh.owner = this
    @scene.addObject @mesh
    
  geometry: -> new THREE.Cube(10, 10, 10)
  material: -> new THREE.MeshBasicMaterial(color: 0xff00ff)
  mesh: ->     new THREE.Mesh(@geometry(), @material())
  onTouch: null # If this is a function the obect is interactive



class Wall extends SubObject
  mats = [
    new THREE.MeshBasicMaterial(color: 0xff0000)
    new THREE.MeshBasicMaterial(color: 0x00ff00)
    new THREE.MeshBasicMaterial(color: 0x0000ff)
  ]
  
  constructor: (@scene, @size, @position, @matIndex, options = {}) ->
    super @scene, options
  
  geometry: -> new THREE.Cube(@size.x, @size.y, @size.z)
  material: -> mats[@matIndex]
  mesh: ->
    mesh = super()
    mesh.position.copy(@position)
    return mesh
  
  onTouch: ->
    @scene.removeChild @mesh