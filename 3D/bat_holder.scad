// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD) of the battery-holder
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/christmas-box
//
// -----------------------------------------------------------------------------

include <dimensions.scad>

include <BOSL2/std.scad>

module walls() {
  union() {
    translate([0,-y_bat/2,0]) cuboid([2*x_bot,w2,z_bat]);
    translate([0,y_bat/2,0]) cuboid([2*x_bot,w2,z_bat]);
    translate([-x_bat/2,0,0]) cuboid([w2,2*y_bot,z_bat]);
    translate([x_bat/2,0,0]) cuboid([w2,2*y_bot,z_bat]);
  }
}

difference() {
  intersection() {
    translate([0,0,z_bat/2]) walls();
    prismoid(size1=[x_bot-w06,y_bot-w06], 
           size2=[x_top-w06,y_top-w06],
           rounding=10,
           h=h_top+z_b);
  }
  translate([x_bat/2-fuzz,y_bat/2-1.25*c_bat,z_bat/2+c_bat]) cuboid([w2+2*fuzz,c_bat,z_bat]);
  translate([x_bat/2+0.5*(x_bot/2-x_bat/2),-y_bat/2,z_bat/2+c_bat]) cuboid([c_bat,w2+2*fuzz,z_bat]);
}
