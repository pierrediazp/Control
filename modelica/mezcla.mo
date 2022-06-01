model mezcla
  Modelica.StateGraph.InitialStep Espera(nOut = 1, nIn = 1)  annotation(
    Placement(visible = true, transformation(origin = {-70, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t1 annotation(
    Placement(visible = true, transformation(origin = {-50, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t2 annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t3 annotation(
    Placement(visible = true, transformation(origin = {46, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t0 annotation(
    Placement(visible = true, transformation(origin = {0, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold MayorQue(threshold = 10)  annotation(
    Placement(visible = true, transformation(origin = {-3, -19}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction Tanque(a = {1, 0}, b = {2})  annotation(
    Placement(visible = true, transformation(origin = {-26, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {-70, -12}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant c0(k = 0)  annotation(
    Placement(visible = true, transformation(origin = {-87, -25}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant c1(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-86, -8}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Timer timer annotation(
    Placement(visible = true, transformation(origin = {21, 9}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 20) annotation(
    Placement(visible = true, transformation(origin = {33, -9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(
    Placement(visible = true, transformation(origin = {-80, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch annotation(
    Placement(visible = true, transformation(origin = {-59, -17}, extent = {{-3, 3}, {3, -3}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanPulse start(period = 100, startTime = 10, width = 1)  annotation(
    Placement(visible = true, transformation(origin = {-66, 14}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanPulse stop(period = 200, startTime = 100, width = 1)  annotation(
    Placement(visible = true, transformation(origin = {-20, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal Operando(nIn = 1, nOut = 1)  annotation(
    Placement(visible = true, transformation(origin = {22, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal Carga(nIn = 1, nOut = 1)  annotation(
    Placement(visible = true, transformation(origin = {-26, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant c_1(k = -1)  annotation(
    Placement(visible = true, transformation(origin = {-88, -40}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal Descarga(nIn = 1, nOut = 1)  annotation(
    Placement(visible = true, transformation(origin = {64, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation(
    Placement(visible = true, transformation(origin = {-49, -25}, extent = {{-3, 3}, {3, -3}}, rotation = 0)));
equation
  connect(Espera.outPort[1], t1.inPort) annotation(
    Line(points = {{-59.5, 32}, {-54, 32}}));
  connect(t0.outPort, Espera.inPort[1]) annotation(
    Line(points = {{-1.5, -50}, {-92, -50}, {-92, 32}, {-81, 32}}));
  connect(MayorQue.y, t2.condition) annotation(
    Line(points = {{2.5, -19}, {0, -19}, {0, 20}}, color = {255, 0, 255}));
  connect(c0.y, switch1.u3) annotation(
    Line(points = {{-81.5, -25}, {-80, -25}, {-80, -15}, {-75, -15}}, color = {0, 0, 127}));
  connect(c1.y, switch1.u1) annotation(
    Line(points = {{-82, -8}, {-80, -8}, {-80, -9}, {-75, -9}}, color = {0, 0, 127}));
  connect(timer.y, greaterThreshold.u) annotation(
    Line(points = {{22, 4}, {22, -9}, {27, -9}}, color = {0, 0, 127}));
  connect(greaterThreshold.y, t3.condition) annotation(
    Line(points = {{38.5, -9}, {46, -9}, {46, 20}}, color = {255, 0, 255}));
  connect(start.y, t1.condition) annotation(
    Line(points = {{-62, 14}, {-50, 14}, {-50, 20}}, color = {255, 0, 255}));
  connect(Tanque.y, MayorQue.u) annotation(
    Line(points = {{-15, -20}, {-8, -20}, {-8, -18}}, color = {0, 0, 127}));
  connect(stop.y, t0.condition) annotation(
    Line(points = {{-8, -72}, {0, -72}, {0, -62}}, color = {255, 0, 255}));
  connect(switch1.y, switch.u3) annotation(
    Line(points = {{-66, -12}, {-63, -12}, {-63, -15}}, color = {0, 0, 127}));
  connect(t2.outPort, Operando.inPort[1]) annotation(
    Line(points = {{2, 32}, {12, 32}}));
  connect(Operando.outPort[1], t3.inPort) annotation(
    Line(points = {{32, 32}, {42, 32}}));
  connect(Operando.active, timer.u) annotation(
    Line(points = {{22, 22}, {22, 16}}, color = {255, 0, 255}));
  connect(switch.u2, Operando.active) annotation(
    Line(points = {{-63, -17}, {-66, -17}, {-66, -40}, {10, -40}, {10, 21}, {22, 21}}, color = {255, 0, 255}));
  connect(switch.u1, c0.y) annotation(
    Line(points = {{-63, -19}, {-76, -19}, {-76, -24}, {-82, -24}}, color = {0, 0, 127}));
  connect(t1.outPort, Carga.inPort[1]) annotation(
    Line(points = {{-48, 32}, {-37, 32}}));
  connect(Carga.outPort[1], t2.inPort) annotation(
    Line(points = {{-15.5, 32}, {-4, 32}}));
  connect(Carga.active, switch1.u2) annotation(
    Line(points = {{-26, 21}, {-26, -4}, {-78, -4}, {-78, -12}, {-75, -12}}, color = {255, 0, 255}));
  connect(t3.outPort, Descarga.inPort[1]) annotation(
    Line(points = {{48, 32}, {54, 32}}));
  connect(Descarga.outPort[1], t0.inPort) annotation(
    Line(points = {{74, 32}, {80, 32}, {80, -50}, {4, -50}}));
  connect(switch2.y, Tanque.u) annotation(
    Line(points = {{-46, -24}, {-42, -24}, {-42, -20}, {-38, -20}}, color = {0, 0, 127}));
  connect(c_1.y, switch2.u1) annotation(
    Line(points = {{-84, -40}, {-58, -40}, {-58, -28}, {-52, -28}}, color = {0, 0, 127}));
  connect(switch.y, switch2.u3) annotation(
    Line(points = {{-56, -16}, {-54, -16}, {-54, -22}, {-52, -22}}, color = {0, 0, 127}));
  connect(switch2.u2, Descarga.active) annotation(
    Line(points = {{-52, -24}, {-60, -24}, {-60, -32}, {64, -32}, {64, 22}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-100, 80}, {80, -100}})),
    version = "");
end mezcla;
