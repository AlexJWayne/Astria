(function() {
  head.js('lib/three.js', 'lib/RequestAnimationFrame.js', 'lib/stats.js', 'lib/underscore.js', 'support/math.js', 'support/animator.js', 'support/orbit_camera.js', 'support/vector3.js', 'game/game.js', 'game/artifact.js', 'game/artifacts/test1.js', function() {
    Game.init();
    return Game.animate();
  });
}).call(this);
