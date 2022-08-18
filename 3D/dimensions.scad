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

// printer dimensions (walls)

fuzz = 0.01;
gap  = 0.1;
w06 = 0.6;               // vase-mode with wall-thickness 0.6mm
w2  = 0.86;              // 2 walls Prusa MK3S with 0.2mm layer-hight
w4  = 1.67;              // 4 walls Prusa MK3S with 0.2mm layer-hight

// outer shell

x_top = 140;
y_top = 120;
x_del = 18.3;
y_del = 18.3;
x_bot =  x_top - 2*x_del;
y_bot =  y_top - 2*y_del;
z_top =  100;
z_b   =  0.6;            // vase-mode 3 layers
z_lid =  16.5 + z_b;       // inner-hight + base

// inner plate

b_plate = 2.0;           // set leafe_gauge of hinges to this value as well

// hinges

x_hinges     = 30;
y_hinges     =  3;
x_hinges_off = 12;

// battery dimensions

x_bat = 64.0;
y_bat = 27.0;
z_bat = 19.0;
c_bat = 4.0;     // cutout

// inner shell

x_is = x_bot-w06 + (x_top-x_bot)*(z_bat+z_b)/z_top;  // linear interpolation
y_is = y_bot-w06 + (y_top-y_bot)*(z_bat+z_b)/z_top;  // of dimensions

// frame

x_frame = 100;
y_frame = 60;
b_frame = 0.6;                           // frame-base

// cutout connector

x_conn     = 18;
y_conn     =  5;
x_conn_off = -x_frame/2+55.5;
y_conn_off = y_top/2-w06-w2-y_conn;
