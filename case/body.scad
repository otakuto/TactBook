use <common/function.scad>
use <common/rounded_plate.scad>
include <block.scad>
include <board/stx.scad>


module body_bottom_side(thickness)
{
  translate([thickness, thickness, 0])
  {
    //mother
    difference()
    {
      block_frame([mother_size[0], body_inner_size[0] - mother_size[0] - (block_size * 3)], [mother_size[1] - (block_size * 2)], thickness);

      translate([block_size + ((mother_size[0] - stx_hole_distance[0]) / 2), ((mother_size[1] - stx_hole_distance[1]) / 2), 0])
      {
        screw_blank(stx_screw_pos, m3_hole_r, thickness);
        screw_blank(cpu_socket_screw_pos, cpu_socket_screw_r, thickness);
      }
      translate([(block_size * 2) + mother_size[0] + 5 + 1, ((mother_size[1] - stx_hole_distance[1]) / 2), 0])
      screw_blank(sub_board_screw_pos, sub_board_screw_r, thickness);
    }

    //keyboard
    translate([0, mother_size[1], 0])
    {
      cube([body_inner_size[0], keyboard_height, thickness]);
    }

    //hinge
    translate([0, mother_size[1] + keyboard_height, 0])
    {
      interval =
      [
        (body_inner_size[0] / 2) - (block_size * 1.5),
        (body_inner_size[0] / 2) - (block_size * 1.5),
      ];
      block_frame(interval, [], thickness);
    }
  }

  rounded_plate([thickness, thickness, thickness], [0, 0, 1, 0]);

  translate([body_inner_size[0] + thickness, body_inner_size[1] + thickness, 0])
  rounded_plate([thickness, thickness, thickness], [0, 1, 0, 0]);

  translate([0, body_inner_size[1] + thickness, 0])
  rounded_plate([thickness, thickness, thickness], [1, 0, 0, 0]);

  translate([body_inner_size[0] + thickness, 0, 0])
  rounded_plate([thickness, thickness, thickness], [0, 0, 0, 1]);


  translate([thickness, 0, 0])
  cube([body_inner_size[0], thickness, thickness]);

  translate([0, thickness, 0])
  cube([thickness, body_inner_size[1], thickness]);

  translate([body_inner_size[0] + thickness, thickness, 0])
  cube([thickness, body_inner_size[1], thickness]);

  translate([thickness, body_inner_size[1] + thickness, 0])
  cube([body_inner_size[0], thickness, thickness]);

}

module body_right_side(thickness)
{
  translate([thickness, 0, 0])
  {
    difference()
    {
      block_frame([mother_size[1] - (block_size * 2), hinge_base_height + keyboard_height - block_size], [height - block_size * 2], thickness);

      translate([body_inner_size[1] - (block_size * 0.5) - keyboard_height - m3_hole_r + 85, block_size * 0.5, 0])
      cube([m3_hole_r * 2, block_size * 3, thickness]);

      translate([body_inner_size[1] - (block_size * 0.5) - keyboard_height - m3_hole_r, block_size * 0.5, 0])
      cube([m3_hole_r * 2, block_size * 3, thickness]);
    }
    
    translate([-thickness, 0, 0])
    cube([thickness, height, thickness]);

    translate([body_inner_size[1], 0, 0])
    cube([thickness, height, thickness]);
  }
}

module body_left_side(thickness)
{
  translate([thickness, 0, 0])
  {
    difference()
    {
      block_frame([mother_size[1] - (block_size * 2), hinge_base_height + keyboard_height - block_size], [height - block_size * 2], thickness);

      translate([block_size, 0, 0])
      {
        rounded_plate([mother_size[1] - (block_size * 2), 40, thickness], [5, 5, 0, 0]);
      }

      translate([body_inner_size[1] - (block_size * 0.5) - keyboard_height - m3_hole_r + 85, block_size * 1.5, 0])
      cube([m3_hole_r * 2, block_size * 3, thickness]);

      translate([body_inner_size[1] - (block_size * 0.5) - keyboard_height - m3_hole_r, block_size * 1.5, 0])
      cube([m3_hole_r * 2, block_size * 3, thickness]);

      //dc099
      //translate([body_inner_size[1] - block_size - 11, 11, 0])
      //cylinder(thickness, m11_hole_r, m11_hole_r);

      ////Battery switch
      //translate([body_inner_size[1] - block_size - 11, 11, 0])
      //cylinder(thickness, m16_hole_r, m16_hole_r);
    }
    
    translate([-thickness, 0, 0])
    cube([thickness, height, thickness]);

    translate([body_inner_size[1], 0, 0])
    cube([thickness, height, thickness]);
  }
}

