include <../parts/screw.scad>

module lcd_controller_screw_blank(thickness)
{
  screw_pos =
  [
    [0, 0],
    [0, 54],
    [76, 0],
    [76, 54],
  ];

  screw_blank(screw_pos, m2_hole_r, thickness);

  translate([-3, -3, 0])
  %cube([82, 60, thickness]);
}

module lcd_controller_switch_blank(thickness)
{
  screw_pos =
  [
    [0, 0],
    [36, 0],
    [93, 0],
  ];
  screw_blank(screw_pos, m3_hole_r, thickness);

  button_blank_size = [6, 6];
  button_pos =
  [
    [9, 0],
    [27, 0],
    [45, 0],
    [63, 0],
    [85, 0]
  ];

  for (p = button_pos)
  {
    translate([p[0] - (button_blank_size[0] / 2), p[1] - (button_blank_size[1] / 2), 0])
    cube([button_blank_size[0], button_blank_size[1], thickness]);
  }

  translate([-10.5, -9, 0])
  %cube([107, 15, thickness]);
}

