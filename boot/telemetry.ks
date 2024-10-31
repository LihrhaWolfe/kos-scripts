wait until ship:unpacked.
core:doevent("Open Terminal").
print("telemetry booting...").
wait 3.

until false {
	print("press 'ctrl+c' to stop telemetry.").
	print("twr: " + ship:thrust/(ship:mass*constant:g0)).
	print("dv: " + ship:stagedeltav(ship:stagenum):current).
	print("ap: " + ship:apoapsis).
	print("pe: " + ship:periapsis).
	if hastarget {
		if target:istype("part") {
			print("dist to target: " + (ship:controlpart:position-target:position):mag).
		}
		if target:istype("vessel") {
			print("dist to target: " + (ship:controlpart:position-target:orbit:position):mag).
		}
	}
	wait 1.
	clearscreen.
}