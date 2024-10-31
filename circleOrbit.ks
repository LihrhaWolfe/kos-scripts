runoncepath("lib/nodes.ks").

print("circulariztion commencing...").

set newnode to nodecircle(node(time:seconds+ship:orbit:eta:apoapsis,0,0,0),10).
set newnode to nodecircle(newnode,1).
set newnode to nodecircle(newnode,0.1).
donode(newnode).

print("circulariztion complete!").