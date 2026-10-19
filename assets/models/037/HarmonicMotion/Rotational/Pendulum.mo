within HarmonicMotion.Rotational;
model Pendulum "A single planar pendulum suspended from a fixed point"
  import Modelica.Mechanics.MultiBody;
  import Modelica.Constants.pi;
  import Modelica.Constants.g_n;

  // ---- Physical parameters ----
  parameter Modelica.Units.SI.Length L = 1.0
    "String length (sets the natural period of this channel)";
  parameter Modelica.Units.SI.Mass m = 1.0
    "Bob mass";
  parameter Modelica.Units.SI.Angle phi = 0.5
    "Initial angle from vertical (rad, positive = rightward)";
  parameter Modelica.Units.SI.Position x = 0.0
    "Lateral position of this channel (offset along the world z-axis)";

  // ---- Visual style ----
  parameter Modelica.Units.SI.Diameter d = 0.01
    "String and revolute-axis diameter";
  parameter Modelica.Units.SI.Diameter ballDiameter = 5*d
    "Bob sphere diameter";
  parameter MultiBody.Types.Color ballColor = {0, 120, 255}
    "Bob colour {R, G, B}";
  parameter MultiBody.Types.Color stringColor = ballColor
    "String colour {R, G, B}";

  // ---- Derived (read-only) ----
  final parameter Modelica.Units.SI.Time T_period = 2*pi*sqrt(L/g_n)
    "Small-angle period — 2π√(L/g)";

  // ---- MultiBody components ----
  MultiBody.Parts.Fixed anchor(
    r         = {0, 0, x},
    animation = false)
    "Fixed suspension point on the top rail"
    annotation (Placement(transformation(
        extent   = {{-10,-10},{10,10}},
        rotation = 270,
        origin   = {0,60})));

  MultiBody.Joints.Revolute revolute(
    phi(fixed = true, start = phi),
    w(fixed   = true, start = 0),
    cylinderDiameter = d/2,
    animation        = false)
    "Ideal hinge — constrains the bob to a single swing plane"
    annotation (Placement(transformation(
        extent   = {{-10,-10},{10,10}},
        rotation = 90,
        origin   = {0,20})));

  MultiBody.Parts.BodyCylinder string(
    density  = 0,
    r        = {0, L, 0},
    diameter = d,
    color    = stringColor)
    "Massless string of length L"
    annotation (Placement(transformation(
        extent   = {{-10,-10},{10,10}},
        rotation = 90,
        origin   = {0,-30})));

  MultiBody.Parts.PointMass ball(
    m              = m,
    sphereDiameter = ballDiameter,
    sphereColor    = ballColor)
    "The swinging bob"
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));

equation
  connect(string.frame_a, ball.frame_a) annotation (Line(
      points    = {{0,-40},{0,-80}},
      color     = {95,95,95},
      thickness = 0.5));
  connect(revolute.frame_b, anchor.frame_b) annotation (Line(
      points    = {{0,30},{0,50}},
      color     = {95,95,95},
      thickness = 0.5));
  connect(revolute.frame_a, string.frame_b) annotation (Line(
      points    = {{0,10},{0,-20}},
      color     = {95,95,95},
      thickness = 0.5));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics = {
      Rectangle(extent = {{-100,100},{100,-100}},
        lineColor = {0,0,0}, fillColor = {255,255,255},
        fillPattern = FillPattern.Solid),
      Line(points = {{-60,90},{60,90}}, color = {95,95,95}, thickness = 1),
      Line(points = {{0,90},{0,-40}}, color = {200,200,200},
        pattern = LinePattern.Dot),
      Line(points = {{0,90},{46,-30}}, color = {120,120,120}),
      Ellipse(extent = {{20,-30},{80,-90}}, lineColor = {0,0,0},
        fillColor = {0,120,255}, fillPattern = FillPattern.Sphere)}),
    Documentation(info="<html>
<h4>HarmonicMotion.Rotational.Pendulum</h4>
<p>
  A single planar pendulum: a massless string of length <strong>L</strong>
  carrying a point-mass bob of mass <strong>m</strong>, suspended from a
  fixed point and free to rotate in one plane.
</p>

<h5>Parameters</h5>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Name</th><th>Description</th><th>Default</th></tr>
  <tr><td><code>L</code></td><td>String length (m)</td><td>1.0</td></tr>
  <tr><td><code>m</code></td><td>Bob mass (kg)</td><td>1.0</td></tr>
  <tr><td><code>phi</code></td>
      <td>Initial angle from vertical (rad, positive = rightward)</td>
      <td>0.5</td></tr>
  <tr><td><code>x</code></td>
      <td>Lateral position of the channel along the world z-axis (m)</td>
      <td>0.0</td></tr>
  <tr><td><code>d</code></td><td>String / axis diameter (m)</td><td>0.01</td></tr>
  <tr><td><code>ballDiameter</code></td><td>Bob sphere diameter (m)</td>
      <td>5&middot;<code>d</code></td></tr>
  <tr><td><code>ballColor</code></td>
      <td>RGB colour of the bob {R, G, B}</td><td>{0, 120, 255}</td></tr>
  <tr><td><code>stringColor</code></td>
      <td>RGB colour of the string {R, G, B}</td>
      <td><code>ballColor</code></td></tr>
</table>

<h5>Derived quantity</h5>
<p>
  <code>T_period = 2&pi;&radic;(L/g)</code> &mdash; the small-angle period,
  exposed as a <em>final</em> parameter for convenient inspection and for use
  in the test and analysis models.
</p>

<h5>Standalone vs. system use</h5>
<p>
  <code>Pendulum</code> is a <em>component</em>: it does not include its own
  <code>inner&nbsp;World</code> and therefore needs an enclosing model that
  provides one. Two ways to use it:
</p>
<ul>
  <li><strong>As a system:</strong> instantiate it inside
      <a href=\"modelica://HarmonicMotion.Rotational.PendulumWave\">
      PendulumWave</a>, which declares the shared
      <code>inner&nbsp;World</code>.</li>
  <li><strong>Standalone / test:</strong> extend it as done in
      <a href=\"modelica://HarmonicMotion.Tests.Rotational\">Tests.Rotational</a>;
      each of those models declares its own <code>inner&nbsp;World</code>.</li>
</ul>

<h5>Energy</h5>
<p>
  With zero initial angular velocity, total mechanical energy is conserved:
  <br/>
  E&nbsp;=&nbsp;m&nbsp;g&nbsp;L&nbsp;(1&nbsp;&minus;&nbsp;cos&nbsp;&phi;<sub>0</sub>)
  <br/>
  The string is massless (<code>density&nbsp;=&nbsp;0</code>) and the
  revolute joint is ideal, so no energy is dissipated.
</p>

<h5>Translational counterpart</h5>
<p>
  <a href=\"modelica://HarmonicMotion.Translational.Oscillator\">
  Translational.Oscillator</a> plays exactly the same role in the
  mercury-wave variant, but is tuned by mass instead of by length.
</p>
</html>"),
    experiment(
      StopTime  = 10,
      Interval  = 0.01,
      Tolerance = 1e-8));
end Pendulum;
