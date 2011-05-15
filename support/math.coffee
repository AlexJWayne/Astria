Math.deg2rad = (deg) -> deg * Math.PI / 180
Math.rad2deg = (rad) -> rad * 180 / Math.PI

Math.sinD = (deg) -> Math.sin Math.deg2rad(deg)
Math.cosD = (deg) -> Math.cos Math.deg2rad(deg)
Math.tanD = (deg) -> Math.tan Math.deg2rad(deg)
Math.atan2D = (y, x) -> Math.rad2deg Math.atan2(y, x)

Math.between = (a, b, progress = 0.5) ->
  a * (1 - progress) +
  b * progress