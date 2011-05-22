class @OrbitCamera extends THREE.Camera
  
  defaults =
  
    # How quickly the camera moves around
    sensitivity: 500
  
    # Distance of camera from the origin
    distance: 500
  
    # x and y angle of the camera on creation
    startingOrbit: new THREE.Vector2(45, 30)
    
    # Debug flags
    debug:
      showClicks: off
  
  # Create a new camera
  constructor: ->
    super
    { @sensitivity, @distance } = defaults
    @orbit    = defaults.startingOrbit.clone()
    @last     = defaults.startingOrbit.clone()
  
  # Update the orbit angles based on a mousemove event
  move: (event) ->
    
    # Orbit horizontally, wrapping from 0 to 360
    @orbit.x += (event.clientX - @last.x) / window.innerWidth  * @sensitivity
    @last.x = event.clientX
    
    # Orbit vertically, from -90 to 90 without wrapping
    @orbit.y += (event.clientY - @last.y) / window.innerHeight * @sensitivity
    @last.y  = event.clientY
  
  # Set the position of the camera according to the current X and Y orbit values
  updateOrbit: ->
    
    # Wrap horizontally
    @orbit.x -= 360 if @orbit.x > 360
    @orbit.x += 360 if @orbit.x < 0
    
    # Stop at top and bottom
    @orbit.y =  90 if @orbit.y >  90
    @orbit.y = -90 if @orbit.y < -90
    
    # Snag some xy as local vars
    { x, y } = @orbit
    
    # Reset position
    @position.setLength(0)
    
    # Horizontal
    @position.x = -Math.sinD(x) * @distance
    @position.z =  Math.cosD(x) * @distance
    
    # Vertical
    @position.multiplyScalar Math.cosD(y)
    @position.y =  Math.sinD(y) * @distance
  
  # Turn screen x and y into a point in space along a plane perpendicular camera
  # slicing through the origin.
  screenToWorldPosition: (x, y) ->
    { origin, direction } = @screenToRay x, y
    origin.addSelf direction.setLength(@distance)
  
  screenToDirection: (x, y) ->
    # Create an vector for the mouse in screen space
    mousePos = v(
      event.clientX / window.innerWidth * 2 - 1
      -(event.clientY / window.innerHeight * 2 - 1)
      0
    )
    
    # Transform screen space y the camera matrix
    matrix = @matrixWorld.clone()
    matrix.multiplySelf THREE.Matrix4.makeInvert(@projectionMatrix)
    matrix.multiplyVector3(mousePos)
    
    # Offset by the camera position
    mousePos.subSelf(@position)
  
  # Turn screen x and y into a ray from the camera that can intersect the scene
  screenToRay: (x, y) ->
    new THREE.Ray @position.clone(), @screenToDirection(x, y)
  
  # Return an array of objects that were hit by a ray from the camera toward
  # the mouse click location
  castMouse: (scene, event) ->
    ray = @screenToRay(event.clientX, event.clientY)
    
    # Sticks an object in the scene at the mouse click in order to verify accuracy
    if defaults.debug.showClicks
      g = new THREE.Cube(5,5,5)
      m = new THREE.MeshBasicMaterial(color: 0xff00ff)
      o = new THREE.Mesh(g, m)
      o.position.copy @screenToWorldPosition(event.clientX, event.clientY)
      scene.addObject(o)
    
    # Throw the ray at the scene and see what sticks
    hits = ray.intersectScene(scene)
    hits.sort (a, b) ->
      if a.distance > b.distance then 1 else -1
  
  # Spin for the win
  winSpin: (callback)->
    camStart  = _.clone(@orbit)
    camEnd = 
      x: @orbit.x + 360
      y: 30
    
    new Animator 3, (progress) =>
      Game.camera.orbit.x = Math.between(camStart.x, camEnd.x, progress)
      Game.camera.orbit.y = Math.between(camStart.y, camEnd.y, progress)
      callback?() if progress == 1