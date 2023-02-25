// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD) of the inner-shell of the box.
//
// Note: printing in vase-mode is much faster, but if you need thicker walls,
//       use 0% infill.
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/christmas-box
//
// -----------------------------------------------------------------------------

include <dimensions.scad>

include <BOSL2/std.scad>

x_cable =  5;      // cutout for battery-cable
y_cable =  6;
z_cable = 25;
r_cable = 15;                   // rotation
o_cable = x_is/4+2*x_cable;     // offset


//note: gap subtracted here, because x_is/y_is is also used for inner-plate

difference() {
  prismoid(size1=[x_is-2*gap,y_is-2*gap],size2=[x_is-2*gap,y_is-2*gap],
           rounding=10,
           h=z_top-z_bat-z_b-0.6);
  xrot(r_cable,cp=[0,-y_is/2,0]) cuboid([x_cable,y_cable,z_cable],p1=[o_cable,-y_is/2,-2]);
}