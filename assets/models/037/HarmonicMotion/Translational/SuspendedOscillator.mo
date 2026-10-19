within HarmonicMotion.Translational;
model SuspendedOscillator
  "A gravity-loaded spring-mass channel hung from a sag-cancelling rigid rod"
  import Modelica.Mechanics.MultiBody;
  import Modelica.Constants.pi;

  // ---- Physical parameters ----
  parameter Modelica.Units.SI.Mass m = 0.5
    "Oscillating mass (sets the natural period of this channel)";
  parameter Modelica.Units.SI.TranslationalSpringConstant c = 10
    "Spring stiffness";
  parameter Modelica.Units.SI.Length springFreeLength = 0.15
    "Unstretched spring length (the SAME for every channel)";
  parameter Modelica.Units.SI.Length rodLength = 0.5
    "Length of the rigid suspension rod (differs per channel)";
  parameter Modelica.Units.SI.Length amplitude = 0.15
    "Initial upward displacement from rest";
  parameter Modelica.Units.SI.Position x = 0
    "Lateral position of this channel (offset along the world x-axis)";
  parameter Modelica.Units.SI.Acceleration g = Modelica.Constants.g_n
    "Gravity magnitude (must match the enclosing world)";

  // ---- Visual style ----
  parameter Modelica.Units.SI.Diameter ballDiameter = 0.09
    "Ball sphere diameter";
  parameter Modelica.Units.SI.Diameter rodDiameter = 0.02
    "Rod diameter";
  parameter MultiBody.Types.Color ballColor = {0, 120, 255}
    "Ball colour {R, G, B}";
  parameter MultiBody.Types.Color rodColor = {90, 90, 90}
    "Rod colour {R, G, B}";
  parameter MultiBody.Types.Color springColor = {170, 170, 170}
    "Spring colour {R, G, B}";

  // ---- Derived (read-only) ----
  final parameter Modelica.Units.SI.Time T_period = 2*pi*sqrt(m/c)
    "Natural period — 2π√(m/c)";
  final parameter Modelica.Units.SI.Length sag = m*g/c
    "Static extension of the spring under gravity";
  final parameter Modelica.Units.SI.Length sInit =
    springFreeLength + sag - amplitude
    "Initial spring extension: starts the ball 'amplitude' above its rest line";
  final parameter Modelica.Units.SI.Length restDepth =
    rodLength + springFreeLength + sag
    "Depth of the rest line below the ceiling (equal on every channel)";

  // ---- MultiBody components ----
  MultiBody.Parts.Fixed ceiling(
    r         = {x, 0, 0},
    animation = false)
    "Attachment point on the shared ceiling"
    annotation (Placement(transformation(origin = {-30, -18}, extent={{-10,78},{10,98}})));

  MultiBody.Parts.BodyCylinder rod(
    r        = {0, -rodLength, 0},
    diameter = rodDiameter,
    color    = rodColor)
    "Rigid suspension rod — its length sets where the spring hangs"
    annotation (Placement(transformation(
      origin = {40,50}, extent = {{-10,-10},{10,10}}, rotation = 270)));

  MultiBody.Joints.Prismatic prismatic(
    n         = {0, -1, 0},
    animation = false,
    s(start = sInit, fixed = true),
    v(start = 0, fixed = true))
    "Ideal guide — constrains the ball to the vertical axis"
    annotation (Placement(transformation(
      origin = {0,6}, extent = {{-10,-10},{10,10}}, rotation = 270)));

  MultiBody.Forces.Spring spring(
    c                = c,
    s_unstretched    = springFreeLength,
    width            = 0.03,
    coilWidth        = 0.008,
    numberOfWindings = 6,
    color            = springColor)
    "Identical animated coil spring"
    annotation (Placement(transformation(
      origin = {40,6}, extent = {{-10,-10},{10,10}}, rotation = 270)));

  MultiBody.Parts.Body ball(
    m              = m,
    r_CM           = {0, 0, 0},
    sphereDiameter = ballDiameter,
    sphereColor    = ballColor)
    "The dancing mass"
    annotation (Placement(transformation(origin = {108, -65}, extent={{-10,-78},{10,-58}}, rotation = -90)));

