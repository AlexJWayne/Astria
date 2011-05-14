class @OrbitCamera extends THREE.Camera
  
  defaults =
  
    # How quickly the camera moves around
    sensitivity: 500
  
    # Distance of camera from the origin
    distance: 500
  
    # x and y angle of the camera on creation
    startingOrbit: new THREE.Vector2(45, 30)
  
  # Create a new camera
  constructor: (args...) ->
    super args...    
    { @sensitivity, @distance } = defaults
    @orbit    = defaults.startingOrbit.clone()
    @last     = defaults.startingOrbit.clone()
  
  # Update the orbit angles based on a mousemove event
  move: (event) ->
    
    # Orbit horizontally, wrapping from 0 to 360
    @orbit.x += (event.clientX - @last.x) / window.innerWidth  * @sensitivity
    @orbit.x -= 360 if @orbit.x > 360
    @orbit.x += 360 if @orbit.x < 0
    @last.x = event.clientX
    
    # Orbit vertically, from -90 to 90 without wrapping
    @orbit.y += (event.clientY - @last.y) / window.innerHeight * @sensitivity
    @orbit.y =  90 if @orbit.y >  90
    @orbit.y = -90 if @orbit.y < -90
    @last.y  = event.clientY
  
  # Set the position of the camera according to the current X and Y orbit values
  updateOrbit: ->
    { x, y } = @orbit
    
    # Reset position
    @position.multiplyScalar(0)
    
    # Horizontal
    @position.x = -Math.sinD(x) * @distance
    @position.z =  Math.cosD(x) * @distance
    
    # Vertical
    @position.multiplyScalar Math.cosD(y)
    @position.y =  Math.sinD(y) * @distance
  
  
  castMouse: (scene, event) ->
    ray = new THREE.Ray()
    
    # Set the ray origin to screen space coordinates
    ray.origin.set(
      event.clientX / window.innerWidth * 2 - 1
      -(event.clientY / window.innerHeight * 2 - 1)
      0
    )
    
    # Transform ray origin to world space
    matrix = @matrixWorld.clone();
    matrix.multiplySelf THREE.Matrix4.makeInvert(@projectionMatrix)
    matrix.multiplyVector3(ray.origin)
    
    # Tranform the ray direction to world space
    ray.direction = ray.origin.clone().subSelf(@position)
    
    # # Sticks an object in the scene at the mouse click in order to verify accuracy
    # do =>
    #   g = new THREE.Cube(5,5,5)
    #   m = new THREE.MeshBasicMaterial(color: 0xff00ff)
    #   o = new THREE.Mesh(g, m)
    #   o.position.copy ray.origin.clone().addSelf(ray.direction.clone().normalize().multiplyScalar @position.length())
    #   scene.addObject(o)

    hits = ray.intersectScene(scene)
    hits.sort (a, b) ->
      if a.distance > b.distance then 1 else -1