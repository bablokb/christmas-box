// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD) of the lid of the box.
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
  prismoid(size1=[x_top,y_top], 
           size2=[x_top,y_top],
           rounding=10,
           h=z_lid);
// remove comments if you don't print in vase-mode
//  translate([0,0,z_b]) prismoid(size1=[x_top-2*w4,y_top-2*w4], 
//           size2=[x_top-2*w4,y_top-2*w4],
//           rounding=10,
//           h=z_lid);
}