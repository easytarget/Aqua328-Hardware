// Juwel Rekord600 fittings
$fn=90;

pcbX=150; 
pcbY=90;
pcbZ=8;
base=1.5; // base thickness
walls=2;  // wall thickness
tall=40;  // wall height
lidZ=8;    //thickness for lid piece
pcbOffset=25;
pcbHoleX=70;
pcbHoleY=70;
screenX=71; // Size of screen cutout, horizontal
screenY=24; // Size of screen cutout, vertical
screenpcbX=pcbY; // screen Vertical (min. 80)
screenpcbY=38; // screen Horizontal (total)
screenXoffset=(-pcbX/2)+screenpcbY+walls*2;

case();
*translate([0.1,0,tall+0.1]) {
    color("LightBlue",0.5) 
    linear_extrude(lidZ) lid();
}
*translate([0,0]) lid();

module case() {
// Base
    linear_extrude(base) difference() {
        minkowski() {
            square([pcbX,pcbY],center=true);
            circle(r=walls*2);
        }
        hull() {
            for (x=[-40,-65],y=[-40,40])
                translate([x,y]) circle(d=8);
        }
        for (x=[-22,68],y=[-24,24])
            translate([x,y]) circle(d=4);
   }
// Walls
    difference() {
        linear_extrude(tall,convexity=5) difference() {
            minkowski() {
                square([pcbX,pcbY],center=true);
                circle(r=walls*2);
            }
            minkowski() {
                square([pcbX,pcbY],center=true);
                circle(r=walls);
            }
        }
    // Power Inlet
        translate([54,-pcbY/2,pcbZ+9]) minkowski() {
            cube([16,10,10],center=true);
            sphere(r=1);
        }
    // Switch
        translate([-55,-pcbY/2,pcbZ+9]) minkowski() {
            cube([10.5,8,10],center=true);
            sphere(r=1);
        }
    }
// PCB Pins
    linear_extrude(pcbZ) {
        xa=(pcbHoleX/2)+pcbOffset;
        xb=(-pcbHoleX/2)+pcbOffset;
        ya=pcbHoleY/2;
        yb=-pcbHoleY/2;
        for (x=[xa,xb],y=[ya,yb]) {
            translate([x,y]) difference() {
                circle(d=8);
                circle(d=3.5, $fn=6);
            } 
        } 
    }
 // Screen mount vertical section
    translate([screenXoffset,0,tall])
    linear_extrude(lidZ,convexity=5) {
        translate([(-screenpcbY-walls*4)/2,0])
        difference() {
            minkowski() {
                square([screenpcbY,screenpcbX],center=true);
                circle(walls*2);
            }
            minkowski() {
                square([screenpcbY,screenpcbX],center=true);
                circle(walls);
            }
        }
    }
// Screen mount 'neck'
    translate([screenXoffset,0,tall+lidZ])
    rotate([90,0,180])
    rotate_extrude(angle=45,convexity=5,$fn=120) {
        translate([(screenpcbY+walls*4)/2,0])
        difference() {
            minkowski() {
                square([screenpcbY,screenpcbX],center=true);
                circle(walls*2);
            }
            minkowski() {
                square([screenpcbY,screenpcbX],center=true);
                circle(walls);
            }
        }
    }
// Screen mount faceplate
    translate([screenXoffset,0,tall+lidZ])
    rotate([0,45,0])
    linear_extrude(height=walls*1.5,convexity=5) {
        translate([(-screenpcbY-walls*4)/2,0])
        difference() {
            minkowski() {
                square([screenpcbY,screenpcbX],center=true);
                circle(walls*2);
            }
            minkowski() {
                square([screenY,screenX],center=true);
                circle(0.5);
            }
        }
    }
// Internal Wall
    translate([screenXoffset-walls,-pcbY/2-walls,0])
    cube([walls*2,15,tall]);
    translate([screenXoffset-walls,pcbY/2+walls-15,0])
    cube([walls*2,15,tall]);
    translate([screenXoffset-walls,-10,0])
    cube([walls*2,20,tall]);
    translate([screenXoffset-walls,-pcbY/2,tall-2])
    cube([walls*2,pcbY,2]);
// lid brackets
    translate([screenXoffset,-pcbY/2-walls,0]) 
    difference() {
        linear_extrude(tall,scale=4) minkowski() {
            square([2,2]);
            circle(0.5);
        }
        translate([5,5,tall-12]) 
        cylinder(d=3.5,h=13,$fn=6);
    }
    translate([screenXoffset,pcbY/2+walls,0])
    difference() {
        linear_extrude(tall,scale=4) minkowski() {
            translate([0,-2]) square([2,2]);
            circle(0.5);
        }
        translate([5,-5,tall-12]) 
        cylinder(d=3.5,h=13,$fn=6);
    }
    translate([pcbX/2+walls,-pcbY/2-walls,0])
    difference() {
        linear_extrude(tall,scale=4) minkowski() {
            translate([-2,0]) square([2,2]);
            circle(0.5);
        }
        translate([-5,5,tall-15]) 
        cylinder(d=3.5,h=16,$fn=6);
    }
    translate([pcbX/2+walls,pcbY/2+walls,0])
    difference() {
        linear_extrude(tall,scale=4) minkowski() {
            translate([-2,-2]) square([2,2]);
            circle(0.5);
        }
        translate([-5,-5,tall-12]) 
        cylinder(d=3.5,h=13,$fn=6);
    }
}

module lid() {
    translate([screenXoffset+walls,-pcbY/2-walls]) difference() {
        minkowski() {
            square([pcbX/2-screenXoffset,pcbY+walls*2]);
            circle(walls);
        }
        translate([5-walls,5])
        circle(d=4.3);
        translate([5-walls,pcbY+walls*2-5])
        circle(d=4.3);
        translate([pcbX/2-screenXoffset-5,5])
        circle(d=4.3);
        translate([pcbX/2-screenXoffset-5,pcbY+walls*2-5])
        circle(d=4.3);
    }
}
