// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD) of the inner plate of the box.
//
// The plate will cover the hallows and will hold the inner-shell.
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/christmas-box
//
// -----------------------------------------------------------------------------

include <dimensions.scad>

h_walls = 10;

x_btn     =  6.1;
y_btn     = 13.1;
z_btn     =  6.0;
x_btn_off = x_top/2 - x_btn/2 - (x_top/2-x_is/2)/2;
y_btn_off = -y_btn/2;

x_hinge      = 30;
y_hinge      = b_plate;
x_hinge1_off = -x_top/2 + 10;
x_hinge2_off = x_top/2 - x_hinge - 10;
y_hinge_off  = y_top/2 - b_plate;

include <BOSL2/std.scad>

// --- rim with cutouts   ----------------------------------------------------

module rim() {
  difference() {
    prismoid(size1=[x_top,y_top],
           size2=[x_top,y_top],anchor=BOTTOM+CENTER,
           rounding=10,h=b_plate);
    prismoid(size1=[x_is,y_is],
           size2=[x_is,y_is],anchor=BOTTOM+CENTER,
           rounding=10,h=b_plate+fuzz);
    cuboid([x_conn,y_conn,b_plate+fuzz],              // cutout for cable
         p1=[-x_conn_off-x_conn,y_conn_off,0]);
    cuboid([x_btn,y_btn,b_plate+fuzz],                // cutout for button
         p1=[x_btn_off,y_btn_off,0]);
    cuboid([x_hinges+gap,b_plate+gap,b_plate+fuzz],            // cutout for hinge
         p1=[-x_top/2+x_hinges_off-gap/2,y_top/2-b_plate-gap,0]);
    cuboid([x_hinges+gap,b_plate+gap,b_plate+fuzz],            // cutout for hinge
         p1=[x_top/2-x_hinges_off-x_hinges-gap/2,y_top/2-b_plate-gap,0]);
  }
}

// --- inner wall to hold inner-shell   --------------------------------------

module inner_wall() {
  translate([0,0,b_plate-fuzz]) difference() {
    prismoid(size1=[x_is+2*w2,y_is+2*w2],
           size2=[x_is+2*w2,y_is+2*w2],anchor=BOTTOM+CENTER,
           rounding=10,h=h_walls);
    prismoid(size1=[x_is,y_is],
           size2=[x_is,y_is],anchor=BOTTOM+CENTER,
           rounding=10,h=h_walls);
  }
}

// --- outer wall to fit into the outer-shell   ------------------------------

// the wall has an offset of w06 and is w2 thick

module outer_wall() {
  translate([0,0,b_plate-fuzz]) difference() {
    prismoid(size1=[x_top-2*w06,y_top-2*w06],
           size2=[x_bot-2*w06,y_bot-2*w06],anchor=BOTTOM+CENTER,
           rounding=10,h=z_top);
    prismoid(size1=[x_top-2*w06-2*w2,y_top-2*w06-2*w2],
           size2=[x_bot-2*w06-2*w2,y_bot-2*w06-2*w2],anchor=BOTTOM+CENTER,
           rounding=10,h=z_top);
    translate([0,0,h_walls]) cuboid([x_top,y_top,z_top],
                                     anchor=BOTTOM+CENTER);  // remove everything above h_walls
  }
}

// --- button holder   -------------------------------------------------------

module btn_holder() {
  difference() {
    cuboid([x_btn+2*w2,y_btn+2*w2,z_btn],p1=[x_btn_off-w2,y_btn_off-w2,b_plate]);
    cuboid([x_btn,y_btn,z_btn+2*fuzz],p1=[x_btn_off,y_btn_off,b_plate-fuzz]);
  }
}

// --- main program   --------------------------------------------------------

rim();
inner_wall();
outer_wall();
btn_holder();
