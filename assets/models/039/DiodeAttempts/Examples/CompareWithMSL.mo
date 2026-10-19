within DiodeAttempts.Examples;
model CompareWithMSL "Our s-diode with losses next to Modelica.Electrical.Analog.Ideal.IdealDiode"
  extends Modelica.Icons.Example;

  // Exaggerated losses so the knee and the slopes are visible in plots
  parameter Modelica.Units.SI.Resistance Ron = 0.5 "Resistance when conducting";
  parameter Modelica.Units.SI.Conductance Goff = 1e-3 "Conductance when blocking";
  parameter Modelica.Units.SI.Voltage Vknee = 0.7 "Forward threshold voltage";

  Rectifier ours(
    redeclare Diodes.ParametricDiodeWithLosses diode(Ron = Ron, Goff = Goff, Vknee = Vknee))
    "Rectifier with our diode"
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
  Rectifier msl(
    redeclare Modelica.Electrical.Analog.Ideal.IdealDiode diode(Ron = Ron, Goff = Goff, Vknee = Vknee))
    "Rectifier with the MSL diode"
    annotation (Placement(transformation(extent={{20,-20},{60,20}})));

  Modelica.Units.SI.Current deltaI = ours.diode.i - msl.diode.i "Current difference (should stay ~0)";

  annotation (experiment(StopTime = 0.04, Interval = 1e-5));
end CompareWithMSL;
