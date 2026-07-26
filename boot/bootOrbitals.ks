wait until ship:unpacked.
core:doevent("Open Terminal").

print "copying low kerbin orbit launch script...".
copypath("0:LKO.ks","launch.ks").

print "copying circle orbit script...".
copypath("0:circle.ks","circle.ks").

print "copying next node script...".
copypath("0:nextnode.ks","nnod.ks").

print "copying landing script...".
copypath("0:descent.ks","land.ks").

print "copying flight lib...".
copypath("0:lib/flight.ks","lib/flight.ks").

print "copying nodes lib...".
copypath("0:lib/nodes.ks","lib/nodes.ks").

print "copying complete!".

copypath("0:boot/bootTerminal.ks","boot/boot.ks").
set core:bootfilename to "boot.ks".