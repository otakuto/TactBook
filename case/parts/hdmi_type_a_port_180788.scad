include <screw.scad>

module hdmi_type_a_port_blank(thickness)
{
  pos = [[-13.75, 0], [13.75, 0]];
  screw_blank(pos, m3_hole_r, thickness);

  translate([-8, -3, 0])
  cube([16, 6, thickness]);

  translate([-17, -5, 0])
  %cube([34, 10, thickness]);
}

