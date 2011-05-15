# Vector3 shorthand
@v = (args...) ->
  new THREE.Vector3 args...

# Degree math helpers
Math.deg2rad = (deg) -> deg * Math.PI / 180
Math.rad2deg = (rad) -> rad * 180 / Math.PI

Math.sinD = (deg) -> Math.sin Math.deg2rad(deg)
Math.cosD = (deg) -> Math.cos Math.deg2rad(deg)
Math.tanD = (deg) -> Math.tan Math.deg2rad(deg)
Math.atan2D = (y, x) -> Math.rad2deg Math.atan2(y, x)

Math.between = (a, b, progress = 0.5) ->
  a * (1 - progress) +
  b * progress

# Vector3 extensions
THREE.Vector3::rotateX = (deg) ->
  @set(
    @x
    @y * Math.cosD(deg) - @z * Math.sinD(deg)
    @y * Math.sinD(deg) + @z * Math.cosD(deg)
  )

THREE.Vector3::rotateY = (deg) ->
  @set(
    @z * Math.sinD(deg) + @x * Math.cosD(deg)
    @y
    @z * Math.cosD(deg) - @x * Math.sinD(deg)
  )

THREE.Vector3::rotateZ = (deg) ->
  @set(
    @x * Math.cosD(deg) - @y * Math.sinD(deg)
    @x * Math.sinD(deg) + @y * Math.cosD(deg)
    @z
  )

THREE.Vector3::setBetween = (a, b, progress = 0.5) ->
  @set(
    Math.between(a.x, b.x, progress)
    Math.between(a.y, b.y, progress)
    Math.between(a.z, b.z, progress)
  )

# Animator
class @Animator
  
  # Curve functions for transforming the progression value
  Animator.linear   = (progress) -> progress
  Animator.ease     = (progress) -> (1 - Math.cos(progress * Math.PI)) / 2
  Animator.easein   = (progress) -> (1 - Math.cos(progress * Math.PI / 2))
  Animator.easeout  = (progress) -> Math.cos((progress-1) * Math.PI / 2)
  
  constructor: (args..., @callback) ->
    @duration = args[0]
    options   = args[1] || {}
    
    @curve = options.curve || Animator.ease
    
    Game.animators.push(this)
    @start = Game.lastFrameAt
    @elapsed = 0
    @expired = no
    @alive   = yes
  
  progress: ->
    result = @elapsed / @duration
    @expired = result >= 1
    @animating = !@expired
    
    if result > 1 then 1 else result
  
  update: ->
    @elapsed = Game.lastFrameAt - @start
    @callback @curve(@progress())
  
  
    
    