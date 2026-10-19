within HarmonicMotion.Translational;
model MercuryWave
  "The mercury wave: n spring-mass channels whose masses form an even frequency ladder"
  import Modelica.Mechanics.MultiBody;
  import Modelica.Constants.pi;

  // ---- Wave tuning (identical parameter set as Rotational.PendulumWave) ----
  parameter Integer n = 15
    "Number of oscillators";
  parameter Modelica.Units.SI.Time T = 60
    "Pattern cycle time — after T s the whole row is back in phase";
  parameter Real X = 30
    "Number of oscillations performed by the slowest channel (channel n) in T";
  parameter Modelica.Units.SI.Length amplitude = 0.15
    "Common initial upward displacement of every ball (m)";

  // ---- Common physical / geometric properties ----
  parameter Modelica.Units.SI.TranslationalSpringConstant c = 10
    "Common spring stiffness";
  parameter Modelica.Units.SI.Distance dx = 0.18
    "Lateral spacing between neighbouring channels";
  parameter Modelica.Units.SI.Length springLength0 = 0.40
    "Unstretched spring length of the first channel";
  parameter Modelica.Units.SI.Length dSpring = 0.02
    "Increment of the unstretched spring length per channel (staggers rest heights)";
  parameter Modelica.Units.SI.Diameter ballDiameter = 0.09
    "Common ball sphere diameter";

  // ---- Derived tuning ----
  final parameter Real cycles[n] = {X + (n - i) for i in 1:n}
    "Number of oscillations channel i performs during T";
  final parameter Modelica.Units.SI.Mass masses[n] = {
    c*(T/(2*pi*cycles[i]))^2 for i in 1:n}
    "Mass of channel i — from T_i = 2π√(m_i/c)";
  final parameter Modelica.Units.SI.Position x[n] = {(i - 1)*dx for i in 1:n}
    "Lateral position of channel i along the world x-axis";
  final parameter Modelica.Units.SI.Length springLengths[n] = {
    springLength0 + (i - 1)*dSpring for i in 1:n}
    "Unstretched spring length of channel i (visual staggering only)";
  final parameter MultiBody.Types.Color ballColors[n] =
    HarmonicMotion.Utilities.rainbowColors(n)
    "Per-channel RGB colour, hues evenly spread around the colour wheel";

  // ---- Components ----
  Oscillator oscillator[n](
    m                 = masses,
    springLength      = springLengths,
    x                 = x,
    each c            = c,
    each amplitude    = amplitude,
    each ballDiameter = ballDiameter,
    ballColor         = ballColors)
    "The row of tuned spring-mass channels"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

  inner MultiBody.World world(
    gravityType    = MultiBody.Types.GravityTypes.NoGravity,
    animateWorld   = false,
    animateGravity = false)
    "Shared world — gravity is switched off in this staging"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));

  MultiBody.Visualizers.FixedShape rail(
    shapeType       = "box",
    lengthDirection = {1, 0, 0},
    widthDirection  = {0, 0, 1},
    length          = (n - 1)*dx + 0.2,
    width           = 0.05,
    height          = 0.04,
    r_shape         = {-0.1, 0, -0.025},
    color           = {80, 80, 80})
    "Top mounting rail the springs hang from"
    annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));

  MultiBody.Visualizers.FixedShape floor(
    shapeType       = "box",
    lengthDirection = {1, 0, 0},
    widthDirection  = {0, 0, 1},
    length          = (n - 1)*dx + 0.6,
    width           = 1.0,
    height          = 0.02,
    r_shape         = {-0.3, -max(springLengths) - amplitude - 0.2, -0.5},
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
<h4>HarmonicMotion.Translational.MercuryWave</h4>
<p>
  A row of <strong>n</strong> vertical spring&ndash;mass oscillators that all
  share one stiffness <code>c</code> but whose masses are tuned so that
  channel <em>i</em> completes exactly
  <code>N<sub>i</sub> = X + n &minus; i</code> oscillations during the cycle
  time <strong>T</strong>. Released together, the balls drift out of phase,
  form a travelling wave, briefly split into counter-rotating patterns and
  re-synchronise after <strong>T</strong>&nbsp;s.
</p>

<h5>Key parameters</h5>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Symbol</th><th>Description</th><th>Default</th></tr>
  <tr><td><code>n</code></td><td>Number of channels</td><td>15</td></tr>
  <tr><td><code>T</code></td><td>Pattern cycle time (s)</td><td>60</td></tr>
  <tr><td><code>X</code></td>
      <td>Oscillations of the slowest channel (channel n) in T</td><td>30</td></tr>
  <tr><td><code>amplitude</code></td>
      <td>Common initial displacement (m)</td><td>0.15</td></tr>
  <tr><td><code>c</code></td><td>Common spring stiffness (N/m)</td><td>10</td></tr>
  <tr><td><code>dx</code></td><td>Lateral spacing (m)</td><td>0.18</td></tr>
</table>

<h5>Tuning law</h5>
<p>
  From the natural period <code>T_i = 2&pi;&radic;(m_i/c)</code>:
</p>
<pre>
  m<sub>i</sub> = c &middot; (T / (2&pi; N<sub>i</sub>))&sup2;,   N<sub>i</sub> = X + n &minus; i
</pre>
<p>
  Channel&nbsp;1 carries the smallest mass and is the fastest
  (<code>X + n &minus; 1</code> oscillations); channel&nbsp;<code>n</code>
  carries the largest mass and is the slowest (<code>X</code> oscillations).
  With the defaults the masses run from about 0.47&nbsp;kg to 1.01&nbsp;kg.
</p>
<p>
  This is the exact translational analogue of
  <a href=\"modelica://HarmonicMotion.Rotational.PendulumWave\">
  Rotational.PendulumWave</a>, where the same ladder is created by string
  length instead of mass.
</p>

<h5>Staging</h5>
<p>
  Gravity is switched <strong>off</strong>, so each ball rests exactly at its
  own unstretched spring length. The spring lengths increase by
  <code>dSpring</code> along the row, which staggers the rest heights and
  makes the individual springs easy to see. For the video-style staging in
  which all balls start on one line, use
  <a href=\"modelica://HarmonicMotion.Translational.MercuryWaveAligned\">
  MercuryWaveAligned</a>.
</p>

<h5>Colours</h5>
<p>
  Ball colours come from
  <a href=\"modelica://HarmonicMotion.Utilities.rainbowColors\">
  Utilities.rainbowColors(n)</a> &mdash; the same function used by the
  rotational wave, so channel <em>i</em> and pendulum <em>i</em> always share
  a colour.
</p>

<h5>How to run</h5>
<p>
  Simulate for <strong>60&nbsp;s</strong>, open the <strong>Animation</strong>
  view and press play. Plot <code>oscillator[1].prismatic.s</code> against
  <code>oscillator[15].prismatic.s</code> to see the frequency ladder.
</p>
</html>"),
    experiment(
      StopTime  = 60,
      Interval  = 0.02,
      Tolerance = 1e-8,
      __Wolfram_SynchronizeWithRealTime = false),
    __Wolfram(Animation(
      cameras = {
        Camera(name = "Front", center = {1.260, -0.45, 0}, distance = 3.72,
          rotation = {0.7071, 0, 0, 0.7071}),
        Camera(name = "Perspective", center = {1.260, -0.45, 0}, distance = 4.12,
          rotation = {0.5, 0.5, 0.5, 0.5})},
      windows = {
        Window(name = "Default", camera = "Perspective", preferred = true,
          autoPlay = true, repeat = true, timeScale = 1)})),
    Diagram(coordinateSystem(preserveAspectRatio = false,
      extent = {{-120,-100},{120,100}})));
end MercuryWave;
