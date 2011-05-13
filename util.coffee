@v = (args...) ->
  new THREE.Vector3 args...

Math.deg2rad = (deg) -> deg * Math.PI / 180
Math.rad2deg = (rad) -> rad * 180 / Math.PI

Math.sinD = (deg) -> Math.sin Math.deg2rad(deg)
Math.cosD = (deg) -> Math.cos Math.deg2rad(deg)
Math.tanD = (deg) -> Math.tan Math.deg2rad(deg)
Math.atan2D = (y, x) -> Math.rad2deg Math.atan2(y, x)

THREE.Vector3::rotateX = (deg) ->
  { y, z } = this
  @y = y * Math.cosD(deg) - z * Math.sinD(deg)
  @z = y * Math.sinD(deg) + z * Math.cosD(deg)
  return this

THREE.Vector3::rotateY = (deg) ->
  { x, z } = this
  @x = z * Math.sinD(deg) + x * Math.cosD(deg)
  @z = z * Math.cosD(deg) - x * Math.sinD(deg)
  return this

THREE.Vector3::rotateZ = (deg) ->
  { x, y } = this
  @x = x * Math.cosD(deg) - y * Math.sinD(deg)
  @y = x * Math.sinD(deg) + y * Math.cosD(deg)
  return this
  