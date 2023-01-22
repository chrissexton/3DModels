/** [General] **/
xSz = 100;
ySz = 50;

// one of: lid, pivot, all, printable
mode = "printable";

include <BOSL2/std.scad>

zSz=2;
$fn=36;

module lid() {
    union() {
        cuboid([xSz, ySz, zSz], rounding=5, except=[TOP,BOTTOM]);
        translate([xSz/2-zSz*2,0,-zSz])
        cuboid([zSz, ySz-zSz, zSz], rounding=1, edges=[FRONT,BACK]);
        translate([0, ySz/2-zSz, -zSz])
        cuboid([xSz-zSz*4, zSz, zSz], rounding=1, edges=[FRONT,BACK]);
        offset=5;
        translate([-xSz/2+offset,-ySz/2+offset,-zSz-1])
        cylinder(zSz, d=3);
    }
}

module pivot() {
    difference() {
        cuboid([ySz*0.2, xSz*0.2, zSz], rounding=2, except=[TOP,BOTTOM]);
        translate([-ySz*0.2/2+3,-xSz*0.2/2+3,-zSz+2])
        cylinder(zSz*2, d=3);
    }
}

module  all() {
    if (mode == "all") {
        translate([0,ySz,0])
        lid();
        pivot();
    } else if (mode == "printable") {
        translate([0,ySz/2,0])
        rotate([180,0,0])
        lid();
        translate([0, -ySz*0.2, 0])
        rotate([0,0,90])
        pivot();
    }
}

all();