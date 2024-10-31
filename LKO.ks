print "launching to 100km apoapsis".
sas off.
wait 1.
stage.

lock throttle to 1.
lock steering to heading(90,(90-((ship:apoapsis/1000)*0.9))).

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
lock steering to heading(90,max(90-((ship:altitude/1000)*9),0)).
lock throttle to 1. 

wait until ship:periapsis > 75*1000.
print "orbit reached!".
unlock steering.
sas on.