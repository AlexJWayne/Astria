(function() {
  head.js('lib/three.js', 'lib/RequestAnimationFrame.js', 'lib/underscore.js', 'util.js', 'orbit_camera.js', 'game.js', 'artifact.js', 'artifacts/test1.js', function() {
    Game.game = new Game();
    return Game.game.animate();
  });
}).call(this);
