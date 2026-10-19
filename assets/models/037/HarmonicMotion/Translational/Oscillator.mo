within HarmonicMotion.Translational;
model Oscillator
  "A single vertical spring-mass channel of the mercury wave"
  import Modelica.Mechanics.MultiBody;
  import Modelica.Constants.pi;

  // ---- Physical parameters ----
  parameter Modelica.Units.SI.Mass m = 0.5
    "Oscillating mass (sets the natural period of this channel)";
  parameter Modelica.Units.SI.TranslationalSpringConstant c = 10
    "Spring stiffness";
  parameter Modelica.Units.SI.Length springLength = 0.5
    "Unstretched spring length (sets the rest height of this ball)";
  parameter Modelica.Units.SI.Length amplitude = 0.15
    "Initial upward displacement from rest";
  parameter Modelica.Units.SI.Position x = 0
    "Lateral position of this channel (offset along the world x-axis)";

  // ---- Visual style ----
  parameter Modelica.Units.SI.Diameter ballDiameter = 0.09
    "Ball sphere diameter";
  parameter MultiBody.Types.Color ballColor = {0, 120, 255}
    "Ball colour {R, G, B}";
  parameter MultiBody.Types.Color springColor = {170, 170, 170}
    "Spring colour {R, G, B}";

  // ---- Derived (read-only) ----
  final parameter Modelica.Units.SI.Time T_period = 2*pi*sqrt(m/c)
    "Natural period — 2π√(m/c)";

  // ---- MultiBody components ----
  MultiBody.Parts.Fixed anchor(
    r         = {x, 0, 0},
    animation = false)
    "Fixed mounting point on the top rail"
    annotation (Placement(transformation(origin = {-25, -10}, extent={{-10,60},{10,80}})));

  MultiBody.Joints.Prismatic prismatic(
    n         = {0, -1, 0},
    animation = false,
    s(start = springLength - amplitude, fixed = true),
    v(start = 0, fixed = true))
    "Ideal guide — constrains the ball to the vertical axis"
    annotation (Placement(transformation(
      origin = {0, 11.744}, extent = {{-10,-10},{10,10}}, rotation = 270)));

  MultiBody.Forces.Spring spring(
    c                = c,
    s_unstretched    = springLength,
    width            = 0.03,
    coilWidth        = 0.008,
    numberOfWindings = 8,
    color            = springColor)
    "Animated coil spring"
    annotation (Placement(transformation(
      origin = {40,10}, extent = {{-10,-10},{10,10}}, rotation = 270)));

  MultiBody.Parts.Body ball(
    m              = m,
    r_CM           = {0, 0, 0},
    sphereDiameter = ballDiameter,
    sphereColor    = ballColor)
    "The dancing mass"
    annotation (Placement(transformation(origin = {100, -60}, extent={{-10,-70},{10,-50}}, rotation = -90)));

