use <common/function.scad>
use <common/rounded_plate.scad>
include <block.scad>
include <parts/hinge_B-158-3.scad>
include <parts/screw.scad>
include <board/kvm_US216.scad>
include <board/lcd_controller.scad>
include <board/stx.scad>
include <keyboard/xd75re.scad>



keyboard_height = 100;


//mother + margin
mother_margin = [1, 1];
mother_size = stx_size + (mother_margin * 2);

t = 3;
height = 50;


//n133hse-ea3
lcd_outline = [306, 179];
lcd_bracket_height = 6;
lcd_pcb_height = 12;

display_side_padding = 4;

display_width = lcd_outline[0] + (display_side_padding * 2);
body_width = display_width;

body_height = keyboard_height + mother_size[1] + hinge_base_height;
display_height = body_height + t - (hinge_axis_r * 2) - hinge_axis_margin;

display_size = [display_width, display_height];

body_inner_size = [body_width - (t * 2), body_height];
body_outer_size = [body_width, body_height + (t * 2)];

echo(body_inner_size);
echo(body_outer_size);

sub_board_margin = [1, 1];
sub_board_size = 
[
  body_inner_size[0] - mother_size[0] - (sub_board_margin[0] * 2) - (block_size * 3),
  mother_size[1] - (sub_board_margin[1] * 2)
];
sub_board_screw_padding = 5;
sub_board_screw_r = m3_hole_r;
sub_board_screw_pos =
[
  [0, 0],
  [0, sub_board_size[1] - (sub_board_screw_padding * 2)],
  [sub_board_size[0] - (sub_board_screw_padding * 2), 0],
  [sub_board_size[0] - (sub_board_screw_padding * 2), sub_board_size[1] - (sub_board_screw_padding * 2)]
];

display_bottom_padding = (display_size[1] - lcd_outline[1]) / 2;
display_top_padding = display_bottom_padding;

lcd_active_area_top_margin = 9;
lcd_active_area_left_margin = 4.5;
lcd_active_area_size = [295.5, 168];

lcd_screw_top_margin = 3;
lcd_screw_left_margin = 8;
lcd_screw_r = m2_hole_r;
lcd_screw_pos =
[
  [0, 0],
  [0, 184],
  [289, 0],
  [289, 184],
];

display_round_r = 5;

display_screw_margin = 8;
display_screw_r = m3_hole_r;
display_screw_pos =
[
  [display_screw_margin, display_screw_margin],
  [display_screw_margin, display_size[1] - display_screw_margin],
  [display_size[0] - display_screw_margin, display_screw_margin],
  [display_size[0] - display_screw_margin, display_size[1] - display_screw_margin],

  [display_size[0] / 2, display_screw_margin],
  [display_size[0] / 2, display_size[1] - display_screw_margin],

  [display_screw_margin + (display_screw_margin * 2), display_screw_margin],
  [display_screw_margin + (display_screw_margin * 2), display_size[1] - display_screw_margin],
  [display_size[0] - display_screw_margin - (display_screw_margin * 2), display_screw_margin],
  [display_size[0] - display_screw_margin - (display_screw_margin * 2), display_size[1] - display_screw_margin],
];

module display_front(thickness)
{
  difference()
  {
    rounded_plate([display_size[0], display_size[1], thickness], [display_round_r, display_round_r, display_round_r, display_round_r]);

    translate([0, display_size[1] - 5, 0])
    hinge_plate_nut_blank(thickness, thickness);

    translate([display_side_padding, display_top_padding - lcd_bracket_height, 0])
    {
      translate([lcd_active_area_left_margin, lcd_active_area_top_margin, 0])
      cube([lcd_active_area_size[0], lcd_active_area_size[1], thickness]);

      translate([lcd_screw_left_margin, lcd_screw_top_margin, 0])
      screw_blank(lcd_screw_pos, lcd_screw_r, thickness);
    }

    screw_blank(display_screw_pos, display_screw_r, thickness);
  }
}

module display_middle_top(thickness)
{
  difference()
  {
    translate([display_screw_margin * 2, 0, 0])
    cube([display_size[0] - (display_screw_margin * 4), display_top_padding - lcd_bracket_height, thickness]);

    nut_blank(display_screw_pos, m3_nut_hole_r, 0, thickness);
  }
}

module display_middle_bottom(thickness, side_thickness)
{
  difference()
  {
    translate([display_screw_margin * 2, display_size[1] - display_bottom_padding + lcd_pcb_height, 0])
    cube([display_size[0] - (display_screw_margin * 4), display_bottom_padding - lcd_pcb_height, thickness]);

    //FFC
    translate([190 + display_side_padding, display_size[1] - display_bottom_padding, 0])
    cube([22, display_bottom_padding, thickness]);

    nut_blank(display_screw_pos, m3_nut_hole_r, 0, thickness);

    translate([0, display_size[1] - 5, 0])
    hinge_plate_blank(side_thickness, thickness);
  }
}

