within DiodeAttempts.Examples;
model Rectifier "Half-wave rectifier: sine source, diode under test, resistive load"
  extends Modelica.Icons.Example;

  replaceable Modelica.Electrical.Analog.Ideal.IdealDiode diode
    constrainedby Modelica.Electrical.Analog.Interfaces.OnePort "Diode under test"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={0,40})));
  Modelica.Electrical.Analog.Sources.SineVoltage source(V = 10, f = 50) "10 V, 50 Hz source"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-40,0}, rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor load(R = 100) "Load"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={40,0}, rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-40,-40})));

equation
  connect(source.p, diode.p) annotation (Line(points={{-40,10},{-40,40},{-10,40}}, color={0,0,255}));
  connect(diode.n, load.p) annotation (Line(points={{10,40},{40,40},{40,10}}, color={0,0,255}));
  connect(load.n, source.n) annotation (Line(points={{40,-10},{40,-20},{-40,-20},{-40,-10}}, color={0,0,255}));
  connect(source.n, ground.p) annotation (Line(points={{-40,-10},{-40,-30}}, color={0,0,255}));

  annotation (experiment(StopTime = 0.04, Interval = 1e-5),
    Diagram(coordinateSystem(extent={{-80,-60},{80,60}})));
end Rectifier;
