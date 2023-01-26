dia = 100;
height = 50;
width = 50;

include <BOSL2/std.scad>

module shim() {
    translate([25,0,25])
    difference() {
        tube(wall=5, od=dia, h=height);
        translate([-35, -50, -50])
        cube([100, 150, 100]);
    }
}

shim();