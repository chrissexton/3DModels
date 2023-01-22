
include <BOSL2/std.scad>
include <BOSL2/gears.scad>

spur_gear(pitch=5, teeth=20, thickness=8, shaft_diam=5);
translate([24, 0, 0])
rotate([0,0,0])
spur_gear(pitch=5, teeth=10, thickness=8, shaft_diam=5);