module rounded_plate(size, corner_radius)
{
  difference()
  {
    cube(size);

    cube_pos =
    [
      [0, size[1] - corner_radius[0], 0],
      [size[0] - corner_radius[1], size[1] - corner_radius[1], 0],
      [0, 0, 0],
      [size[0] - corner_radius[3], 0, 0]
    ];
    cylinder_pos =
    [
      [corner_radius[0], 0, 0],
      [0, 0, 0],
      [corner_radius[2], corner_radius[2], 0],
      [0, corner_radius[3], 0]
    ];

    for (i = [0:3])
    {
      translate(cube_pos[i])
      difference()
      {
        cube([corner_radius[i], corner_radius[i], size[2]]);
        translate(cylinder_pos[i])
        cylinder(size[2], corner_radius[i], corner_radius[i]);
      }
    }
  }
}

