class @Game
  constructor: ->
    @camera = new THREE.Camera(75, window.innerWidth / window.innerHeight, 1, 10000)
    @camera.position.z = 500
    @camera.orbit = { x:30, y:30 }
    @camera.last  = { x:30, y:30 }
    
    @scene = new THREE.Scene()
    
    @light = new THREE.DirectionalLight(0xffffff, 1.0, 500)
    @scene.addObject(@light)
    
    @artifact = new Artifact(@scene)

    @renderer = new THREE.CanvasRenderer()
    @renderer.setSize(window.innerWidth, window.innerHeight)

    document.body.appendChild(@renderer.domElement)
    bindEvents.call(this)
  
  bindEvents = ->
    document.onmousemove = @mouseMove
    document.onmousedown = (event) =>
      hits = @camera.castMouse(@scene, event)
      
      if hits.length > 0
        hits[0].object.owner?.onTouch?()
      else
        @camera.orbit.enabled = on
        @camera.last.x = event.clientX
        @camera.last.y = event.clientY
      
    document.onmouseup = =>
      @camera.orbit.enabled = off
  
  # Update camera position
  mouseMove: (event) =>
    sensitivity = 540
    
    if @camera.orbit.enabled
      @camera.orbit.x += (event.clientX - @camera.last.x) / window.innerWidth  * sensitivity
      @camera.orbit.x -= 360 if @camera.orbit.x > 360
      @camera.orbit.x += 360 if @camera.orbit.x < 0
      @camera.last.x = event.clientX
      
      @camera.orbit.y += (event.clientY - @camera.last.y) / window.innerHeight * sensitivity
      @camera.orbit.y =  90 if @camera.orbit.y >  90
      @camera.orbit.y = -90 if @camera.orbit.y < -90
      @camera.last.y  = event.clientY
      
      
  animate: =>
    requestAnimationFrame(@animate)
    @render()

  render: =>
    @renderCamera()
    @renderer.render(@scene, @camera)
  
  renderCamera: =>
    { x, y } = @camera.orbit
    
    # Reset position
    @camera.position.multiplyScalar(0)
    
    # Horizontal
    @camera.position.x = -Math.sinD(x) * 500
    @camera.position.z =  Math.cosD(x) * 500
    
    # Vertical
    @camera.position.multiplyScalar Math.cosD(y)
    @camera.position.y =  Math.sinD(y) * 500

THREE.Camera::castMouse = (scene, event) ->
  mousePos = v(
    event.clientX / window.innerWidth * 2 - 1
    -(event.clientY / window.innerHeight * 2 - 1)
    0
  )
  width = Math.tanD(@fov/2) * @position.length()
  mousePos.multiplySelf v(width, width / @aspect, 0)
  mousePos.multiplyScalar 1.7 # WTF why 1.7?
  
  mousePos.rotateX -@orbit.y
  mousePos.rotateY -@orbit.x
  
  # g = new THREE.Cube(5,5,5)
  # m = new THREE.MeshBasicMaterial(color: 0xff00ff)
  # o = new THREE.Mesh(g, m)
  # o.position.copy(mousePos)
  # scene.addObject o 
  
  ray = new THREE.Ray(@position, @position.clone().negate().addSelf(mousePos))
  hits = ray.intersectScene(scene)
  hits.sort (a, b) ->
    if a.distance > b.distance then 1 else -1