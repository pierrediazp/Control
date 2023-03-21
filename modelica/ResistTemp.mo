model ResistTemp
  Modelica.Thermal.HeatTransfer.Celsius.TemperatureSensor temperatureSensor annotation(
    Placement(visible = true, transformation(origin = {6, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {56, 94}, extent = {{-100, -100}, {-80, -80}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T (displayUnit = "K")= 300) annotation(
    Placement(visible = true, transformation(origin = {-4, 86}, extent = {{100, -60}, {80, -40}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C = 1, T(displayUnit = "K",fixed = true, start = 300)) annotation(
    Placement(visible = true, transformation(origin = {-4, 86}, extent = {{0, -60}, {20, -80}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 10, T_ref = 293.15, alpha = 1/255, useHeatPort = true) annotation(
    Placement(visible = true, transformation(origin = {-34, 36}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-4, 86}, extent = {{40, -60}, {60, -40}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.StepVoltage stepV(V = 50, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-68, 34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(resistor.heatPort, temperatureSensor.port) annotation(
    Line(points = {{-24, 36}, {6, 36}, {6, 46}}, color = {191, 0, 0}));
  connect(thermalConductor.port_b, fixedTemperature.port) annotation(
    Line(points = {{56, 36}, {76, 36}}, color = {191, 0, 0}));
  connect(resistor.heatPort, thermalConductor.port_a) annotation(
    Line(points = {{-24, 36}, {36, 36}}, color = {191, 0, 0}));
  connect(resistor.heatPort, heatCapacitor.port) annotation(
    Line(points = {{-24, 36}, {6, 36}, {6, 26}}, color = {191, 0, 0}));
  connect(resistor.n, ground.p) annotation(
    Line(points = {{-34, 26}, {-34, 14}}, color = {0, 0, 255}));
  connect(resistor.p, stepV.p) annotation(
    Line(points = {{-34, 46}, {-34, 58}, {-68, 58}, {-68, 44}}, color = {0, 0, 255}));
  connect(stepV.n, ground.p) annotation(
    Line(points = {{-68, 24}, {-68, 14}, {-34, 14}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end ResistTemp;
