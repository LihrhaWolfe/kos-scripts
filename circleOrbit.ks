parameter atApo is true.

runoncepath("lib/nodes.ks").

print("circulariztion commencing...").

if atApo {
    set newnode to nodecircle(node(time:seconds+ship:orbit:eta:apoapsis,0,0,0),100).
    set newnode to nodecircle(newnode,10).
    set newnode to nodecircle(newnode,1).
    set newnode to nodecircle(newnode,0.1).
    set newnode to nodecircle(newnode,0.01).
    donode(newnode).
} else {
    set newnode to nodecircle(node(time:seconds+ship:orbit:eta:periapsis,0,0,0),100).
    set newnode to nodecircle(newnode,10).
    set newnode to nodecircle(newnode,1).
    set newnode to nodecircle(newnode,0.1).
    set newnode to nodecircle(newnode,0.01).
    donode(newnode).
}

print("circulariztion complete!").