//sets the default values of the arguments if they aren't provided
//example usage of the arguments in the script for the default values is "run launchSuborbit(100000, 1.5)."
//the first argument being the target altitude in meters and the second being the rockets target acceleration value in thrust to weight
parameter targetAltitude is 100000, targetTWR is 1.5.

print "launching to " + targetAltitude + " apoapsis with twr of " + targetTWR.
wait 1.
stage.

//this is what calculates the twr to use based off of the current gravity at the altitude you are at
lock currentGravity to ship:orbit:body:mu/((ship:orbit:body:radius + ship:altitude)^2).
lock twr to ship:thrust/(ship:mass*currentGravity).

//this sets the throttle to the percentage needed to maintain the target twr
lock throttle to min(1,(targetTWR-twr)).
//this controls the steering and slowly tilts the rocket as it's apoapsis gets closer to the target altitude
lock steering to heading(90,(90-((ship:apoapsis/targetAltitude)*80))).

//this is what detects if a stage runs out of fuel and stages if it does so
set prevthrust to ship:availablethrust.
when ship:availablethrust < prevthrust then {
	print("staging! " + ship:stagenum).
	stage.
	wait 1.

	//this little part only happens so that you don't have to group the next stages ignation with the stage seperation
	//basically it stages a second time if it sees no thrusters that can provide thrust, either due to no fuel or no thrusters
	if ship:availablethrust < 0.1 {
		print("staging! " + ship:stagenum).
		stage.
		wait 1.
	}
	set prevthrust to ship:availablethrust.
	return true.
}

//this waits until the ships apoapsis has reached the target altitude before turning the engines off then prints the reached apoapsis altitude
wait until ship:apoapsis > targetAltitude.
print "apoapsis reached " + ship:apoapsis/1000 + "KM successfully".
lock throttle to 0.