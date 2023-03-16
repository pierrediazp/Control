model resortes
  Modelica.Mechanics.Translational.Components.Spring k1(c = 1)  annotation(
    Placement(visible = true, transformation(origin = {-44, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Spring k3(c = 1)  annotation(
    Placement(visible = true, transformation(origin = {68, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.SpringDamper k2b(c = 1, d = 1)  annotation(
    Placement(visible = true, transformation(origin = {12, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass m1(m = 1)  annotation(
    Placement(visible = true, transformation(origin = {-14, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass m2(m = 1)  annotation(
    Placement(visible = true, transformation(origin = {40, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sources.Force u annotation(
    Placement(visible = true, transformation(origin = {-46, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(startTime = 1)  annotation(
    Placement(visible = true, transformation(origin = {-76, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(visible = true, transformation(origin = {86, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Fixed fixed1 annotation(
    Placement(visible = true, transformation(origin = {-82, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(k1.flange_b, m1.flange_a) annotation(
    Line(points = {{-34, 2}, {-24, 2}}, color = {0, 127, 0}));
  connect(m1.flange_b, k2b.flange_a) annotation(
    Line(points = {{-4, 2}, {2, 2}}, color = {0, 127, 0}));
  connect(k2b.flange_b, m2.flange_a) annotation(
    Line(points = {{22, 2}, {30, 2}}, color = {0, 127, 0}));
  connect(m2.flange_b, k3.flange_a) annotation(
    Line(points = {{50, 2}, {58, 2}}, color = {0, 127, 0}));
  connect(u.flange, m1.flange_a) annotation(
    Line(points = {{-36, -42}, {-24, -42}, {-24, 2}}, color = {0, 127, 0}));
  connect(step.y, u.f) annotation(
    Line(points = {{-65, -42}, {-58, -42}}, color = {0, 0, 127}));
  connect(k3.flange_b, fixed.flange) annotation(
    Line(points = {{78, 2}, {86, 2}, {86, -22}}, color = {0, 127, 0}));
  connect(k1.flange_a, fixed1.flange) annotation(
    Line(points = {{-54, 2}, {-82, 2}, {-82, -4}}, color = {0, 127, 0}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end resortes;
