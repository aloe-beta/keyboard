$fn = 128;

r1 = 1;
r2 = 2;
r3 = 75;

w1 = 18;
w2 = 15;

a = 5;

o = 1.1;
h = 2;

q1 = 0.5;
q2 = 1.25;

module cap(w1, w2, r1, r2, r3, h, q1, q2 = 0) {
    difference() {
        hull() {
            translate(v = [0, 0, q2 > 0 ? -.25 : 0]) 
            linear_extrude(height = q2 > 0 ? .5 : .25) 
            minkowski() {
                square(size = [w1 - (r1 + q2)*2, w1 - (r1 + q2)*2], center = true);
                circle(r = r1);
            }

            translate(v = [0, 0, h + q1 - q2]) 
            rotate(a = -a, v = [1, 0, 0]) 
            linear_extrude(height = .25) 
            minkowski() {
                square(size = [w2 - (r2 + q2)*2, w2 - (r2 + q2)*2], center = true);
                circle(r = r2);
            }
        }

        rotate(a = -a, v = [1, 0, 0]) 
        translate(v = [0, 0, r3 + h - q2]) 
        sphere(r = r3);
    }
}

module keycap(r1 = 1, r2 = 2, r3 = 75, w1 = 18, w2 = 15, a = 5, o = 1.1, h = 2, q1 = 0.5, q2 = 1.25) {
    translate(v = [0, 0, -4]) 
    linear_extrude(height = 4) 
    difference() {
        minkowski() {
            group() {
                square(size = [4, 1.28], center = true);
                square(size = [1.1, 4], center = true);
            }

            circle(r = .75);
        }

        square(size = [4, 1.28], center = true);
        square(size = [1.1, 4], center = true);
    }

    translate(v = [0, 0, -o]) 
    difference() {
        cap(w1, w2, r1, r2, r3, h, q1);
        cap(w1, w2, r1, r2, r3, h, q1, q2);
    }
}

keycap(r1, r2, r3, w1, w2, a, o, h, q1, q2);