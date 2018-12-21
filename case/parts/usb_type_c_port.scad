include <screw.scad>

module usb_type_c_port_blank(thickness)
{
  pos = [[-8.75, 0], [8.75, 0]];
  screw_blank(pos, m2_hole_r, thickness);

  translate([-6, -4, 0])
  cube([12, 8, thickness]);
}

