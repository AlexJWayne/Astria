class Artifact.Test2 extends Artifact
  createSubObjects: ->
    [
      new WinButton 0xff0000, v(150, 0, 0)
      new WinButton 0x00ff00, v(0, 0, 0), => @complete()
      new WinButton 0x0000ff, v(-150, 0, 0)
    ]


class WinButton extends Artifact.SubObject
  constructor: (@color, position, onTouch) ->
    super
    @position.copy(position)
    @onTouch = onTouch
    
  geometry: -> new THREE.Sphere(60, 16, 8)
  material: -> new THREE.MeshLambertMaterial(color: @color, shading: THREE.FlatShading)