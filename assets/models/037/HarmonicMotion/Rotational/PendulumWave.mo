within HarmonicMotion.Rotational;
model PendulumWave
  "The pendulum wave: n pendula whose lengths form an even frequency ladder"
  import Modelica.Mechanics.MultiBody;
  import Modelica.Constants.g_n;
  import Modelica.Constants.pi;

  // ---- Wave tuning (identical parameter set as Translational.MercuryWave) ----
  parameter Integer n = 15
    "Number of pendula";
  parameter Modelica.Units.SI.Time T = 54
    "Pattern cycle time — after T s the whole row is back in phase";
  parameter Real X = 30
    "Number of oscillations performed by the slowest pendulum (pendulum n) in T";
  parameter Modelica.Units.SI.Angle phi0 = 0.5
    "Common initial angle of every pendulum (rad)";
  parameter Boolean exactPeriod = true
    "= true, correct the lengths for the finite-amplitude (nonlinear) period";

  // ---- Geometry ----
  parameter Modelica.Units.SI.Distance dx = 0.05
    "Lateral spacing between neighbouring pendula";
  parameter Modelica.Units.SI.Mass m = 1.0
    "Common bob mass (does not influence the period)";
  parameter Modelica.Units.SI.Diameter ballDiameter = 0.05
    "Common bob sphere diameter";

  // ---- Derived tuning ----
  final parameter Real cycles[n] = {X + (n - i) for i in 1:n}
    "Number of oscillations pendulum i performs during T";
  final parameter Real k = if exactPeriod then
    HarmonicMotion.Utilities.pendulumPeriodFactor(phi0) else 1
    "Ratio of the exact period at phi0 to the small-angle period";
  final parameter Modelica.Units.SI.Length lengths[n] = {
    g_n*(T/(2*pi*k*cycles[i]))^2 for i in 1:n}
    "String length of pendulum i — from T_i = k·2π√(L_i/g)";
  final parameter Modelica.Units.SI.Position x[n] = {(i - 1)*dx for i in 1:n}
    "Lateral position of pendulum i along the world z-axis";
  final parameter MultiBody.Types.Color ballColors[n] =
    HarmonicMotion.Utilities.rainbowColors(n)
    "Per-pendulum RGB colour, hues evenly spread around the colour wheel";

  // ---- Components ----
  Pendulum pendulum[n](
    L                 = lengths,
    x                 = x,
    each m            = m,
    each phi          = phi0,
    each ballDiameter = ballDiameter,
    ballColor         = ballColors)
    "The row of tuned pendula"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

  inner MultiBody.World world(
    g              = g_n,
    animateWorld   = false,
    animateGravity = false)
    "Shared world / gravity field for all pendula"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));

  MultiBody.Visualizers.FixedShape rail(
    shapeType       = "box",
    lengthDirection = {0, 0, 1},
    widthDirection  = {1, 0, 0},
    length          = (n - 1)*dx + 4*dx,
    width           = 0.04,
    height          = 0.03,
    r_shape         = {0, 0, -2*dx},
    color           = {80, 80, 80})
    "Top mounting rail the pendula hang from"
    annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));

  MultiBody.Visualizers.FixedShape floor(
    shapeType       = "box",
    lengthDirection = {0, 0, 1},
    widthDirection  = {1, 0, 0},
    length          = (n - 1)*dx + 12*dx,
    width           = 1.2,
    height          = 0.02,
    r_shape         = {-0.6, -max(lengths) - 0.2, -6*dx},
    color           = {70, 140, 70})
    "Reference floor (visual only)"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));

