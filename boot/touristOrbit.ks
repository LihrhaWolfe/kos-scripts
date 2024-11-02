wait until ship:unpacked.
core:doevent("Open Terminal").

clearscreen.

print "running orbit tourist script...".
wait 3.

print "launching to 100km apoapsis...".
wait 1.
stage.

lock throttle to 1.
lock steering to heading(90,(90-((ship:apoapsis/1000)*0.8))).

set prevthrust to ship:availablethrust.
when ship:availablethrust < prevthrust then {
	print("staging! " + ship:stagenum).
	stage.
	wait 1.
	if ship:availablethrust < 0.1 {
		print("staging! " + ship:stagenum).
		stage.
		wait 1.
	}
	set prevthrust to ship:availablethrust.
	return true.
}

wait until ship:apoapsis > 99.5*1000.
print "apoapsis reached ~100km successfully".
lock throttle to 0.
unlock steering.
sas on.

wait until eta:apoapsis < 16.
print "starting orbit burn...".
sas off.
lock steering to heading(90,5).
lock throttle to 1. 

wait until ship:periapsis > 75*1000.
print "orbit reached!".
lock throttle to 0.
unlock steering.
sas on.

wait until eta:apoapsis < 61.
print "starting de-orbit turn...".
sas off.
lock steering to retrograde.

wait until eta:apoapsis < 16.
print "starting de-orbit burn...".
lock throttle to 1.

wait until ship:periapsis < -100000.
print("de-orbit reached!").
lock throttle to 0.
lock steering to v(0,90,0).

wait until ship:altitude < 60000.
print("entering atmosphere, deploying entry pods...").

until ship:stagenum = 0 {stage. wait 3.}
unlock steering.
print("all pods deployed!").
print("wait until all pods touchdown before recovering.").