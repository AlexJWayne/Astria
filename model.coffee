class @Model
  constructor: ->
    @geometry  = new THREE.Cube(200, 200, 200)
    @material  = new THREE.MeshBasicMaterial( color: 0xff0000, wireframe: true )
    @mesh      = new THREE.Mesh(@geometry, @material)
    
    