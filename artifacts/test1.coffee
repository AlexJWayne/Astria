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

class Wall extends Artifact.SubObject
  mats = [
    new THREE.MeshLambertMaterial(color: 0xff0000, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x00ff00, shading: THREE.FlatShading)
    new THREE.MeshLambertMaterial(color: 0x0000ff, shading: THREE.FlatShading)
  ]
  
  constructor: (@scene, @size, position, @matIndex, options = {}) ->
    super @scene, options
    @position.copy(position)
  
  geometry: -> new THREE.Cube(@size.x, @size.y, @size.z)
  material: -> mats[@matIndex]
  
  onTouch: ->
    @position.addSelf @position.clone().normalize().multiplyScalar(10)