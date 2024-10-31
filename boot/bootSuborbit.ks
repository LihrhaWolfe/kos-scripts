wait until ship:unpacked.
core:doevent("Open Terminal").

print "copying suborbit launch script...".
copypath("0:/launchSuborbit.ks","launch.ks").

print "copying complete, ready to run launch.ks!".

copypath("0:boot/bootTerminal.ks","boot/boot.ks").
set core:bootfilename to "boot.ks".