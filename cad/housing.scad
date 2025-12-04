include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

use <keycap.scad>;

Left = true;
Right = true;
Both = Left && Right;

Bottom = true;
Plate = true;
Keycaps = false;

$fn = 32;

/* [Hidden] */

z_offset = 6.3;
angle = 3.2;
h = z_offset * 2;

module outline(a = angle, half = -1) {
    projection() {
        rotate(a = a, v = [1, 0, 0]) 
        import(half == -1 ? "left-blank.stl" : "right-blank.stl", center = true);
    }
}

function holes(half) = half == -1 ? [[22.3625,10.872851],[-1.0375,-23.927149],[-53.75,-8.002149],[3.8125,52.972851],[36.05,-37.602149],[-53.85,29.997851],[69.55,-10.102149],[-15.6,13.397851]] : [[-68.688375,-8.102149],[-36.103996,-37.175354],[1.161625,-22.802149],[53.796004,-7.675354],[-3.788375,53.947851],[-21.703996,15.624646],[53.796004,30.424646],[15.711625,14.297851]];
function switches(half) = half == -1 ? [[12,-13.313328],[-26.1,5.736672],[31.05,39.074172],[21.525,-41.888328],[-7.05,29.549172],[31.05,0.974172],[-64.2,-18.075828],[-45.15,39.074172],[-45.15,-18.075828],[12,5.736672],[-26.1,24.786672],[31.05,20.024172],[12,43.836672],[-45.15,20.024172],[-7.05,-8.550828],[-26.1,-13.313328],[-7.05,48.599172],[-45.15,0.974172],[-26.1,43.836672],[12,24.786672],[-64.2,39.074172],[-7.05,10.499172],[-64.2,0.974172],[31.05,-18.075828],[2.475,-37.125828],[-64.2,20.024172]] : [[62.473125,20.360672],[5.323125,29.885672],[62.473125,1.310672],[-13.726875,25.123172],[62.473125,-17.739328],[5.323125,-8.214328],[43.423125,20.360672],[24.373125,44.173172],[-13.726875,44.173172],[-23.251875,-41.551828],[24.373125,25.123172],[-4.201875,-36.789328],[24.373125,-12.976828],[43.423125,39.410672],[5.323125,48.935672],[-13.726875,6.073172],[-32.776875,20.360672],[-32.776875,39.410672],[-32.776875,-17.739328],[43.423125,1.310672],[62.473125,39.410672],[-13.726875,-12.976828],[43.423125,-17.739328],[-32.776875,1.310672],[24.373125,6.073172],[5.323125,10.835672]];
function rotated_switches(half) = half == -1 ? [[51.973396,-29.39227],[44.683275,-46.992176]] : [[-52.537292,-28.928579],[-45.247172,-46.528485]];

module bottom(half = -1) {
    holes = holes(half);
    difference() {
        linear_extrude(height = h) 
        difference() {
            minkowski() {
                outline(half = half);
                circle(r = 1);
            }

            outline(half = half);
        }

        translate(v = [0, 0, h + 2.32])
        rotate(a = angle, v = [1, 0, 0]) 
        cube(size = [200, 200, h], center = true);

        translate(v = [0, 0, z_offset]) 
        rotate(a = angle, v = [1, 0, 0]) {
            // TRRS
            translate(v = [half * -69.074, 9.5, -0.8])
            rotate(a = 90, v = [1, 0, 0])  
            cylinder(h = 5, d = 5, center = true);

            // USB-C
            translate(v = [half * -53.672, 9.5, -2.15]) 
            rotate(a = 90, v = [1, 0, 0]) 
            linear_extrude(height = 5, center = true) 
            minkowski() {
                square(size = [6.5, .75], center = true);
                circle(r = 1.25);
            }

            // Switch
            translate(v = [half * -35.374, 52.5, -1.9])
            cube(size = [7, 5, 3], center = true);
        }
    }

    linear_extrude(height = 1) 
    minkowski() {
        outline(half = half);
        circle(r = 1);
    }

    difference() {
        rotate(a = angle, v = [1, 0, 0]) 
        for (hole = holes) {
            difference() {
                translate(v = [hole.x, hole.y, z_offset - h + .8])
                cylinder(r = 2.2, h = h);

                translate(v = [hole.x, hole.y, z_offset - 3]) 
                screw_hole("M2x0.4,8", thread = true);
            }
        }

        translate(v = [0, 0, -z_offset]) 
        cube(size = [200, 200, h], center = true);
    }
}

module plate(half = -1) {
    holes = holes(half);
    switches = switches(half);
    rotated_switches = rotated_switches(half);

    difference() {
        linear_extrude(height = 2.5) 
        difference() {
            minkowski() {
                outline(half = half);
                circle(r = 1);
            }

            for (switch = switches) {
                translate(v = [switch.x + 0.9, switch.y + 0.5])
                square(size = [14, 14], center = true);
            }

            for (switch = rotated_switches) {
                translate(v = switch) 
                rotate(a = half * 22.5, v = [0, 0, 1]) 
                square(size = [14, 14], center = true);
            }
        }

        translate(v = [0, 0, -1]) {
            linear_extrude(height = 2.5) {
                translate(v = [half*-68.5, 0])
                circle(r = 6);
            }

            linear_extrude(height = 3) {
                translate(v = [half*-60.5, -18.5])
                circle(r = 2);

                translate(v = [half*-35, 49.5]) 
                square(size = [16, 4], center = true);
            }
        }

        for (hole = holes) {
            translate(v = hole)
            cylinder(d = 2, h = 10, center = true);

            translate(v = [hole.x, hole.y, 2]) 
            cylinder(d = 4, h = 2, center = true);
        }
    }
}

module keycaps(half = -1) {
    switches = switches(half);
    rotated_switches = rotated_switches(half);

    for (switch = switches) {
        translate(v = [switch.x, switch.y, 9])
        keycap();
    }

    for (switch = rotated_switches) {
        translate(v = [switch.x, switch.y, 9])
        rotate(a = 22.5 * half, v = [0, 0, 1]) 
        keycap();
    }
}

for (half = Both ? [-1, 1] : Left ? -1 : Right ? 1 : []) {
    rotate(a = Both ? 10 : 0, v = [0, 0, half]) 
    translate(v = [Both ? 90 * half : 0, 0]) {
        if (Bottom) {
            color("#444")
            bottom(half);
        }

        if (Plate) {
            color(c = "#888") 
            translate(v = [0, 0, Bottom ? z_offset + 2.32 : 0]) 
            rotate(a = Bottom ? angle : 0, v = [1, 0, 0])
            plate(half);
        }

        if (Keycaps) {
            color(c = "#89aa") 
            translate(v = [0, 0, Bottom ? z_offset + 2.32 : 0]) 
            rotate(a = Bottom ? angle : 0, v = [1, 0, 0])
            keycaps(half);
        }
    }
}