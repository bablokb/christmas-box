// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD) of the outer-shell of the box.
//
// Note: printing in vase-mode is much faster, but if you need thicker walls,
//       you can change the code and print in normal mode (or use 0% infill).
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/christmas-box
//
// -----------------------------------------------------------------------------

include <dimensions.scad>

include <BOSL2/std.scad>

difference() {
  prismoid(size1=[x_bot,y_bot], 
           size2=[x_top,y_top],
           rounding=10,
           h=z_top);
// remove comments if you don't print in vase-mode
//  translate([0,0,b]) prismoid(size1=[x_bot-2*w4,y_bot-2*w4], 
//           size2=[x_top-2*w4,y_top-2*w4],
//           rounding=10,
//           h=h+fuzz);
  //translate([0,0,119]) cuboid([x_top,y_top,200]);   // print-test
}