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

spk_di     = 28.2;                         // speaker, inner diameter
spk_do     = spk_di + 2*w4;                // speaker, outer diameter
spk_off    = 3.0;                          // offset
spk_h      = 4.4;                          // hight

disp_xo     = 58.0;                        // display, outer dimensions
disp_yo     = 46.0;
disp_zo     =  2.9;
disp_off_xo = -(disp_xo+spk_off+spk_do)/2;   // display-offsets
disp_off_yo = -disp_yo/2;

disp_xi     = 44.5;                        // display, innerer dimensions
disp_yi     = 34.2;
disp_zi     =  2.9+b_frame+fuzz;
disp_off_xi = disp_off_xo + 6.9;
disp_off_yi = disp_off_yo + (disp_yo-disp_yi)/2;

disp_pin_x  = 6.9;                         // cutout for display-pins
disp_pin_y  = 23;
disp_pin_z  = 1.3;

spk_grid_x = disp_yo;
spk_grid_y = disp_yo;

// --- supports for display and speaker   ------------------------------------

module supports() {
  cuboid([disp_xo,disp_yo,disp_zo],                    // display-support
          p1=[disp_off_xo,disp_off_yo,b_frame]);   
  translate([disp_off_xo+disp_xo+spk_off+spk_do/2,     // speaker-support
             -(disp_yo-disp_yi)/2,b_frame])
     cylinder(d=spk_do,h=spk_h,center=false);
}

// --- speaker-grid coutouts   -----------------------------------------------

module spk_grid() {
  grid2d(size=[spk_grid_x,spk_grid_y],spacing=5,stagger="alt")
      cylinder(d=3,h=b_frame+fuzz);
}

// --- cutouts for display, speaker, speaker-grid   --------------------------

module cutouts() {
  cuboid([disp_xi,disp_yi,disp_zi],                                  // display
              p1=[disp_off_xi,disp_off_yi,0]);
  cuboid([disp_pin_x,disp_pin_y,disp_pin_z],                         // display-pins
              p1=[disp_off_xi+disp_xi,disp_off_yi+(disp_yi-disp_pin_y)/2,disp_zi-disp_pin_z+fuzz]);
  translate([disp_off_xo+disp_xo+spk_off+spk_di/2+w4,                // speaker
                           -(disp_yo-disp_yi)/2,b_frame])
                   cylinder(d=spk_di,h=spk_h+b_frame+fuzz,center=false);
  translate([disp_off_xo+disp_xo+spk_grid_x/2+spk_off,              // speaker-grid
                           0,0]) spk_grid();
  cuboid([x_conn,y_conn,b_frame+fuzz],
         p1=[x_conn_off,y_conn_off,0]);
}

// --- base-module: plate + wall   --------------------------------------------

module base() {
  prismoid(size1=[x_top,y_top],
           size2=[x_top,y_top],anchor=BOTTOM+CENTER,
           rounding=10,h=b_frame);
  translate([0,0,b_frame]) difference() {
    prismoid(size1=[x_top-2*w06,y_top-2*w06],
             size2=[x_top-2*w06,y_top-2*w06],anchor=BOTTOM+CENTER,
             rounding=10,h=z_lid-z_b-1);
    prismoid(size1=[x_top-2*w06-2*w2,y_top-2*w06-2*w2],
             size2=[x_top-2*w06-2*w2,y_top-2*w06-2*w2],anchor=BOTTOM+CENTER,
             rounding=10,h=z_lid-z_b-1);
  }
}

// --- final frame: base + supports - cutouts   ---------------------------------

module frame() {
  difference() {
    union() {
      base();
      supports();
    }
    cutouts();
  }
}

frame();