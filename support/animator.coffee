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
    @complete?() if @animating && @expired # just expired
    @animating = !@expired
    
    if result > 1 then 1 else result
  
  update: ->
    return if @expired
    @elapsed = Game.lastFrameAt - @start
    @callback @curve(@progress())
  
  expire: ->
    @expired   = yes
    @animating = no
  
    
