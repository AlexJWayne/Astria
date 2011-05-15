(function() {
  head.js('lib/three.js', 'lib/RequestAnimationFrame.js', 'lib/stats.js', 'lib/underscore.js', 'util.js', 'orbit_camera.js', 'game.js', 'artifact.js', 'artifacts/test1.js', function() {
    Game.init();
    return Game.animate();
  });
}).call(this);
