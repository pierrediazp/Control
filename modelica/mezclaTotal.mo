model mezcla  
  Modelica.StateGraph.InitialStep Espera(nOut = 1, nIn = 1);
  Modelica.StateGraph.Step Descarga(nIn = 1, nOut = 1);
  Modelica.StateGraph.TransitionWithSignal t1;
  Modelica.StateGraph.TransitionWithSignal t2;
  Modelica.StateGraph.TransitionWithSignal t3;
  Modelica.StateGraph.TransitionWithSignal t0;
  Modelica.Blocks.Logical.GreaterThreshold MayorQue(threshold = 5);
  Modelica.Blocks.Continuous.TransferFunction Tanque(a = {1, 0}, b = {2});
  Modelica.Blocks.Logical.Switch switch1;
  Modelica.StateGraph.StepWithSignal stepWithSignal(nIn = 1, nOut = 1);
  Modelica.Blocks.Sources.Constant c0(k = 0);
  Modelica.Blocks.Sources.Constant c1(k = 1);
  Modelica.Blocks.Logical.Timer timer;
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 20);
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot;
  Modelica.Blocks.Logical.Switch switch;
  Modelica.Blocks.Sources.BooleanPulse start(period = 100, startTime = 10, width = 1);
  Modelica.Blocks.Sources.BooleanPulse stop(period = 200, startTime = 100, width = 1);
  Modelica.StateGraph.StepWithSignal Operando(nIn = 1, nOut = 1);
equation
  connect(Espera.outPort[1], t1.inPort);
  connect(t3.outPort, Descarga.inPort[1]);
  connect(Descarga.outPort[1], t0.inPort);
  connect(t0.outPort, Espera.inPort[1]);
  connect(MayorQue.y, t2.condition);
  connect(t1.outPort, stepWithSignal.inPort[1]);
  connect(stepWithSignal.outPort[1], t2.inPort);
  connect(c0.y, switch1.u3);
  connect(c1.y, switch1.u1);
  connect(stepWithSignal.active, switch1.u2);
  connect(timer.y, greaterThreshold.u);
  connect(greaterThreshold.y, t3.condition);
  connect(Tanque.u, switch.y);
  connect(start.y, t1.condition);
  connect(Tanque.y, MayorQue.u);
  connect(stop.y, t0.condition);
  connect(switch1.y, switch.u3);
  connect(t2.outPort, Operando.inPort[1]);
  connect(Operando.outPort[1], t3.inPort);
  connect(Operando.active, timer.u);
  connect(switch.u2, Operando.active);
  connect(switch.u1, c0.y);
