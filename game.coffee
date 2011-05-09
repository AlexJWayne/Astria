class @Game
  constructor: ->
    @camera = new THREE.Camera(75, window.innerWidth / window.innerHeight, 1, 10000)
    @camera.position.z = 500
    @camera.orbit = { x:0, y:0 }
    @camera.last  = { x:0, y:0 }

    @scene = new THREE.Scene()
    
    @model = new Model()
    @scene.addObject(@model.mesh)

    @renderer = new THREE.CanvasRenderer()
    @renderer.setSize(window.innerWidth, window.innerHeight)

    document.body.appendChild(@renderer.domElement)
    
    document.onmousemove = @mouseMove
    document.onmousedown = (event) =>
      @camera.orbit.enabled = on
      @camera.last.x = event.clientX
      @camera.last.y = event.clientY
      
    document.onmouseup = =>
      @camera.orbit.enabled = off
  
  # Update camera position
  mouseMove: (event) =>
    sensitivity = 3
    
    if @camera.orbit.enabled
      @camera.orbit.x += (event.clientX - @camera.last.x) / window.innerWidth  * sensitivity
      @camera.orbit.x -= 2 if @camera.orbit.x >  1
      @camera.orbit.x += 2 if @camera.orbit.x < -1
      @camera.last.x = event.clientX
      
      @camera.orbit.y += (event.clientY - @camera.last.y) / window.innerHeight * sensitivity
      @camera.orbit.y =  0.5 if @camera.orbit.y >  0.5
      @camera.orbit.y = -0.5 if @camera.orbit.y < -0.5
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
    @camera.position.x = -Math.sin(x*Math.PI) * 500
    @camera.position.z =  Math.cos(x*Math.PI) * 500
    
    # Vertical
    @camera.position.multiplyScalar Math.cos(y*Math.PI)
    @camera.position.y =  Math.sin(y*Math.PI) * 500