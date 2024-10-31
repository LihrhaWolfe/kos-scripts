print "launching to 100km apoapsis".
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