include <screw.scad>

module usb_type_a_port_single_blank(thickness)
{
  pos = [[-15, 0], [15, 0]];
  screw_blank(pos, m3_hole_r, thickness);

  translate([-8, -4, 0])
  cube([16, 8, thickness]);

  translate([-20, -6, 0])
  %cube([40, 12, thickness]);
}

