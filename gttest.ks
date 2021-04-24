run once other.

lock steering to up.
lock throttle to 1.
stage.
local kick to heading(90, 90-50).
wait until velocity:surface:mag > 40.
lock steering to unrotate(kick:forevector).
wait until vang(ship:facing:forevector, kick:forevector) < 0.1.
wait until vang(ship:facing:forevector, velocity:surface) < 1.
local startTime to time:seconds.
print "mu: " + body:mu.
print "init vel: " + velocity:surface:mag.
print "init r: " + (body:radius + altitude).
print "init angle" + vang(ship:facing:forevector, vxcl(ship:up:forevector, ship:facing:forevector)).
print "init mass: " + ship:mass.
list engines in e.
print "mass flow: " + (e[0]:consumedresources:values[0]:massflow + e[0]:consumedresources:values[1]:massflow).
print "thrust: " + maxthrust.
lock steering to velocity:surface.
wait until time:seconds - startTime > 208.
//wait until periapsis > 20000.
lock throttle to 0.
print "burnTime: " + (time:seconds - startTime).
print "apoapsis: " + (apoapsis + body:radius).
print "periapsis: " + (periapsis + body:radius).

