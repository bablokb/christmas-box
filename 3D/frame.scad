// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD) of the frame for the display and speaker.
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/christmas-box
//
// -----------------------------------------------------------------------------

include <dimensions.scad>

include <BOSL2/std.scad>

frame_o = 10;                              // frame-offset
frame_x = x_top - 2*frame_o;
frame_y = y_top - 2*frame_o;
frame_b =   0.8;                           // frame-base

spk_di     = 28.2;                         // speaker, inner diameter
spk_do     = spk_di + 2*w4;                // speaker, outer diameter
spk_off    = 3.0;                          // offset
spk_h      = 4.4;                          // hight

disp_xo     = 58.0;                        // display, outer dimensions
disp_yo     = 46.0;
disp_zo     =  2.9;
disp_off_xo = (frame_x - (disp_xo+spk_off+spk_do))/2;  // display-offsets
disp_off_yo = (frame_y - disp_yo)/2;

disp_xi     = 44.5;                        // display, innerer dimensions
disp_yi     = 34.2;
disp_zi     =  2.9+frame_b+fuzz;
disp_off_xi = disp_off_xo + 6.9;
disp_off_yi = disp_off_yo + (disp_yo-disp_yi)/2;

disp_pin_x  = 6.9;                         // cutout for display-pins
disp_pin_y  = 23;
disp_pin_z  = 1.3;

spk_grid_x = frame_x-disp_off_xo-disp_xo-2*spk_off;
spk_grid_y = disp_yo;

module solids() {
  cuboid([frame_x,frame_y,frame_b],p1=[0,0,0]);                      // base
  color("blue") cuboid([disp_xo,disp_yo,disp_zo],                    // display-support
              p1=[disp_off_xo,disp_off_yo,frame_b]);   
  color("blue") translate([disp_off_xo+disp_xo+spk_off+spk_do/2,     // speaker-support
                           frame_y/2-(disp_yo-disp_yi)/2,frame_b])
                   cylinder(d=spk_do,h=spk_h,center=false);
}

module spk_grid() {
  grid2d(size=[spk_grid_x,spk_grid_y], spacing=5, stagger="alt") cylinder(d=3, h=frame_b+fuzz);
}


module cutouts() {
  cuboid([disp_xi,disp_yi,disp_zi],                                  // display
              p1=[disp_off_xi,disp_off_yi,0]);
  cuboid([disp_pin_x,disp_pin_y,disp_pin_z],                         // display-pins
              p1=[disp_off_xi+disp_xi,disp_off_yi+(disp_yi-disp_pin_y)/2,disp_zi-disp_pin_z+fuzz]);
  translate([disp_off_xo+disp_xo+spk_off+spk_di/2+w4,                // speaker
                           frame_y/2-(disp_yo-disp_yi)/2,frame_b])
                   cylinder(d=spk_di,h=spk_h+frame_b+fuzz,center=false);
  translate([disp_off_xo+disp_xo+spk_grid_x/2+spk_off,              // speaker-grid
                           frame_y/2,0]) spk_grid();
}

difference() {
  solids();
  cutouts();
}