module display_middle_right(thickness)
{
  difference()
  {
    union()
    {
      translate([display_size[0] - (display_screw_margin * 2), 0, 0])
      rounded_plate([display_screw_margin * 2, display_top_padding - lcd_bracket_height, thickness], [0, 0, 0, display_round_r]);

      translate([lcd_outline[0] + display_side_padding, display_top_padding - lcd_bracket_height, 0])
      cube([display_side_padding, lcd_outline[1] + lcd_bracket_height + lcd_pcb_height, thickness]);

      translate([display_size[0] - (display_screw_margin * 2), display_size[1] - display_bottom_padding + lcd_pcb_height, 0])
      rounded_plate([display_screw_margin * 2, display_bottom_padding - lcd_pcb_height, thickness], [0, display_round_r, 0, 0]);
    }

    nut_blank(display_screw_pos, m3_nut_hole_r, 0, thickness);
  }
}

module display_middle_left(thickness)
{
  difference()
  {
    union()
    {
      rounded_plate([display_screw_margin * 2, display_top_padding - lcd_bracket_height, thickness], [0, 0, display_round_r, 0]);

      translate([0, display_top_padding - lcd_bracket_height, 0])
      cube([display_side_padding, lcd_outline[1] + lcd_bracket_height + lcd_pcb_height, thickness]);

      translate([0, display_size[1] - display_bottom_padding + lcd_pcb_height, 0])
      rounded_plate([display_screw_margin * 2, display_bottom_padding - lcd_pcb_height, thickness], [display_round_r, 0, 0, 0]);
    }

    nut_blank(display_screw_pos, m3_nut_hole_r, 0, thickness);
  }
}

module display_rear(thickness)
{
  difference()
  {
    rounded_plate([display_size[0], display_size[1], thickness], [display_round_r, display_round_r, display_round_r, display_round_r]);

    translate([0, display_size[1] - 5, 0])
    hinge_plate_hole_blank(thickness, thickness);

    screw_blank(display_screw_pos, display_screw_r, thickness);
  }
}

module hinge_plate_blank(side_thickness, thickness)
{
  hole_distance = hinge_base_hole_interval + hinge_plate_hole_base_hole_distance + (block_size / 2) + side_thickness;
  pos =
  [
    hole_distance,
    display_size[0] - hole_distance - hinge_plate_hole_interval
  ];

  translate([pos[0] -4.5, -4.5, 0])
  cube([22, 9.5, thickness]);

  translate([pos[1] -4.5, -4.5, 0])
  cube([22, 9.5, thickness]);
}

module hinge_plate_hole_blank(side_thickness, thickness)
{
  hole_distance = hinge_base_hole_interval + hinge_plate_hole_base_hole_distance + (block_size / 2) + side_thickness;
  pos =
  [
    [hole_distance, 0],
    [hole_distance + hinge_plate_hole_interval, 0],
    [display_size[0] - hole_distance, 0],
    [display_size[0] - hole_distance - hinge_plate_hole_interval, 0],
  ];
  screw_blank(pos, m3_hole_r, thickness);
}

module hinge_plate_nut_blank(side_thickness, thickness)
{
  hole_distance = hinge_base_hole_interval + hinge_plate_hole_base_hole_distance + (block_size / 2) + side_thickness;
  pos =
  [
    [hole_distance, 0],
    [hole_distance + hinge_plate_hole_interval, 0],
    [display_size[0] - hole_distance, 0],
    [display_size[0] - hole_distance - hinge_plate_hole_interval, 0],
  ];
  nut_blank(pos, m3_nut_hole_r, 30, thickness);
}




module sub_board_plate(thickness)
{
  difference()
  {
    cube([sub_board_size[0], sub_board_size[1], thickness]);

    translate([sub_board_screw_padding, sub_board_screw_padding, 0])
    screw_blank(sub_board_screw_pos, sub_board_screw_r, thickness);

    translate([(sub_board_size[0] - 76) / 2, (sub_board_size[1] - 54) - 4, 0])
    lcd_controller_screw_blank(thickness);

    translate([sub_board_size[0] / 2, ((sub_board_size[1] - 54) - 4) - 24 - 11 , 0])
    kvm_screw_blank(thickness);
  }
}

keyboard_mounter_margin = 1;
keyboard_mounter_width = body_inner_size[0] - (keyboard_mounter_margin * 2);
keyboard_mounter_height = 95;

module keyboard_plate_xd75re(thickness)
{
  difference()
  {
    block_frame([body_inner_size[0] - (keyboard_mounter_margin * 2) - (block_size * 2)], [95 - (block_size * 2)], thickness);
    translate([(keyboard_mounter_width - 280) / 2, 38.5, 0])
    screw_blank(xd75re_screw_pos, xd75re_screw_r, thickness);
  }
}
