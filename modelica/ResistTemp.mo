model ResistTemp
  Modelica.Thermal.HeatTransfer.Celsius.TemperatureSensor temperatureSensor annotation(
    Placement(visible = true, transformation(origin = {6, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {56, 120}, extent = {{-100, -100}, {-80, -80}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T (displayUnit = "K")= 300) annotation(
    Placement(visible = true, transformation(origin = {-4, 112}, extent = {{100, -60}, {80, -40}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C = 1, T(displayUnit = "K",fixed = true, start = 300)) annotation(
    Placement(visible = true, transformation(origin = {-4, 112}, extent = {{0, -60}, {20, -80}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 10, T_ref = 293.15, alpha = 1/255, useHeatPort = true) annotation(
    Placement(visible = true, transformation(origin = {-34, 62}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-4, 112}, extent = {{40, -60}, {60, -40}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.StepVoltage stepV(V = 50, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-68, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = 1, T(displayUnit = "K", fixed = true, start = 300)) annotation(
    Placement(visible = true, transformation(origin = {36, 68}, extent = {{0, -80}, {20, -60}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 10, T_ref = 293.15, alpha = 1 / 255, useHeatPort = true) annotation(
    Placement(visible = true, transformation(origin = {36, -30}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  Modelica.Thermal.HeatTransfer.Celsius.TemperatureSensor temperatureSensor1 annotation(
    Placement(visible = true, transformation(origin = {-12, -84}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
    Placement(visible = true, transformation(origin = {116, 30}, extent = {{-100, -100}, {-80, -80}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T(displayUnit = "K") = 300) annotation(
    Placement(visible = true, transformation(origin = {-2, 20}, extent = {{100, -60}, {80, -40}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 0.1) annotation(
    Placement(visible = true, transformation(origin = {12, 20}, extent = {{40, -60}, {60, -40}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation(
    Placement(visible = true, transformation(origin = {12, -30}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Continuous.TransferFunction Gc(a = {1}, b = {0.1})  annotation(
    Placement(visible = true, transformation(origin = {-18, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {-48, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 50, offset = 27, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-84, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(resistor.heatPort, temperatureSensor.port) annotation(
    Line(points = {{-24, 62}, {6, 62}, {6, 72}}, color = {191, 0, 0}));
  connect(thermalConductor.port_b, fixedTemperature.port) annotation(
    Line(points = {{56, 62}, {76, 62}}, color = {191, 0, 0}));
  connect(resistor.heatPort, thermalConductor.port_a) annotation(
    Line(points = {{-24, 62}, {36, 62}}, color = {191, 0, 0}));
  connect(resistor.heatPort, heatCapacitor.port) annotation(
    Line(points = {{-24, 62}, {6, 62}, {6, 52}}, color = {191, 0, 0}));
  connect(resistor.n, ground.p) annotation(
    Line(points = {{-34, 52}, {-34, 40}}, color = {0, 0, 255}));
  connect(resistor.p, stepV.p) annotation(
    Line(points = {{-34, 72}, {-34, 84}, {-68, 84}, {-68, 70}}, color = {0, 0, 255}));
  connect(stepV.n, ground.p) annotation(
    Line(points = {{-68, 50}, {-68, 40}, {-34, 40}}, color = {0, 0, 255}));
  connect(thermalConductor1.port_b, fixedTemperature1.port) annotation(
    Line(points = {{72, -30}, {78, -30}}, color = {191, 0, 0}));
  connect(resistor1.heatPort, heatCapacitor1.port) annotation(
    Line(points = {{46, -30}, {46, -12}}, color = {191, 0, 0}));
  connect(resistor1.heatPort, temperatureSensor1.port) annotation(
    Line(points = {{46, -30}, {46, -84}, {-2, -84}}, color = {191, 0, 0}));
  connect(resistor1.n, ground1.p) annotation(
    Line(points = {{36, -40}, {36, -50}, {26, -50}}, color = {0, 0, 255}));
  connect(resistor1.heatPort, thermalConductor1.port_a) annotation(
    Line(points = {{46, -30}, {52, -30}}, color = {191, 0, 0}));
  connect(signalVoltage.p, resistor1.p) annotation(
    Line(points = {{12, -20}, {12, -10}, {36, -10}, {36, -20}}, color = {0, 0, 255}));
  connect(signalVoltage.n, ground1.p) annotation(
    Line(points = {{12, -40}, {12, -50}, {26, -50}}, color = {0, 0, 255}));
  connect(Gc.y, signalVoltage.v) annotation(
    Line(points = {{-7, -30}, {0, -30}}, color = {0, 0, 127}));
  connect(temperatureSensor1.T, feedback.u2) annotation(
    Line(points = {{-22, -84}, {-48, -84}, {-48, -38}}, color = {0, 0, 127}));
  connect(feedback.y, Gc.u) annotation(
    Line(points = {{-39, -30}, {-30, -30}}, color = {0, 0, 127}));
  connect(step.y, feedback.u1) annotation(
    Line(points = {{-72, -30}, {-56, -30}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end ResistTemp;
