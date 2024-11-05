wait until ship:unpacked.
core:doevent("Open Terminal").

print "copying circle orbit script...".
copypath("0:circleOrbit.ks","circle.ks").

print "copying next node script...".
copypath("0:nextnode.ks","nnod.ks").

print "copying nodes lib...".
copypath("0:lib/nodes.ks","lib/nodes.ks").

print "copying complete!".

copypath("0:boot/bootTerminal.ks","boot/boot.ks").
set core:bootfilename to "boot.ks".