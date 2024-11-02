wait until ship:unpacked.
core:doevent("Open Terminal").

print "running suborbit tourist script...".
wait 3.

print "launching to 100km apoapsis".
wait 1.
stage.

lock throttle to 1.
lock steering to heading(90,(90-((ship:apoapsis/1000)*0.8))).

set prevthrust to ship:availablethrust.
when ship:availablethrust < prevthrust then {
	print "staging...".
	stage.
	wait 1.
	if ship:availablethrust < 0.1 {
		stage.
		wait 1.
	}
	set prevthrust to ship:availablethrust.
	return true.
}

wait until ship:apoapsis > 99.5*1000.
print "apoapsis reached ~100km successfully".
lock throttle to 0.

wait until ship:altitude > 95000.
lock steering to up.
wait until ship:altitude < 70000.
until ship:stagenum = 0 {stage. wait 3.}
unlock steering.
print("program done!").