end mezcla;

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

    package Continuous  "Library of continuous control blocks with internal states" 
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.Package;

      block TransferFunction  "Linear transfer function" 
        import Modelica.Blocks.Types.Init;
        extends Interfaces.SISO;
        parameter Real[:] b = {1} "Numerator coefficients of transfer function (e.g., 2*s+3 is specified as {2,3})";
        parameter Real[:] a = {1} "Denominator coefficients of transfer function (e.g., 5*s+6 is specified as {5,6})";
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation(Evaluate = true);
        parameter Real[size(a, 1) - 1] x_start = zeros(nx) "Initial or guess values of states";
        parameter Real y_start = 0 "Initial value of output (derivatives of y are zero up to nx-1-th derivative)";
        output Real[size(a, 1) - 1] x(start = x_start) "State of transfer function from controller canonical form";
      protected
        parameter Integer na = size(a, 1) "Size of Denominator of transfer function.";
        parameter Integer nb = size(b, 1) "Size of Numerator of transfer function.";
        parameter Integer nx = size(a, 1) - 1;
        parameter Real[:] bb = vector([zeros(max(0, na - nb), 1); b]);
        parameter Real d = bb[1] / a[1];
        parameter Real a_end = if a[end] > 100 * Modelica.Constants.eps * sqrt(a * a) then a[end] else 1.0;
        Real[size(x, 1)] x_scaled "Scaled vector x";
      initial equation
        if initType == Init.SteadyState then
          der(x_scaled) = zeros(nx);
        elseif initType == Init.InitialState then
          x_scaled = x_start * a_end;
        elseif initType == Init.InitialOutput then
          y = y_start;
          der(x_scaled[2:nx]) = zeros(nx - 1);
        end if;
      equation
        assert(size(b, 1) <= size(a, 1), "Transfer function is not proper");
        if nx == 0 then
          y = d * u;
        else
          der(x_scaled[1]) = ((-a[2:na] * x_scaled) + a_end * u) / a[1];
          der(x_scaled[2:nx]) = x_scaled[1:nx - 1];
          y = (bb[2:na] - d * a[2:na]) * x_scaled / a_end + d * u;
          x = x_scaled / a_end;
        end if;
      end TransferFunction;
    end Continuous;

    package Interfaces  "Library of connectors and partial models for input/output blocks" 
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real "'input Real' as connector";
      connector RealOutput = output Real "'output Real' as connector";
      connector BooleanInput = input Boolean "'input Boolean' as connector";
      connector BooleanOutput = output Boolean "'output Boolean' as connector";

      partial block SO  "Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealOutput y "Connector of Real output signal";
      end SO;

      partial block SISO  "Single Input Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealInput u "Connector of Real input signal";
        RealOutput y "Connector of Real output signal";
      end SISO;

      partial block partialBooleanSource  "Partial source block (has 1 output Boolean signal and an appropriate default icon)" 
        extends Modelica.Blocks.Icons.PartialBooleanBlock;
        Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal";
      end partialBooleanSource;

      partial block partialBooleanThresholdComparison  "Partial block to compare the Real input u with a threshold and provide the result as 1 Boolean output signal" 
        parameter Real threshold = 0 "Comparison with respect to threshold";
        Blocks.Interfaces.RealInput u "Connector of Real input signal";
        Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal";
      end partialBooleanThresholdComparison;
    end Interfaces;

    package Logical  "Library of components with Boolean input and output signals" 
      extends Modelica.Icons.Package;

      block GreaterThreshold  "Output y is true, if input u is greater than threshold" 
        extends Blocks.Interfaces.partialBooleanThresholdComparison;
      equation
        y = u > threshold;
      end GreaterThreshold;

      block Switch  "Switch between two Real signals" 
        extends Modelica.Blocks.Icons.PartialBooleanBlock;
        Blocks.Interfaces.RealInput u1 "Connector of first Real input signal";
        Blocks.Interfaces.BooleanInput u2 "Connector of Boolean input signal";
        Blocks.Interfaces.RealInput u3 "Connector of second Real input signal";
        Blocks.Interfaces.RealOutput y "Connector of Real output signal";
      equation
        y = if u2 then u1 else u3;
      end Switch;

      block Timer  "Timer measuring the time from the time instant where the Boolean input became true" 
        extends Modelica.Blocks.Icons.PartialBooleanBlock;
        Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal";
        Blocks.Interfaces.RealOutput y "Connector of Real output signal";
      protected
        discrete SI.Time entryTime "Time instant when u became true";
      initial equation
        pre(entryTime) = 0;
      equation
        when u then
          entryTime = time;
        end when;
        y = if u then time - entryTime else 0.0;
      end Timer;
    end Logical;

    package Sources  "Library of signal source blocks generating Real, Integer and Boolean signals" 
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.SourcesPackage;

      block Constant  "Generate constant signal of type Real" 
        parameter Real k(start = 1) "Constant output value";
        extends Interfaces.SO;
      equation
        y = k;
      end Constant;

      block BooleanPulse  "Generate pulse signal of type Boolean" 
        parameter Real width(final min = Modelica.Constants.small, final max = 100) = 50 "Width of pulse in % of period";
        parameter SI.Time period(final min = Modelica.Constants.small, start = 1) "Time for one period";
        parameter SI.Time startTime = 0 "Time instant of first pulse";
        extends Modelica.Blocks.Interfaces.partialBooleanSource;
      protected
        parameter SI.Time Twidth = period * width / 100 "Width of one pulse" annotation(HideResult = true);
        discrete SI.Time pulseStart "Start time of pulse" annotation(HideResult = true);
      initial equation
        pulseStart = startTime;
      equation
        when sample(startTime, period) then
          pulseStart = time;
        end when;
        y = time >= pulseStart and time < pulseStart + Twidth;
      end BooleanPulse;
    end Sources;

    package Types  "Library of constants, external objects and types with choices, especially to build menus" 
      extends Modelica.Icons.TypesPackage;
      type Init = enumeration(NoInit "No initialization (start values are used as guess values with fixed=false)", SteadyState "Steady state initialization (derivatives of states are zero)", InitialState "Initialization with initial states", InitialOutput "Initialization with initial outputs (and steady state of the states if possible)") "Enumeration defining initialization of a block" annotation(Evaluate = true);
    end Types;

    package Icons  "Icons for Blocks" 
      extends Modelica.Icons.IconsPackage;

      partial block Block  "Basic graphical layout of input/output block" end Block;

      partial block PartialBooleanBlock  "Basic graphical layout of logical block" end PartialBooleanBlock;
    end Icons;
  end Blocks;

  package StateGraph  "Library of hierarchical state machine components to model discrete event and reactive systems" 
    extends Modelica.Icons.Package;
    import Modelica.Units.SI;

    package Interfaces  "Connectors and partial models" 
      extends Modelica.Icons.InterfacesPackage;

      connector Step_in  "Input port of a step" 
        output Boolean occupied "= true, if step is active" annotation(HideResult = true);
        input Boolean set "= true, if transition fires and step is activated" annotation(HideResult = true);
      end Step_in;

      connector Step_out  "Output port of a step" 
        output Boolean available "= true, if step is active" annotation(HideResult = true);
        input Boolean reset "= true, if transition fires and step is deactivated" annotation(HideResult = true);
      end Step_out;

      connector Transition_in  "Input port of a transition" 
        input Boolean available "= true, if step connected to the transition input is active" annotation(HideResult = true);
        output Boolean reset "= true, if transition fires and the step connected to the transition input is deactivated" annotation(HideResult = true);
      end Transition_in;

      connector Transition_out  "Output port of a transition" 
        input Boolean occupied "= true, if step connected to the transition output is active" annotation(HideResult = true);
        output Boolean set "= true, if transition fires and step connected to the transition output becomes active" annotation(HideResult = true);
      end Transition_out;

      connector CompositeStepStatePort_in  "Communication port between a CompositeStep and the ordinary steps within the CompositeStep (suspend/resume are inputs)" 
        input Boolean suspend "= true, if suspend transition of CompositeStep fires";
        input Boolean resume "= true, if resume transition of CompositeStep fires";
        Real activeStepsDummy "Dummy variable in order that connector fulfills restriction of connector" annotation(HideResult = true);
        flow Real activeSteps "Number of active steps in the CompositeStep";
      end CompositeStepStatePort_in;

      connector CompositeStepStatePort_out  "Communication port between a CompositeStep and the ordinary steps within the CompositeStep (suspend/resume are outputs)" 
        output Boolean suspend "= true, if suspend transition of CompositeStep fires";
        output Boolean resume "= true, if resume transition of CompositeStep fires";
        Real activeStepsDummy "Dummy variable in order that connector fulfills restriction of connector" annotation(HideResult = true);
        flow Real activeSteps "Number of active steps in the CompositeStep";
      end CompositeStepStatePort_out;

      partial block PartialStep  "Partial step with one input and one output transition port" 
        parameter Integer nIn(min = 0) = 0 "Number of input connections" annotation(HideResult = true);
        parameter Integer nOut(min = 0) = 0 "Number of output connections" annotation(HideResult = true);
        output Boolean localActive "= true, if step is active, otherwise the step is not active" annotation(HideResult = true);
        Interfaces.Step_in[nIn] inPort "Vector of step input connectors";
        Interfaces.Step_out[nOut] outPort "Vector of step output connectors";
      protected
        outer Interfaces.CompositeStepState stateGraphRoot;

        model OuterStatePort  
          CompositeStepStatePort_in subgraphStatePort;
          input Boolean localActive;
        equation
          subgraphStatePort.activeSteps = if localActive then 1.0 else 0.0;
        end OuterStatePort;

        OuterStatePort outerStatePort(localActive = localActive);
        Boolean newActive "Value of active in the next iteration" annotation(HideResult = true);
        Boolean oldActive "Value of active when CompositeStep was aborted";
      initial equation
        pre(newActive) = pre(localActive);
        pre(oldActive) = pre(localActive);
      equation
        connect(outerStatePort.subgraphStatePort, stateGraphRoot.subgraphStatePort);
        for i in 1:nIn loop
          assert(cardinality(inPort[i]) <= 1, "Connector is connected to more than one transition (this is not allowed)");
        end for;
        for i in 1:nOut loop
          assert(cardinality(outPort[i]) <= 1, "Connector is connected to more than one transition (this is not allowed)");
        end for;
        localActive = pre(newActive);
        newActive = if outerStatePort.subgraphStatePort.resume then oldActive else (Modelica.Math.BooleanVectors.anyTrue(inPort.set) or localActive and not Modelica.Math.BooleanVectors.anyTrue(outPort.reset)) and not outerStatePort.subgraphStatePort.suspend;
        when outerStatePort.subgraphStatePort.suspend then
          oldActive = localActive;
        end when;
        for i in 1:nIn loop
          inPort[i].occupied = if i == 1 then localActive else inPort[i - 1].occupied or inPort[i - 1].set;
        end for;
        for i in 1:nOut loop
          outPort[i].available = if i == 1 then localActive else outPort[i - 1].available and not outPort[i - 1].reset;
        end for;
        for i in 1:nIn loop
          if cardinality(inPort[i]) == 0 then
            inPort[i].set = false;
          end if;
        end for;
        for i in 1:nOut loop
          if cardinality(outPort[i]) == 0 then
            outPort[i].reset = false;
          end if;
        end for;
      end PartialStep;

      partial block PartialTransition  "Partial transition with input and output connections" 
        input Boolean localCondition "= true, if transition may fire" annotation(HideResult = true);
        parameter Boolean enableTimer = false "= true, if timer is enabled" annotation(Evaluate = true);
        parameter SI.Time waitTime(min = 0) = 0 "Wait time before transition fires";
        output SI.Time t "Actual waiting time (transition will fire when t > waitTime)";
        output Boolean enableFire "= true, if all firing conditions are true";
        output Boolean fire "= true, if transition fires" annotation(HideResult = true);
        StateGraph.Interfaces.Transition_in inPort "Vector of transition input connectors";
        StateGraph.Interfaces.Transition_out outPort "Vector of transition output connectors";
      protected
        discrete SI.Time t_start "Time instant at which the transition would fire, if waitTime would be zero";
        Real t_dummy;
      initial equation
        pre(t_start) = time;
        pre(enableFire) = false;
      equation
        assert(cardinality(inPort) == 1, "Connector inPort is not connected to exactly one other connector");
        assert(cardinality(outPort) == 1, "Connector outPort is not connected to exactly one other connector");
        if enableTimer then
          when enableFire then
            t_start = time;
          end when;
          t_dummy = time - t_start;
          t = if enableFire then t_dummy else 0;
          fire = enableFire and time >= t_start + waitTime;
        else
          when false then
            t_start = pre(t_start);
          end when;
          t_dummy = 0;
          t = 0;
          fire = enableFire;
        end if;
        enableFire = localCondition and inPort.available and not outPort.occupied;
        inPort.reset = fire;
        outPort.set = fire;
      end PartialTransition;

      model CompositeStepState  "Communication channel between CompositeSteps and steps in the CompositeStep" 
        output Boolean suspend = false "= true, if suspend transition of CompositeStep fires";
        output Boolean resume = false "= true, if resume transition of CompositeStep fires";
        CompositeStepStatePort_out subgraphStatePort;
      equation
        suspend = subgraphStatePort.suspend;
        resume = subgraphStatePort.resume;
        subgraphStatePort.activeStepsDummy = 0;
        annotation(defaultComponentPrefixes = "inner", missingInnerMessage = "A \"stateGraphRoot\" component was automatically introduced."); 
      end CompositeStepState;
    end Interfaces;

    block InitialStep  "Initial step (= step that is active when simulation starts)" 
      output Boolean active "= true, if step is active, otherwise the step is not active";
      extends Interfaces.PartialStep;
    initial equation
      active = true;
    equation
      active = localActive;
    end InitialStep;

    block Step  "Ordinary step (= step that is not active when simulation starts)" 
      output Boolean active "= true, if step is active, otherwise the step is not active";
      extends Interfaces.PartialStep;
    initial equation
      active = false;
    equation
      active = localActive;
    end Step;

    block StepWithSignal  "Ordinary step (= step that is not active when simulation starts). Connector 'active' is true when the step is active" 
      extends Interfaces.PartialStep;
      Modelica.Blocks.Interfaces.BooleanOutput active;
    initial equation
      active = false;
    equation
      active = localActive;
    end StepWithSignal;

    block TransitionWithSignal  "Transition where the fire condition is set by a Boolean input signal" 
      Modelica.Blocks.Interfaces.BooleanInput condition;
      extends Interfaces.PartialTransition(final localCondition = condition);
    end TransitionWithSignal;

    model StateGraphRoot  "Root of a StateGraph (has to be present on the highest level of a StateGraph)" 
      extends StateGraph.Interfaces.CompositeStepState;
      output Integer activeSteps "Number of active steps within the stategraph";
    equation
      activeSteps = -integer(subgraphStatePort.activeSteps);
      annotation(defaultComponentPrefixes = "inner"); 
    end StateGraphRoot;
  end StateGraph;

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    extends Modelica.Icons.Package;

    package BooleanVectors  "Library of functions operating on Boolean vectors" 
      extends Modelica.Icons.Package;

      function anyTrue  "Returns true, if at least one element of the Boolean input vector is true ('or')" 
        extends Modelica.Icons.Function;
        input Boolean[:] b "Boolean vector";
        output Boolean result "= true, if at least one element of b is true";
      algorithm
        result := false;
        for i in 1:size(b, 1) loop
          result := result or b[i];
        end for;
      end anyTrue;
    end BooleanVectors;

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
    final constant Real small = ModelicaServices.Machine.small "Smallest number such that small and -small are representable on the machine";
    final constant SI.Velocity c = 299792458 "Speed of light in vacuum";
    final constant SI.ElectricCharge q = 1.602176634e-19 "Elementary charge";
    final constant Real h(final unit = "J.s") = 6.62607015e-34 "Planck constant";
    final constant Real k(final unit = "J/K") = 1.380649e-23 "Boltzmann constant";
    final constant Real N_A(final unit = "1/mol") = 6.02214076e23 "Avogadro constant";
    final constant Real mu_0(final unit = "N/A2") = 4 * pi * 1.00000000055e-7 "Magnetic constant";
  end Constants;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial package Package  "Icon for standard packages" end Package;

    partial package InterfacesPackage  "Icon for packages containing interfaces" 
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package SourcesPackage  "Icon for packages containing sources" 
      extends Modelica.Icons.Package;
    end SourcesPackage;

    partial package TypesPackage  "Icon for packages containing type definitions" 
      extends Modelica.Icons.Package;
    end TypesPackage;

    partial package IconsPackage  "Icon for packages containing icons" 
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial function Function  "Icon for functions" end Function;
  end Icons;

  package Units  "Library of type and unit definitions" 
    extends Modelica.Icons.Package;

    package SI  "Library of SI unit definitions" 
      extends Modelica.Icons.Package;
      type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
      type Time = Real(final quantity = "Time", final unit = "s");
      type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
      type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
      type ElectricCharge = Real(final quantity = "ElectricCharge", final unit = "C");
      type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
    end SI;

    package NonSI  "Type definitions of non SI and other units" 
      extends Modelica.Icons.Package;
      type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC") "Absolute temperature in degree Celsius (for relative temperature use Modelica.Units.SI.TemperatureDifference)" annotation(absoluteValue = true);
    end NonSI;
  end Units;
  annotation(version = "4.0.0", versionDate = "2020-06-04", dateModified = "2020-06-04 11:00:00Z"); 
end Modelica;

model mezcla_total
  extends mezcla;
end mezcla_total;
