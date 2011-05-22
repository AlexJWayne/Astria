class Artifact.Test2 extends Artifact
  constructor: ->
    super
    @createSlider  150
    @createSlider -150
  
  createSlider: (xPos) ->
    geom = new THREE.Cube(10, 10, 500)
    mat  = new THREE.MeshLambertMaterial(color: 0x333333, shading: THREE.FlatShading)
    mesh = new THREE.Mesh(geom, mat)
    mesh.position.x = xPos
    @addChild(mesh)
  
  createSubObjects: ->
    @left   = new Knob 0xff0000, v( 150, 0, 0)
    @center = new Knob 0x00ff00, v(   0, 0, 0), => @complete()
    @right  = new Knob 0x0000ff, v(-150, 0, 0)
    @center.scale.setLength(0)
    
    [@left, @center, @right]

  checkWinButton: ->
    if @left.position.z > 140 && @right.position.z < -140
      @center.scale.set(1, 1, 1)
    else
      @center.scale.setLength(0)

class Knob extends Artifact.SubObject
  constructor: (@color, position, onTouch) ->
    super
    @position.copy(position)
    @onTouch = onTouch if onTouch?
    
  geometry: -> new THREE.Sphere(40, 12, 6)
  material: -> new THREE.MeshLambertMaterial(color: @color, shading: THREE.FlatShading)
  onDrag: (@deltaPos) ->
    @position.z += @deltaPos.z
    @position.z =  150 if @position.z >  150
    @position.z = -150 if @position.z < -150
    @artifact.checkWinButton()
    
