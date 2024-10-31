parameter targetAltitude is 100000, targetTWR is 1.5.

print "launching to " + targetAltitude + " apoapsis with twr of " + targetTWR.
sas off.
wait 1.
stage.

lock currentGravity to ship:orbit:body:mu/((ship:orbit:body:radius + ship:altitude)^2).
lock twr to ship:thrust/(ship:mass*currentGravity).

lock throttle to throttle + min(1,(targetTWR-twr)/10).
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
unlock steering.
sas on.

run circle.ks(true).

wait until eta:apoapsis < 16.
print "starting orbit burn...".
sas off.
lock steering to heading(90,max(90-((ship:altitude/1000)*9),0)).
lock throttle to 1. 

wait until ship:periapsis > 75*1000.
print "orbit reached!".
unlock steering.
sas on.