module body_rear_side(thickness)
{
  translate([thickness, 0, 0])
  {
    {
      ps =
      [
        (body_inner_size[0] / 2) - (block_size * 1.5),
        (body_inner_size[0] / 2) - (block_size * 1.5),
      ];
      block_frame(ps, [], thickness);
    }

    translate([block_size, block_size, 0])
    cube([body_inner_size[0] - block_size * 2, height - (block_size * 2), thickness]);

    translate([0, block_size, 0])
    cube([block_size, height - (block_size * 2), thickness]);

    translate([body_inner_size[0] - block_size, block_size, 0])
    cube([block_size, height - (block_size * 2), thickness]);

    translate([0, height - block_size, 0])
    {
      ps =
      [
        hinge_base_hole_interval - block_size,
        (body_inner_size[0] / 2) - hinge_base_hole_interval - (block_size * 1.5),
        (body_inner_size[0] / 2) - hinge_base_hole_interval - (block_size * 1.5),
        hinge_base_hole_interval - block_size
      ];
      block_frame(ps, [], thickness);
    }
  }
}

module body_front_side(thickness)
{
  translate([thickness, 0, 0])
  block_frame([mother_size[0], body_inner_size[0] - mother_size[0] - block_size * 3], [height - block_size * 2], thickness);
}

module body_top_hinge(thickness)
{
  translate([thickness, 0, 0])
  {
    difference()
    {
      ps =
      [
        hinge_base_hole_interval - block_size,
        (body_inner_size[0] / 2) - hinge_base_hole_interval - (block_size * 1.5),
        (body_inner_size[0] / 2) - hinge_base_hole_interval - (block_size * 1.5),
        hinge_base_hole_interval - block_size
      ];
      block_frame(ps, [], thickness);

      //FFC
      translate([190 + display_side_padding - thickness, 4, 0])
      cube([22, 3, thickness]);
    }

    translate([body_inner_size[0], hinge_base_height, 0])
    rounded_plate([thickness, thickness, thickness], [0, 1, 0, 0]);
    
    translate([-thickness, hinge_base_height, 0])
    rounded_plate([thickness, thickness, thickness], [1, 0, 0, 0]);
    
    
    translate([0, hinge_base_height, 0])
    cube([body_inner_size[0], thickness, thickness]);
    
    translate([body_inner_size[0], 0, 0])
    rounded_plate([thickness, hinge_base_height, thickness], [0, 0, 0, 1]);
    
    translate([-thickness, 0, 0])
    rounded_plate([thickness, hinge_base_height, thickness], [0, 0, 1, 0]);
  }
}

module body_top_side(thickness)
{
  translate([thickness, 0, 0])
  {
    block_frame([mother_size[0], body_inner_size[0] - mother_size[0] - block_size * 3], [mother_size[1] - block_size * 2], thickness);

    translate([-thickness, -thickness, 0])
    rounded_plate([thickness, thickness, thickness], [0, 0, 1, 0]);
    
    translate([body_inner_size[0], -thickness, 0])
    rounded_plate([thickness, thickness, thickness], [0, 0, 0, 1]);
    
    
    translate([0, -thickness, 0])
    cube([body_inner_size[0], thickness, thickness]);
    
    translate([body_inner_size[0], 0, 0])
    rounded_plate([thickness, mother_size[1], thickness], [0, 1, 0, 0]);
    
    translate([-thickness, 0, 0])
    rounded_plate([thickness, mother_size[1], thickness], [1, 0, 0, 0]);
  }
}
