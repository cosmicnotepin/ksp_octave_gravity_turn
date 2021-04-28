run once other.
run once warp.

local radii to readjson("r.json").
local angles to readjson("a.json").

lock steering to up.
lock throttle to 1.
stage.
wait 6.
stage.
local firstStageStartTime to time:seconds.

unlock steering.
local angle to 0.
local vd to vecdraw({return ship:position.}, {return heading(0, angle):forevector * 20.}, red).
set vd:show to true.
local vd2 to vecdraw({return ship:position.}, {return velocity:surface:normalized * 30.}, white).
set vd2:show to true.
local vd3 to vecdraw({return ship:position.}, {return ship:facing:forevector:normalized * 25.}, green).
set vd3:show to true.
until maxthrust = 0 {
    for i in range(radii:length) {
        if (radii[i] > altitude) {
            set angle to angles[i].
            break.
        }
    }
    set steering to unrotate(heading(0, angle):forevector).
    wait 0.  
}
wait until maxthrust = 0.
set warpmode to "physics".
set warp to 4.
wait until altitude > 140000.
kuniverse:timewarp:cancelwarp.
wait until kuniverse:timewarp:issettled.
stage.
wait 5.
stage.
wait 5.
stage.
wait 5.
print "free".

warpWait(time:seconds + eta:apoapsis - 105 - 30).
print "90-30".
lock throttle to 0.
RCS on.
lock steering to prograde.

wait until eta:apoapsis < (105 - 5).
print "90-5".
set ship:control:fore to 1.
wait 3.
print "3".
lock throttle to 1.
stage.
print "stage".
set ship:control:neutralize to true.
wait until apoapsis > 700000.
lock throttle to 0.

print "apoapsis: " + (apoapsis + body:radius).
print "periapsis: " + (periapsis + body:radius).

