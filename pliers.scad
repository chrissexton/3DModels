/** [base] **/
nHoles = 7;

include <BOSL2/std.scad>

// Hole sizes
hx = 10;
hy = 30;
hz = 35;
inset=10;

// Back sizes
edges = 5;
sx = 35;
sy = (hy)*nHoles+edges*4;
sz = 5;

rounding=5;
$fn=48;

module back() {
    holeInset=5;
    holeDia=4;
    difference() {
        cuboid([sx,sy,sz]);
        translate([sx/2-holeInset, sy/2-holeInset, -holeInset])
        cylinder(20, d=holeDia);
        translate([-sx/2+holeInset, sy/2-holeInset, -holeInset])
        cylinder(20, d=holeDia);
        translate([sx/2-holeInset, -sy/2+holeInset, -holeInset])
        cylinder(20, d=4);
        translate([-sx/2+holeInset, -sy/2+holeInset, -holeInset])
        cylinder(20, d=4);
    }
}

module hole() {
    yrot(90)
    left(inset/4)
    cuboid([hz-inset, hy-inset, hx+inset*4], rounding=rounding);
}

module top() {
    up(0.5*hy+sz)
    difference() {
        cuboid([hx, hy*nHoles+inset, hz], rounding=rounding, edges=[RIGHT+FRONT, LEFT+FRONT, RIGHT+BACK, LEFT+BACK, BACK, FRONT]);
        translate([0,nHoles*hy/2-inset*1.5,0])
        for(i=[0 : nHoles-1]) {
            fwd(hy*i)
            hole();
        }
    }
}

module all() {
    union() {
        back();
        top();
    }
}

all();