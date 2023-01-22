/** [base] **/
radius = 25;
fragments=4;

include <BOSL2/std.scad>

module ball() {
    $fn=fragments;
    translate([0,0,radius])
    spheroid(radius, style="icosa");
}
ball();