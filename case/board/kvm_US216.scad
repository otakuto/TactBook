include <../parts/screw.scad>

module kvm_screw_blank(thickness)
{
  front_width_interval = 65;
  rear_width_interval = 86;
  height_interval = 24;

  pos =
  [
    [-rear_width_interval / 2, height_interval],
    [rear_width_interval / 2, height_interval],
    [-front_width_interval / 2, 0],
    [front_width_interval / 2, 0],
  ];

  screw_blank(pos, m3_hole_r, thickness);

  translate([-47.5, -4.5, 0])
  %cube([95, 46, thickness]);
}
