head.js(
  # libs
  'lib/three.js'
  'lib/RequestAnimationFrame.js'
  'lib/stats.js'
  'lib/underscore.js'
  
  # Support
  'support/math.js'
  'support/animator.js'
  'support/orbit_camera.js'
  'support/vector3.js'
  
  # Astria Core
  'game/game.js'
  'game/artifact.js'
  
  # Levels
  'game/artifacts/test1.js'
  
  # All loaded callback
  ->
    Game.init()
    Game.animate()
)