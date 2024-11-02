
// just does the node given
function donode {
	parameter nodetodo.
	
	if not nodetodo:istype("node") {return "node passed isn't of type node.".}
	if not hasnode {add nodetodo.}
	wait 1.
	
	sas off.
	print "node burn time is " + nodetodo:burnvector:mag/(ship:availablethrust/ship:mass) + " seconds"
	print "starting warp to node...".
	kuniverse:timewarp:warpto(nodetodo:time - ((nodetodo:burnvector:mag/(ship:availablethrust/ship:mass))/2) - 60).
	lock steering to nodetodo:burnvector.
	print "steering to face node...".
	wait until (nodetodo:time - ((nodetodo:burnvector:mag/(ship:availablethrust/ship:mass))/2) <= time:seconds).
	lock throttle to min(1, nodetodo:burnvector:mag/10 + 0.05).
	set prevMag to nodetodo:burnvector:mag + 10.
	until nodetodo:burnvector:mag > prevMag {
		set prevMag to nodetodo:burnvector:mag.
		wait 0.05.
	}
	remove nodetodo.
	
	return "node Complete!".
}

// tunes a node to make a circular orbit
function nodecircle {
	parameter thisnode is node(time:seconds+ship:orbit:eta:apoapsis,0,0,0), scale is 1.
	
	add thisnode.
	set prevecn to thisnode:orbit:eccentricity.
	remove thisnode.
	
	set adjustlist to list().
	//adjustlist:add({set newthisnode:time to thisnode:time+scale.}).
	//adjustlist:add({set newthisnode:time to thisnode:time-scale.}).
	//adjustlist:add({set newthisnode:radialout to thisnode:radialout+scale.}).
	//adjustlist:add({set newthisnode:radialout to thisnode:radialout-scale.}).
	//adjustlist:add({set newthisnode:normal to thisnode:normal+scale.}).
	//adjustlist:add({set newthisnode:normal to thisnode:normal-scale.}).
	adjustlist:add({set newthisnode:prograde to thisnode:prograde+scale.}).
	adjustlist:add({set newthisnode:prograde to thisnode:prograde-scale.}).
	
	// start tuning the node
	until false {
		//print(thisnode).
		set newthisnode to node(thisnode:time,thisnode:radialout,thisnode:normal,thisnode:prograde).
		set bestthisnode to node(thisnode:time,thisnode:radialout,thisnode:normal,thisnode:prograde).
		for adjustment in adjustlist {
			
			add bestthisnode.
			set bestthisnodeecn to bestthisnode:orbit:eccentricity.
			remove bestthisnode.
			
			adjustment().
			print(newthisnode).
			
			add newthisnode.
			
			// set bestthisnode to newthisnode if ecn is less
			print(bestthisnodeecn-newthisnode:orbit:eccentricity).
			if bestthisnodeecn > newthisnode:orbit:eccentricity {
				set bestthisnode to node(newthisnode:time,newthisnode:radialout,newthisnode:normal,newthisnode:prograde).
				print("did").
			}
			
			remove newthisnode.
			//print(bestthisnode).
			
		}
		print("---").
		print(bestthisnode).
		print("===").
		set thisnode to bestthisnode.
		wait 0.
		
		add thisnode.
		if thisnode:orbit:eccentricity >= prevecn {remove thisnode. return thisnode.}
		set prevecn to thisnode:orbit:eccentricity.
		remove thisnode.
	}
	
}

