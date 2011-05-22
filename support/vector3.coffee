# Vector3 shorthand
@v = (args...) ->
  new THREE.Vector3 args...

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

THREE.Vector3::log = ->
  console.log @x, @y, @z