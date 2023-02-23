model SCA_20230221
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 4)  annotation(
    Placement(visible = true, transformation(origin = {48, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
    Placement(visible = true, transformation(origin = {6, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine(f = 1)  annotation(
    Placement(visible = true, transformation(origin = {-54, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sine.y, torque.tau) annotation(
    Line(points = {{-42, -2}, {-6, -2}}, color = {0, 0, 127}));
  connect(torque.flange, inertia.flange_a) annotation(
    Line(points = {{16, -2}, {38, -2}}));

annotation(
    uses(Modelica(version = "4.0.0")),
    Documentation);
end SCA_20230221;
