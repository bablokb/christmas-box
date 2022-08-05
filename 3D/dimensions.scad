// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD) of the christmas-box.
//
// This file defines various dimensions and is included in other scad-scripts.
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/christmas-box
//
// -----------------------------------------------------------------------------

$fa = 1;
$fs = 0.5;
//$fn = 96;

fuzz = 0.01;
w06 = 0.6;               // vase-mode with wall-thickness 0.6mm
w2  = 0.86;              // 2 walls Prusa MK3S with 0.2mm layer-hight
w4  = 1.67;              // 4 walls Prusa MK3S with 0.2mm layer-hight

x_top = 140;
y_top = 120;
x_del = 18.3;
y_del = 18.3;
x_bot =  x_top - 2*x_del;
y_bot =  y_top - 2*y_del;
z_top =  100;
z_b   =  0.6;            // vase-mode 3 layers
z_lid =  16.5 + z_b;       // inner-hight + base

// battery dimensions

x_bat = 64.0;
y_bat = 27.0;
z_bat = 19.0;
c_bat = 4.0;     // cutout