equation
  connect(world.frame_b, rail.frame_a) annotation (Line(
      points = {{-90,-80},{-85,-80},{-85,-50},{-110,-50}}, color = {95,95,95}));
  connect(world.frame_b, floor.frame_a) annotation (Line(
      points = {{-90,-80},{-85,-80},{-85,-20},{-110,-20}}, color = {95,95,95}));

  annotation (
    Documentation(info="<html>
<h4>HarmonicMotion.Rotational.PendulumWave</h4>
<p>
  A row of <strong>n</strong> simple pendula whose lengths are tuned so that
  pendulum <em>i</em> completes exactly
  <code>N<sub>i</sub> = X + n &minus; i</code> full oscillations during the
  cycle time <strong>T</strong>. Released from the same initial angle, the
  bobs drift out of phase, trace a travelling wave, split into
  counter-rotating groups and re-synchronise after <strong>T</strong>&nbsp;s.
</p>

<h5>Key parameters</h5>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Symbol</th><th>Description</th><th>Default</th></tr>
  <tr><td><code>n</code></td><td>Number of pendula</td><td>15</td></tr>
  <tr><td><code>T</code></td><td>Pattern cycle time (s)</td><td>54</td></tr>
  <tr><td><code>X</code></td>
      <td>Oscillations of the slowest pendulum (pendulum n) in T</td>
      <td>30</td></tr>
  <tr><td><code>phi0</code></td><td>Common initial angle (rad)</td><td>0.5</td></tr>
  <tr><td><code>exactPeriod</code></td>
      <td>Correct the lengths for the nonlinear period</td><td>true</td></tr>
  <tr><td><code>dx</code></td><td>Lateral spacing (m)</td><td>0.05</td></tr>
  <tr><td><code>m</code></td><td>Common bob mass (kg)</td><td>1.0</td></tr>
</table>

<h5>Tuning law</h5>
<p>
  A pendulum is only isochronous in the small-angle limit; at amplitude
  <code>phi0</code> its true period is stretched by the factor
  <code>k&nbsp;=&nbsp;</code>
  <a href=\"modelica://HarmonicMotion.Utilities.pendulumPeriodFactor\">
  pendulumPeriodFactor(phi0)</a>. Since every pendulum is released from the
  same angle, the same <code>k</code> applies to all of them, and the exact
  tuning law becomes
</p>
<pre>
  T_i = k &middot; 2&pi;&radic;(L_i/g)   &rArr;   L<sub>i</sub> = g &middot; (T / (2&pi; k N<sub>i</sub>))&sup2;,   N<sub>i</sub> = X + n &minus; i
</pre>
<p>
  Pendulum&nbsp;1 is the shortest and fastest
  (<code>X + n &minus; 1</code> oscillations); pendulum&nbsp;<code>n</code>
  is the longest and slowest (<code>X</code> oscillations). The default
  values give lengths between roughly 0.36&nbsp;m and 0.78&nbsp;m.
</p>
<p>
  Setting <code>exactPeriod = false</code> falls back to the naive
  small-angle law <code>L<sub>i</sub> = g (T/(2&pi;N<sub>i</sub>))&sup2;</code>.
  At <code>phi0 = 0.5&nbsp;rad</code> that is 1.6&nbsp;% off, which
  accumulates to about half an oscillation over 30&ndash;44 cycles and
  visibly destroys the pattern &mdash; a good illustration of why the
  correction is needed.
</p>

<h5>Colours</h5>
<p>
  Bob and string colours come from
  <a href=\"modelica://HarmonicMotion.Utilities.rainbowColors\">
  Utilities.rainbowColors(n)</a>, the same function used by
  <a href=\"modelica://HarmonicMotion.Translational.MercuryWave\">
  Translational.MercuryWave</a>, so pendulum <em>i</em> and mercury
  channel <em>i</em> always share a colour.
</p>

<h5>How to run</h5>
<p>
  Simulate for <strong>54&nbsp;s</strong> and open the 3-D animation.
  Plot <code>pendulum[1].revolute.phi</code> next to
  <code>pendulum[15].revolute.phi</code> to see the frequency ladder.
</p>
</html>"),
    experiment(
      StopTime  = 54,
      Interval  = 9e-3,
      Tolerance = 1e-8),
    __Wolfram(Animation(
      cameras = {
        Camera(name = "Front", center = {0, -0.5, 0.35}, distance = 2.4,
          rotation = {0.7071, 0, 0, 0.7071}),
        Camera(name = "Perspective", center = {0, -0.5, 0.35}, distance = 2.8,
          rotation = {0.5, 0.5, 0.5, 0.5})},
      windows = {
        Window(name = "Default", camera = "Perspective", preferred = true,
          autoPlay = true, repeat = true, timeScale = 1)})),
    Diagram(coordinateSystem(preserveAspectRatio = false,
      extent = {{-120,-100},{120,100}})));
end PendulumWave;
