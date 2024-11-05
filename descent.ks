parameter speed is 5, height is 5.

runoncepath("lib/flight.ks").

print "preping burn to slow down...".

suicideBurn().

print "commencing touchdown on surface of " + ship:orbit:body:name.

descentSpeed(speed,height).

print "touchdown complete".