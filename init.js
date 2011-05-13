(function() {
  head.js("lib/three.js", "lib/RequestAnimationFrame.js", "util.js", "game.js", "artifact.js", function() {
    Game.game = new Game();
    return Game.game.animate();
  });
}).call(this);