equation
  connect(ceiling.frame_b, rod.frame_a) annotation (Line(
      points = {{-20, 70}, {-20, 70},{40, 70}, {40,60}}, color = {95,95,95}, thickness = 0.5));
  connect(rod.frame_b, prismatic.frame_a) annotation (
      Line(points = {{20, 16.347},{20, 3.5}, {-20, 3.5}, {-20, -7.653}}, color = {95,95,95}, thickness = 0.5, origin = {20, 23.653}));
  connect(prismatic.frame_b, ball.frame_a) annotation (Line(
      points = {{-20, 26.25}, {-20, 10.25},{20, 10.25}, {20,-24.75}}, color = {95,95,95}, thickness = 0.5, origin = {20, -30.25}));
  connect(rod.frame_b, spring.frame_a) annotation(
      Line(points = {{40,40},{40,40},{40,16}}, color = {95,95,95}, thickness = 0.5));
  connect(spring.frame_b, ball.frame_a) annotation (Line(
      points = {{40,-4},{40,-55},{40,-55}}, color = {95,95,95}, thickness = 0.5));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics = {
      Rectangle(extent = {{-100,100},{100,-100}},
        lineColor = {0,0,0}, fillColor = {255,255,255},
        fillPattern = FillPattern.Solid),
      Line(points = {{-60,92},{60,92}}, color = {95,95,95}, thickness = 1),
      Rectangle(extent = {{-5,90},{5,40}}, lineColor = {90,90,90},
        fillColor = {90,90,90}, fillPattern = FillPattern.Solid),
      Line(points = {{0,40},{0,26},{-22,20},{22,6},{-22,-8},{22,-22},
        {0,-28},{0,-40}}, color = {120,120,120}),
      Ellipse(extent = {{-34,-40},{34,-96}}, lineColor = {0,0,0},
        fillColor = {0,120,255}, fillPattern = FillPattern.Sphere)}),
    Documentation(info="<html>
<h4>HarmonicMotion.Translational.SuspendedOscillator</h4>
<p>
  A hanging spring&ndash;mass channel for the <em>aligned</em> mercury wave.
  The spring is identical on every channel; the whole per-channel geometric
  difference is carried by a rigid <code>BodyCylinder</code> rod whose length
  is chosen so that the gravitational sag <code>m&nbsp;g/c</code> is cancelled
  and every mass rests on a common horizontal line.
</p>

<h5>Parameters</h5>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Name</th><th>Description</th><th>Default</th></tr>
  <tr><td><code>m</code></td><td>Oscillating mass (kg)</td><td>0.5</td></tr>
  <tr><td><code>c</code></td><td>Spring stiffness (N/m)</td><td>10</td></tr>
  <tr><td><code>springFreeLength</code></td>
      <td>Unstretched spring length, identical on all channels (m)</td>
      <td>0.15</td></tr>
  <tr><td><code>rodLength</code></td>
      <td>Rigid rod length, channel specific (m)</td><td>0.5</td></tr>
  <tr><td><code>amplitude</code></td>
      <td>Initial upward displacement from rest (m)</td><td>0.15</td></tr>
  <tr><td><code>x</code></td>
      <td>Lateral position of the channel along the world x-axis (m)</td>
      <td>0.0</td></tr>
  <tr><td><code>g</code></td>
      <td>Gravity magnitude, must match the enclosing world (m/s²)</td>
      <td><code>Modelica.Constants.g_n</code></td></tr>
</table>

<h5>Derived quantities</h5>
<pre>
  T_period  = 2&pi;&radic;(m/c)                              natural period
  sag       = m g / c                                  static spring extension
  sInit     = springFreeLength + sag &minus; amplitude        initial spring extension
  restDepth = rodLength + springFreeLength + sag       rest line below the ceiling
</pre>
<p>
  Setting <code>rodLength = restDepth &minus; springFreeLength &minus; m&nbsp;g/c</code>
  with a common <code>restDepth</code> makes every ball rest on the same line
  &mdash; this is exactly what
  <a href=\"modelica://HarmonicMotion.Translational.MercuryWaveAligned\">
  MercuryWaveAligned</a> does.
</p>

<h5>Energy</h5>
<p>
  Measuring the ball displacement <code>u = s &minus; sInit &minus; amplitude</code>
  from the static rest position, gravity and the spring preload cancel and the
  motion is a pure harmonic oscillation of amplitude <code>amplitude</code>
  about the rest line.
</p>
</html>"),
    experiment(
      StopTime  = 10,
      Interval  = 0.01,
      Tolerance = 1e-8));
end SuspendedOscillator;