equation
  connect(anchor.frame_b, prismatic.frame_a) annotation (Line(
      points = {{-15, 43.983}, {-15, 43.983}, {-0, 43.983},{-0, 5.727}}, color = {95,95,95}, thickness = 0.5, origin = {0, 16.017}));
  connect(prismatic.frame_b, ball.frame_a) annotation (Line(
      points = {{-20, 37.18}, {-20, 10.436}, {20, 10.436},{20,-14.564}}, color = {95,95,95}, thickness = 0.5, origin = {20, -35.436}));
  connect(anchor.frame_b, spring.frame_a) annotation (
      Line(points = {{-36.667, 13.333},{18.333, 13.333},{18.333, -26.667}}, color = {95,95,95}, thickness = 0.5, origin = {21.667, 46.667}));
  connect(spring.frame_b, ball.frame_a) annotation(
      Line(points = {{40,0},{40,-50},{40,-50}}, color = {95,95,95}, thickness = 0.5));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics = {
      Rectangle(extent = {{-100,100},{100,-100}},
        lineColor = {0,0,0}, fillColor = {255,255,255},
        fillPattern = FillPattern.Solid),
      Line(points = {{-60,90},{60,90}}, color = {95,95,95}, thickness = 1),
      Line(points = {{0,90},{0,70},{-24,62},{24,46},{-24,30},{24,14},
        {-24,-2},{0,-10},{0,-30}}, color = {120,120,120}),
      Ellipse(extent = {{-34,-30},{34,-96}}, lineColor = {0,0,0},
        fillColor = {0,120,255}, fillPattern = FillPattern.Sphere)}),
    Documentation(info="<html>
<h4>HarmonicMotion.Translational.Oscillator</h4>
<p>
  One vertical spring&ndash;mass channel built from MultiBody parts: a fixed
  anchor, a prismatic joint that constrains the motion to the vertical axis,
  an animated coil <code>Spring</code> and a spherical <code>Body</code>.
</p>

<h5>Parameters</h5>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Name</th><th>Description</th><th>Default</th></tr>
  <tr><td><code>m</code></td><td>Oscillating mass (kg)</td><td>0.5</td></tr>
  <tr><td><code>c</code></td><td>Spring stiffness (N/m)</td><td>10</td></tr>
  <tr><td><code>springLength</code></td>
      <td>Unstretched spring length, i.e. the rest height (m)</td><td>0.5</td></tr>
  <tr><td><code>amplitude</code></td>
      <td>Initial upward displacement from rest (m)</td><td>0.15</td></tr>
  <tr><td><code>x</code></td>
      <td>Lateral position of the channel along the world x-axis (m)</td>
      <td>0.0</td></tr>
  <tr><td><code>ballDiameter</code></td><td>Sphere diameter (m)</td><td>0.09</td></tr>
  <tr><td><code>ballColor</code></td>
      <td>RGB colour of the ball {R, G, B}</td><td>{0, 120, 255}</td></tr>
  <tr><td><code>springColor</code></td>
      <td>RGB colour of the coil {R, G, B}</td><td>{170, 170, 170}</td></tr>
</table>

<h5>Derived quantity</h5>
<p>
  <code>T_period = 2&pi;&radic;(m/c)</code> &mdash; the natural period,
  exposed as a <em>final</em> parameter, exactly mirroring
  <code>T_period</code> of
  <a href=\"modelica://HarmonicMotion.Rotational.Pendulum\">
  Rotational.Pendulum</a>.
</p>

<h5>Gravity</h5>
<p>
  This component is intended for the <strong>gravity-free</strong> staging
  used by
  <a href=\"modelica://HarmonicMotion.Translational.MercuryWave\">
  MercuryWave</a>: the ball rests exactly at the unstretched spring length,
  so <code>springLength</code> directly sets its rest height and the springs
  are easy to tell apart. For the gravity-loaded, aligned staging use
  <a href=\"modelica://HarmonicMotion.Translational.SuspendedOscillator\">
  SuspendedOscillator</a>.
</p>

<h5>Standalone vs. system use</h5>
<p>
  <code>Oscillator</code> is a <em>component</em>: it does not include its own
  <code>inner&nbsp;World</code>. Instantiate it inside
  <a href=\"modelica://HarmonicMotion.Translational.MercuryWave\">
  MercuryWave</a>, or extend it as done in
  <a href=\"modelica://HarmonicMotion.Tests.Translational\">
  Tests.Translational</a>.
</p>

<h5>Energy</h5>
<p>
  Without gravity and with an ideal joint, total mechanical energy is
  conserved:
</p>
<pre>
  E = &frac12; m v&sup2; + &frac12; c (s &minus; springLength)&sup2;  &equiv;  &frac12; c amplitude&sup2;
</pre>
</html>"),
    experiment(
      StopTime  = 10,
      Interval  = 0.01,
      Tolerance = 1e-8));
end Oscillator;
