parameter stop is true, speed is 2, height is 2.

runoncepath("lib/flight.ks").

print "preping burn to slow down...".

if stop {suicideBurn().}

print "commencing touchdown on surface of " + ship:orbit:body:name.

descentSpeed(speed,height).

print "touchdown complete".