

//controls the descent rate of a craft at specified m/s until below height from ground in meters
function descentSpeed {
    parameter speed is 5, height is 5.

    set trgThrot to 0.
    lock currentGravity to ship:orbit:body:mu/((ship:orbit:body:radius + ship:altitude)^2).
    lock trgThrot to ((((ship:mass * currentGravity) / (ship:availablethrust+0.0001)))+(((ship:verticalspeed+speed)*-1)/10))-0.02.

    sas off.
    lock steerDir to srfretrograde + r((srfretrograde:pitch), srfretrograde:yaw, 0) + r(0.2,0,0).
    lock steering to steerDir.
    wait 1.
    wait until vectordotproduct(ship:facing:forevector,steerDir:forevector) < 1.
    lock decel to (ship:availablethrust / ship:mass).
    lock delay to (ship:velocity:surface:mag / decel).
    lock tti to (alt:radar/ship:verticalspeed)*-1.
    wait until tti <= delay.
    lock throttle to max(0, min(1, trgThrot)).
    wait until alt:radar < height.
    unlock steering.
    sas on.
    lock throttle to 0.

}

function killVelocity {
    sas off.
    lock steering to retrograde.
    wait until vectordotproduct(ship:facing:forevector,retrograde:forevector) < 1.
    lock throttle to 1.
    wait until ship:velocity:surface:mag <= 10.
    lock throttle to 0.
    unlock steering.
    sas on.
    wait 1.

}

function suicideBurn {
    sas off.
    lock steering to retrograde.

    lock decel to (ship:availablethrust / ship:mass).
    lock delay to (ship:velocity:surface:mag / decel).
    lock tti to (alt:radar/ship:verticalspeed)*-1.

    wait until tti <= delay.
    print "estimated burn duration = " + delay.
    killVelocity.
}