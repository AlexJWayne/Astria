class Artifact.Test2 extends Artifact
  createSubObjects: ->
    [new WinButton(@scene)]


class WinButton extends Artifact.SubObject
  geometry: -> new THREE.Sphere(80, 16, 8)
  material: -> new THREE.MeshLambertMaterial(color: 0x00ff00, shading: THREE.FlatShading)
  onTouch:  -> @artifact.complete()