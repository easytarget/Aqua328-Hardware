// 1602 lcd filler
$fn=90;
linear_extrude(3) {
    difference() {
        translate([1,-1.5]) minkowski() {
            square([71,27]);
            circle(r=1);
        }
        translate([0,-0.2]) square([71.2,24.4]);
    }
}
