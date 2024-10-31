parameter targetAltitude is 100000, targetTWR is 1.5.

print "launching to " + targetAltitude + " apoapsis with twr of " + targetTWR.
wait 1.
stage.

lock currentGravity to ship:orbit:body:mu/((ship:orbit:body:radius + ship:altitude)^2).
lock twr to ship:thrust/(ship:mass*currentGravity).

lock throttle to min(1,(targetTWR-twr)).
lock steering to heading(90,(90-((ship:altitude/targetAltitude)*80))).

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

wait until ship:apoapsis > targetAltitude.
print "apoapsis reached " + ship:apoapsis/1000 + "KM successfully".
lock throttle to 0.