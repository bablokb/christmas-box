// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD) of the pico-holder.
//
// This holder is glued into the outer shell to fix the pico.
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/christmas-box
//
// -----------------------------------------------------------------------------

include <dimensions.scad>

include <BOSL2/std.scad>

b_pico   =  1.2;
x_pico   = 53.0;
y_pico   =  1.4;
w_pico   =  6.2-w2;
z1_pico  =  3.2;
z2_pico  = 18.0;
x_cutout = 10;

x = x_pico+2*w2;
y = y_pico+2*w2;


difference() {
  union() {
    cuboid([x,y,b_pico+z2_pico],anchor=BOTTOM+CENTER);               // main body
    cuboid([x,w_pico,b_pico+z2_pico],                                // back wall
            p1=[-x/2,y/2,0]);
  }
  up(b_pico) cuboid([x_pico,y_pico,z2_pico],anchor=BOTTOM+CENTER);   // cutout for pico
  cuboid([x,w2+2*fuzz,z2_pico-z1_pico+fuzz],                         // cutout front
         p1=[-x/2,-y/2,b_pico+z1_pico]);
  cuboid([x_cutout,w_pico+w2+fuzz,b_pico+z2_pico],                   // cutout back
         p1=[-x/2+w2,y/2-w2,0]);
}
