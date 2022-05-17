package ModelicaServices  "ModelicaServices (OpenModelica implementation) - Models and functions used in the Modelica Standard Library requiring a tool specific implementation" 
  extends Modelica.Icons.Package;

  package Machine  "Machine dependent constants" 
    extends Modelica.Icons.Package;
    final constant Real eps = 1e-15 "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = 1e-60 "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = 1e60 "Biggest Real number such that inf and -inf are representable on the machine";
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax() "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";
  end Machine;
  annotation(version = "4.0.0", versionDate = "2020-06-04", dateModified = "2020-06-04 11:00:00Z"); 
end ModelicaServices;

package Modelica  "Modelica Standard Library - Version 4.0.0" 
  extends Modelica.Icons.Package;

  package Blocks  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)" 
    extends Modelica.Icons.Package;
    import Modelica.Units.SI;

    package Interfaces  "Library of connectors and partial models for input/output blocks" 
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real "'input Real' as connector";
      connector RealOutput = output Real "'output Real' as connector";
      connector BooleanOutput = output Boolean "'output Boolean' as connector";

      partial block SO  "Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealOutput y "Connector of Real output signal";
      end SO;

      partial block SignalSource  "Base class for continuous signal source" 
        extends SO;
        parameter Real offset = 0 "Offset of output signal y";
        parameter SI.Time startTime = 0 "Output y = offset for time < startTime";
      end SignalSource;
    end Interfaces;

    package Logical  "Library of components with Boolean input and output signals" 
      extends Modelica.Icons.Package;

      block OnOffController  "On-off controller" 
        extends Modelica.Blocks.Icons.PartialBooleanBlock;
        Blocks.Interfaces.RealInput reference "Connector of Real input signal used as reference signal";
        Blocks.Interfaces.RealInput u "Connector of Real input signal used as measurement signal";
        Blocks.Interfaces.BooleanOutput y "Connector of Real output signal used as actuator signal";
        parameter Real bandwidth(start = 0.1) "Bandwidth around reference signal";
        parameter Boolean pre_y_start = false "Value of pre(y) at initial time";
      initial equation
        pre(y) = pre_y_start;
      equation
        y = pre(y) and u < reference + bandwidth / 2 or u < reference - bandwidth / 2;
      end OnOffController;
    end Logical;

    package Math  "Library of Real mathematical functions as input/output blocks" 
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.Package;

      block Gain  "Output the product of a gain value with the input signal" 
        parameter Real k(start = 1, unit = "1") "Gain value multiplied with input signal";
        Interfaces.RealInput u "Input signal connector";
        Interfaces.RealOutput y "Output signal connector";
      equation
        y = k * u;
      end Gain;
    end Math;

    package Sources  "Library of signal source blocks generating Real, Integer and Boolean signals" 
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.SourcesPackage;

      block Step  "Generate step signal of type Real" 
        parameter Real height = 1 "Height of step";
        extends Interfaces.SignalSource;
      equation
        y = offset + (if time < startTime then 0 else height);
      end Step;
    end Sources;

    package Icons  "Icons for Blocks" 
      extends Modelica.Icons.IconsPackage;

      partial block Block  "Basic graphical layout of input/output block" end Block;

      partial block PartialBooleanBlock  "Basic graphical layout of logical block" end PartialBooleanBlock;
    end Icons;
  end Blocks;

  package Electrical  "Library of electrical models (analog, digital, machines, polyphase)" 
    extends Modelica.Icons.Package;
    import Modelica.Units.SI;

    package Analog  "Library for analog electrical models" 
      extends Modelica.Icons.Package;

      package Basic  "Basic electrical components" 
        extends Modelica.Icons.Package;

        model Ground  "Ground node" 
          Interfaces.Pin p;
        equation
          p.v = 0;
        end Ground;

        model Resistor  "Ideal linear electrical resistor" 
          parameter SI.Resistance R(start = 1) "Resistance at temperature T_ref";
          parameter SI.Temperature T_ref = 300.15 "Reference temperature";
          parameter SI.LinearTemperatureCoefficient alpha = 0 "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
          extends Modelica.Electrical.Analog.Interfaces.OnePort;
          extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
          SI.Resistance R_actual "Actual resistance = R*(1 + alpha*(T_heatPort - T_ref))";
        equation
          assert(1 + alpha * (T_heatPort - T_ref) >= Modelica.Constants.eps, "Temperature outside scope of model!");
          R_actual = R * (1 + alpha * (T_heatPort - T_ref));
          v = R_actual * i;
          LossPower = v * i;
        end Resistor;
      end Basic;

      package Interfaces  "Connectors and partial models for Analog electrical components" 
        extends Modelica.Icons.InterfacesPackage;

        connector Pin  "Pin of an electrical component" 
          SI.ElectricPotential v "Potential at the pin" annotation(unassignedMessage = "An electrical potential cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
          flow SI.Current i "Current flowing into the pin" annotation(unassignedMessage = "An electrical current cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
        end Pin;

        connector PositivePin  "Positive pin of an electrical component" 
          SI.ElectricPotential v "Potential at the pin" annotation(unassignedMessage = "An electrical potential cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
          flow SI.Current i "Current flowing into the pin" annotation(unassignedMessage = "An electrical current cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
        end PositivePin;

        connector NegativePin  "Negative pin of an electrical component" 
          SI.ElectricPotential v "Potential at the pin" annotation(unassignedMessage = "An electrical potential cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
          flow SI.Current i "Current flowing into the pin" annotation(unassignedMessage = "An electrical current cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
        end NegativePin;

        partial model TwoPin  "Component with two electrical pins" 
          SI.Voltage v "Voltage drop of the two pins (= p.v - n.v)";
          PositivePin p "Positive electrical pin";
          NegativePin n "Negative electrical pin";
        equation
          v = p.v - n.v;
        end TwoPin;

        partial model OnePort  "Component with two electrical pins p and n and current i from p to n" 
          extends TwoPin;
          SI.Current i "Current flowing from pin p to pin n";
        equation
          0 = p.i + n.i;
          i = p.i;
        end OnePort;

        partial model ConditionalHeatPort  "Partial model to include a conditional HeatPort in order to describe the power loss via a thermal network" 
          parameter Boolean useHeatPort = false "= true, if heatPort is enabled" annotation(Evaluate = true, HideResult = true);
          parameter SI.Temperature T = 293.15 "Fixed device temperature if useHeatPort = false";
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final T = T_heatPort, final Q_flow = -LossPower) if useHeatPort "Conditional heat port";
          SI.Power LossPower "Loss power leaving component via heatPort";
          SI.Temperature T_heatPort "Temperature of heatPort";
        equation
          if not useHeatPort then
            T_heatPort = T;
          end if;
        end ConditionalHeatPort;
      end Interfaces;

      package Sources  "Time-dependent and controlled voltage and current sources" 
        extends Modelica.Icons.SourcesPackage;

        model SignalVoltage  "Generic voltage source using the input signal as source voltage" 
          extends Modelica.Electrical.Analog.Icons.VoltageSource;
          Interfaces.PositivePin p;
          Interfaces.NegativePin n;
          Modelica.Blocks.Interfaces.RealInput v(unit = "V") "Voltage between pin p and n (= p.v - n.v) as input signal";
          SI.Current i "Current flowing from pin p to pin n";
        equation
          v = p.v - n.v;
          0 = p.i + n.i;
          i = p.i;
        end SignalVoltage;
      end Sources;

      package Icons  "Icons for analog electrical models" 
        extends Modelica.Icons.IconsPackage;

        partial model VoltageSource  "Icon for voltage sources" end VoltageSource;
      end Icons;
    end Analog;
  end Electrical;

  package Thermal  "Library of thermal system components to model heat transfer and simple thermo-fluid pipe flow" 
    extends Modelica.Icons.Package;
    import Modelica.Units.SI;

    package HeatTransfer  "Library of 1-dimensional heat transfer with lumped elements" 
      extends Modelica.Icons.Package;

      package Examples  "Example models to demonstrate the usage of package Modelica.Thermal.HeatTransfer" 
        extends Modelica.Icons.ExamplesPackage;

        model Temperatura001  "Control temperature of a resistor" 
          parameter SI.Temperature TAmb(displayUnit = "degC") = 293.15 "Ambient temperature";
          parameter SI.TemperatureDifference TDif = 2 "Error in temperature";
          Components.HeatCapacitor heatCapacitor(C = 1, T(fixed = true, start = TAmb));
          Components.ThermalConductor thermalConductor(G = 0.1);
          Modelica.Blocks.Logical.OnOffController onOffController(bandwidth = TDif);
          Modelica.Electrical.Analog.Basic.Ground ground;
          Celsius.TemperatureSensor temperatureSensor;
          Electrical.Analog.Basic.Resistor resistor(R = 10, T_ref = 293.15, alpha = 1 / 255, useHeatPort = true);
          Sources.FixedTemperature fixedTemperature(T = TAmb);
          Modelica.Blocks.Sources.Step step(startTime = 10);
          Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage;
          Modelica.Blocks.Math.Gain gain(k = 10);
        equation
          connect(resistor.heatPort, temperatureSensor.port);
          connect(resistor.heatPort, heatCapacitor.port);
          connect(resistor.heatPort, thermalConductor.port_a);
          connect(thermalConductor.port_b, fixedTemperature.port);
          connect(temperatureSensor.T, onOffController.u);
          connect(signalVoltage.n, ground.p);
          connect(signalVoltage.p, resistor.p);
          connect(resistor.n, ground.p);
          connect(step.y, gain.u);
          connect(gain.y, signalVoltage.v);
          connect(onOffController.reference, step.y);
        end Temperatura001;
      end Examples;

      package Components  "Lumped thermal components" 
        extends Modelica.Icons.Package;

        model HeatCapacitor  "Lumped thermal element storing heat" 
          parameter SI.HeatCapacity C "Heat capacity of element (= cp*m)";
          SI.Temperature T(start = 293.15, displayUnit = "degC") "Temperature of element";
          SI.TemperatureSlope der_T(start = 0) "Time derivative of temperature (= der(T))";
          Interfaces.HeatPort_a port;
        equation
          T = port.T;
          der_T = der(T);
          C * der(T) = port.Q_flow;
        end HeatCapacitor;

        model ThermalConductor  "Lumped thermal element transporting heat without storing it" 
          extends Interfaces.Element1D;
          parameter SI.ThermalConductance G "Constant thermal conductance of material";
        equation
          Q_flow = G * dT;
        end ThermalConductor;
      end Components;

      package Sources  "Thermal sources" 
        extends Modelica.Icons.SourcesPackage;

        model FixedTemperature  "Fixed temperature boundary condition in Kelvin" 
          parameter SI.Temperature T "Fixed temperature at port";
          Interfaces.HeatPort_b port;
        equation
          port.T = T;
        end FixedTemperature;
      end Sources;

      package Celsius  "Components with Celsius input and/or output" 
        extends Modelica.Icons.VariantsPackage;

        model TemperatureSensor  "Absolute temperature sensor in degCelsius" 
          Modelica.Blocks.Interfaces.RealOutput T(unit = "degC") "Absolute temperature in degree Celsius as output signal";
          Interfaces.HeatPort_a port;
        equation
          T = Modelica.Units.Conversions.to_degC(port.T);
          port.Q_flow = 0;
        end TemperatureSensor;
      end Celsius;

      package Interfaces  "Connectors and partial models" 
        extends Modelica.Icons.InterfacesPackage;

        partial connector HeatPort  "Thermal port for 1-dim. heat transfer" 
          SI.Temperature T "Port temperature";
          flow SI.HeatFlowRate Q_flow "Heat flow rate (positive if flowing from outside into the component)";
        end HeatPort;

        connector HeatPort_a  "Thermal port for 1-dim. heat transfer (filled rectangular icon)" 
          extends HeatPort;
        end HeatPort_a;

        connector HeatPort_b  "Thermal port for 1-dim. heat transfer (unfilled rectangular icon)" 
          extends HeatPort;
        end HeatPort_b;

        partial model Element1D  "Partial heat transfer element with two HeatPort connectors that does not store energy" 
          SI.HeatFlowRate Q_flow "Heat flow rate from port_a -> port_b";
          SI.TemperatureDifference dT "port_a.T - port_b.T";
          HeatPort_a port_a;
          HeatPort_b port_b;
        equation
          dT = port_a.T - port_b.T;
          port_a.Q_flow = Q_flow;
          port_b.Q_flow = -Q_flow;
        end Element1D;
      end Interfaces;
    end HeatTransfer;
  end Thermal;

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    extends Modelica.Icons.Package;

    package Icons  "Icons for Math" 
      extends Modelica.Icons.IconsPackage;

      partial function AxisCenter  "Basic icon for mathematical function with y-axis in the center" end AxisCenter;
    end Icons;

    function asin  "Inverse sine (-1 <= u <= 1)" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u "Independent variable";
      output Modelica.Units.SI.Angle y "Dependent variable y=asin(u)";
      external "builtin" y = asin(u);
    end asin;

    function exp  "Exponential, base e" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u "Independent variable";
      output Real y "Dependent variable y=exp(u)";
      external "builtin" y = exp(u);
    end exp;
  end Math;

  package Constants  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)" 
    extends Modelica.Icons.Package;
    import Modelica.Units.SI;
    import Modelica.Units.NonSI;
    final constant Real pi = 2 * Modelica.Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps "Biggest number such that 1.0 + eps = 1.0";
    final constant SI.Velocity c = 299792458 "Speed of light in vacuum";
    final constant SI.ElectricCharge q = 1.602176634e-19 "Elementary charge";
    final constant Real h(final unit = "J.s") = 6.62607015e-34 "Planck constant";
    final constant Real k(final unit = "J/K") = 1.380649e-23 "Boltzmann constant";
    final constant Real N_A(final unit = "1/mol") = 6.02214076e23 "Avogadro constant";
    final constant Real mu_0(final unit = "N/A2") = 4 * pi * 1.00000000055e-7 "Magnetic constant";
    final constant NonSI.Temperature_degC T_zero = -273.15 "Absolute zero temperature";
  end Constants;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial package ExamplesPackage  "Icon for packages containing runnable examples" 
      extends Modelica.Icons.Package;
    end ExamplesPackage;

    partial package Package  "Icon for standard packages" end Package;

    partial package VariantsPackage  "Icon for package containing variants" 
      extends Modelica.Icons.Package;
    end VariantsPackage;

    partial package InterfacesPackage  "Icon for packages containing interfaces" 
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package SourcesPackage  "Icon for packages containing sources" 
      extends Modelica.Icons.Package;
    end SourcesPackage;

    partial package IconsPackage  "Icon for packages containing icons" 
      extends Modelica.Icons.Package;
    end IconsPackage;
  end Icons;

  package Units  "Library of type and unit definitions" 
    extends Modelica.Icons.Package;

    package SI  "Library of SI unit definitions" 
      extends Modelica.Icons.Package;
      type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
      type Time = Real(final quantity = "Time", final unit = "s");
      type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
      type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
      type Power = Real(final quantity = "Power", final unit = "W");
      type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC") "Absolute temperature (use type TemperatureDifference for relative temperatures)" annotation(absoluteValue = true);
      type Temperature = ThermodynamicTemperature;
      type TemperatureDifference = Real(final quantity = "ThermodynamicTemperature", final unit = "K") annotation(absoluteValue = false);
      type TemperatureSlope = Real(final quantity = "TemperatureSlope", final unit = "K/s");
      type LinearTemperatureCoefficient = Real(final quantity = "LinearTemperatureCoefficient", final unit = "1/K");
      type HeatFlowRate = Real(final quantity = "Power", final unit = "W");
      type ThermalConductance = Real(final quantity = "ThermalConductance", final unit = "W/K");
      type HeatCapacity = Real(final quantity = "HeatCapacity", final unit = "J/K");
      type ElectricCurrent = Real(final quantity = "ElectricCurrent", final unit = "A");
      type Current = ElectricCurrent;
      type ElectricCharge = Real(final quantity = "ElectricCharge", final unit = "C");
      type ElectricPotential = Real(final quantity = "ElectricPotential", final unit = "V");
      type Voltage = ElectricPotential;
      type Resistance = Real(final quantity = "Resistance", final unit = "Ohm");
      type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
    end SI;

    package NonSI  "Type definitions of non SI and other units" 
      extends Modelica.Icons.Package;
      type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC") "Absolute temperature in degree Celsius (for relative temperature use Modelica.Units.SI.TemperatureDifference)" annotation(absoluteValue = true);
    end NonSI;

    package Conversions  "Conversion functions to/from non SI units and type definitions of non SI units" 
      extends Modelica.Icons.Package;

      function to_degC  "Convert from kelvin to degree Celsius" 
        extends Modelica.Units.Icons.Conversion;
        input SI.Temperature Kelvin "Value in kelvin";
        output Modelica.Units.NonSI.Temperature_degC Celsius "Value in degree Celsius";
      algorithm
        Celsius := Kelvin + Modelica.Constants.T_zero;
        annotation(Inline = true); 
      end to_degC;
    end Conversions;

    package Icons  "Icons for Units" 
      extends Modelica.Icons.IconsPackage;

      partial function Conversion  "Base icon for conversion functions" end Conversion;
    end Icons;
  end Units;
  annotation(version = "4.0.0", versionDate = "2020-06-04", dateModified = "2020-06-04 11:00:00Z"); 
end Modelica;

model Temperatura001_total  "Control temperature of a resistor"
  extends Modelica.Thermal.HeatTransfer.Examples.Temperatura001;
end Temperatura001_total;
