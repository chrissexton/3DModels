/** [base] **/
pinSize = 5;

include <BOSL2/std.scad>

module pin() {
    $fn=36;
    rad=pinSize/2;
    rotate([90, 0, 0])
    translate([0, 2+rad, 2.5])
    cyl(l=5.5, d=pinSize, chamfer2=0.75);
}

module front() {
    $fn=36;
    translate([0,1,7])
    cuboid([18, 2, 10], rounding=4, edges=[TOP+LEFT,TOP+RIGHT]);
}

module support() {
    wedge([2, 10, 8]);
}

module supports() {
    translate([4, 2, 2])
    support();
    translate([-6, 2, 2])
    support();
}

module bottom() {
    translate([-9, 0, 0])
    cube([18, 15, 2]);
}

module all() {
    union() {
        pin();
        front();
        bottom();
        supports();
    }
}

all();
