$fn=36;

include <note.scad>
include <board/H310M-STX.scad>
include <body.scad>
include <parts/speaker.scad>
include <parts/usb_type_a_port_single.scad>
include <parts/hdmi_type_a_port_180788.scad>
include <parts/touchpad_D1.scad>
include <common/fan_guard_blank.scad>

space = 50;


display_front_thickness = 3;
display_middle_thickness = 5;
display_rear_thickness = 3;

//display
translate([space * 10, 0, 0])
{
  translate([0, space * 0, 0])
  rotate([180, 0, 0])
  display_front(display_front_thickness);

  translate([0, space * 5, 0])
  rotate([180, 0, 0])
  {
    display_middle_top(display_middle_thickness);
    display_middle_bottom(display_middle_thickness, t);
    translate([t, 0, 0])
    display_middle_right(display_middle_thickness);
    translate([-t, 0, 0])
    display_middle_left(display_middle_thickness);
  }

  translate([0, space * 10, 0])
  rotate([180, 0, 0])
  display_rear(display_rear_thickness);
}


//body
body_bottom_side(t);

translate([-space, 0, 0])
rotate(90)
body_left_side(t);

translate([body_inner_size[0] + space + height, 0, 0])
rotate(90)
difference()
{
  body_right_side(t);

  translate([t, 0, 0])
  {
    translate([mother_size[1] - (block_size / 2) - 15, 34, 0])
    usb_type_a_port_single_blank(t);

    translate([33, 10, 0])
    lcd_controller_switch_blank(t);

    //power switch
    translate([body_inner_size[1] - 221, 26, 0])
    cylinder(t, m16_hole_r, m16_hole_r);
  }
}

translate([0, mother_size[1] + keyboard_height + space * 3, 0])
body_top_hinge(t);

translate([0, -space * 6, 0])
{
  difference()
  {
    body_top_side(t);

    translate([63 + t, 87 + mother_margin[1] + t, 0])
    fan_guard_blank(t, 3, 44, 4, 4);

    translate([(body_inner_size[0] / 2) - 40.5 + t, 16 + t, 0])
    touchpad_D1_blank(t);
  }
}

translate([0, body_inner_size[1] + space, 0])
difference()
{
  body_rear_side(t);

  translate([(body_outer_size[0] / 2) + 30, 10, 0])
  usb_type_a_port_single_blank(t);

  translate([(body_outer_size[0] / 2) - 30, 10, 0])
  hdmi_type_a_port_blank(t);
  
  //kvm switch
  translate([(body_inner_size[0] / 2) + 65, 10, 0])
  cylinder(t, m12_hole_r, m12_hole_r);
}

translate([0, -space * 2, 0])
difference()
{
  body_front_side(t);

  //speaker
  translate([t, 0, 0])
  {
    translate([block_size + speaker_margin, speaker_margin, 0])
    {
      speaker_hole_blank(t);
    }

    translate([body_inner_size[0] - (speaker_size[0] + block_size + speaker_margin), speaker_margin, 0])
    {
      speaker_hole_blank(t);
    }
  }
}


//plate
translate([t + block_size * 2 + mother_size[0] + sub_board_margin[0] - (space * 10), t + sub_board_margin[1], 0])
sub_board_plate(t);

translate([t + keyboard_mounter_margin - (space * 10), 148, 0])
keyboard_plate_xd75re(t);


//TODO
//mother switch
//kvm switch
//battery switch
//battery
//dc jack
//usb type a foot print
//fix fan guard
//separate display code
