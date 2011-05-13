head.js(
  # THREE.js
  "lib/three.js"
  "lib/RequestAnimationFrame.js"
  
  # Astria
  "util.js"
  "game.js"
  "artifact.js"
  
  # All loaded callback
  ->
    Game.game = new Game()
    Game.game.animate()
)