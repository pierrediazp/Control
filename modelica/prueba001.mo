model prueba001
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;


  Modelica.Fluid.Sources.Boundary_pT fuente(redeclare package Medium = Medium, T = system.T_ambient,nPorts = 1, p = 2.5e6)  annotation(
    Placement(visible = true, transformation(origin = {-82, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT ambiente(redeclare package Medium = Medium,nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {-40, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system(redeclare package Medium = Medium,energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) annotation(
    Placement(visible = true, transformation(extent = {{78, -100}, {98, -80}}, rotation = 0)));
  Modelica.Fluid.Vessels.OpenTank T1(redeclare package Medium = Medium,crossArea = 6, height = 10, level(start = 3), nPorts = 2, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.2, height = 4, zeta_out = 0, zeta_in = 1), Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.2, height = 0, zeta_out = 0, zeta_in = 1)}, use_portsData = true)  annotation(
    Placement(visible = true, transformation(origin = {62, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveLinear V1(redeclare package Medium = Medium, dp_nominal(displayUnit = "Pa") = 10000, m_flow_nominal = 10) annotation(
    Placement(visible = true, transformation(origin = {-40, 84}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveLinear V2(redeclare package Medium = Medium, dp_nominal(displayUnit = "Pa") = 10, m_flow_nominal = 100) annotation(
    Placement(visible = true, transformation(origin = {60, -16}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const(k = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {25, -17}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 0.5, offset = 0.3, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = {-72, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(fuente.ports[1], V1.port_a) annotation(
    Line(points = {{-72, 84}, {-50, 84}}, color = {0, 127, 255}));
  connect(V1.port_b, T1.ports[1]) annotation(
    Line(points = {{-30, 84}, {20, 84}, {20, 28}, {62, 28}}, color = {0, 127, 255}));
  connect(T1.ports[2], V2.port_a) annotation(
    Line(points = {{62, 28}, {62, 18}, {60, 18}, {60, -6}}, color = {0, 127, 255}));
  connect(V2.port_b, ambiente.ports[1]) annotation(
    Line(points = {{60, -26}, {60, -62}, {-30, -62}}, color = {0, 127, 255}));
  connect(const.y, V2.opening) annotation(
    Line(points = {{35, -17}, {50.5, -17}, {50.5, -16}, {52, -16}}, color = {0, 0, 127}));
  connect(step.y, V1.opening) annotation(
    Line(points = {{-61, 48}, {-40, 48}, {-40, 76}}, color = {0, 0, 127}));

annotation(
    uses(Modelica(version = "4.0.0")));
end prueba001;
