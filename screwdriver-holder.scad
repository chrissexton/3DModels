/** [base] **/
nSmHoles = 0;
smHoleSize=8;
smCntrSnk=15;

nMdHoles = 5;
mdHoleSize=10;
mdCntrSnk=20;

nLgHoles = 0;
lgHoleSize=15;
lgCntrSnk=22;

holeDist=10;

rot=45;

$fn=48;

include <BOSL2/std.scad>

nominalH = 35;
backTabs = 20;
plateThickness = 5;
buffer=holeDist;

centerW = nLgHoles*(lgCntrSnk+holeDist)+nMdHoles*(lgCntrSnk+holeDist)+nSmHoles*(lgCntrSnk+holeDist)+buffer;

module back() {
    backW = centerW+2*backTabs;
    difference() {
        cuboid([backW, nominalH, plateThickness]);
        mountingHoles(backW);
    }
}

module mountingHoles(backW) {
    hs=4/2;
    hd=8;
    translate([(backW/2)-hd, nominalH/2-hd, -5])
    cylinder(plateThickness*2, r=hs);
    translate([(backW/2)-hd, -nominalH/2+hd, -5])
    cylinder(plateThickness*2, r=hs);
    translate([-(backW/2)+hd, nominalH/2-hd, -5])
    cylinder(plateThickness*2, r=hs);
    translate([-(backW/2)+hd, -nominalH/2+hd, -5])
    cylinder(plateThickness*2, r=hs);
}

module driverHoles() {
    startX=-centerW/2+lgCntrSnk/2+buffer;
    startY=nominalH/2;
    
    if (nLgHoles>0) {
        holeStep=lgCntrSnk+holeDist;
        for(i=[0 : nLgHoles-1]) {
            xPos=i*holeStep+startX;
            rotate([90, 0, 0])
            translate([xPos, startY, -nominalH/2-5])
            cylinder(nominalH+10, r=lgHoleSize/2);
            rotate([90, 0, 0])
            translate([xPos, startY, -nominalH/2-2])
            cylinder(5, r=lgCntrSnk/2);
        }
    }
    startX2=startX+nLgHoles*(lgCntrSnk+holeDist);
    if (nMdHoles>0) {
        holeStep=lgCntrSnk+holeDist;
        for(i=[0 : nMdHoles-1]) {
            xPos=i*holeStep+startX2;
            rotate([90, 0, 0])
            translate([xPos, startY, -nominalH/2-5])
            cylinder(nominalH+10, r=mdHoleSize/2);
            rotate([90, 0, 0])
            translate([xPos, startY, -nominalH/2-2])
            cylinder(5, r=mdCntrSnk/2);
        }
    }
    startX3=startX2+nMdHoles*(lgCntrSnk+holeDist);
    if (nSmHoles>0) {
        holeStep=lgCntrSnk+holeDist;
        for(i=[0 : nSmHoles-1]) {
            xPos=i*holeStep+startX3;
            rotate([90, 0, 0])
            translate([xPos, startY, -nominalH/2-5])
            cylinder(nominalH+10, r=smHoleSize/2);
            rotate([90, 0, 0])
            translate([xPos, startY, -nominalH/2-2])
            cylinder(5, r=smCntrSnk/2);
        }
    }
}

module center() {
    union() {
        difference() {
            translate([0,0,17.5])
            cuboid([centerW, nominalH, nominalH-5]);
            bore();
            driverHoles();
            bottomLip();
        }
        translate([centerW/2, 0, plateThickness/2])
        interior_fillet(l=nominalH, r=5, spin=-90, orient=BACK);
        translate([-centerW/2, 0, plateThickness/2])
        interior_fillet(l=nominalH, r=5, spin=90, orient=FRONT);
    }
}

module bottomLip() {
    translate([0, -nominalH/2, nominalH-5])
    cuboid([centerW+10, 10, 6]);
}

module bore() {
    translate([-centerW/2-2, 0, 5+nominalH/2+5])
    rotate([0, 90, 0])
    xscale(1.5)
    cylinder(centerW+5, r=nominalH/2.5);
}

module all() {
    zrot(rot)
    union() {
        back();
        center();
    }
}

all();