// station manager script
wait until ship:unpacked.
core:doevent("Open Terminal").

// do alignment 
when ship:controlpart <> ship:partstagged("station core probe")[0] then {
	unlock steering.
	sas on.
	ship:partstagged("station core probe")[0]:controlfrom().
	return true.
}
when ship:controlpart = ship:partstagged("station core probe")[0] then {
	sas off.
	lock steering to r(270,0,-sun:rotationangle-90).
	return true.
}

// general setup before loop
print "press 'ctrl+c' to stop station manager."
.

// main loop
until false {
	wait 5.
}