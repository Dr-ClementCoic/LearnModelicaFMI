within HarmonicMotion.Translational;
model MercuryWaveAligned
  "Mercury wave, video-style: every ball starts on the same horizontal line"
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
  parameter Modelica.Units.SI.Length springFreeLength = 0.15
    "Unstretched spring length — identical on every channel";
  parameter Modelica.Units.SI.Length restDepth = 1.30
    "Depth of the common rest line below the ceiling";
  parameter Modelica.Units.SI.Acceleration g = Modelica.Constants.g_n
    "Gravity magnitude (kept in sync with the world below)";
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
  final parameter Modelica.Units.SI.Length rodLengths[n] = {
    restDepth - springFreeLength - masses[i]*g/c for i in 1:n}
    "Rod length of channel i — cancels the static sag m·g/c exactly";
  final parameter MultiBody.Types.Color ballColors[n] =
    HarmonicMotion.Utilities.rainbowColors(n)
    "Per-channel RGB colour, hues evenly spread around the colour wheel";

  // ---- Components ----
  SuspendedOscillator oscillator[n](
    m                    = masses,
    rodLength            = rodLengths,
    x                    = x,
    each c               = c,
    each springFreeLength = springFreeLength,
    each amplitude       = amplitude,
    each g               = g,
    each ballDiameter    = ballDiameter,
    ballColor            = ballColors)
    "The row of tuned, sag-compensated spring-mass channels"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

  inner MultiBody.World world(
    g              = g,
    animateWorld   = false,
    animateGravity = false)
    "Shared world — gravity is active and cancelled by the rod lengths"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));

  MultiBody.Visualizers.FixedShape ceilingRail(
    shapeType       = "box",
    lengthDirection = {1, 0, 0},
    widthDirection  = {0, 0, 1},
    length          = (n - 1)*dx + 0.2,
    width           = 0.08,
    height          = 0.05,
    r_shape         = {-0.1, 0, -0.04},
    color           = {60, 60, 60})
    "Shared ceiling the rods hang from"
    annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));

  MultiBody.Visualizers.FixedShape floor(
    shapeType       = "box",
    lengthDirection = {1, 0, 0},
    widthDirection  = {0, 0, 1},
    length          = (n - 1)*dx + 0.6,
    width           = 1.0,
    height          = 0.02,
    r_shape         = {-0.3, -restDepth - amplitude - 0.15, -0.5},
    color           = {70, 140, 70})
    "Reference floor (visual only)"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));

equation
  connect(world.frame_b, ceilingRail.frame_a) annotation (Line(
      points = {{-90,-80},{-85,-80},{-85,-50},{-110,-50}}, color = {95,95,95}));
  connect(world.frame_b, floor.frame_a) annotation (Line(
      points = {{-90,-80},{-85,-80},{-85,-20},{-110,-20}}, color = {95,95,95}));

  annotation (
    Documentation(info="<html>
<h4>HarmonicMotion.Translational.MercuryWaveAligned</h4>
<p>
  The same <em>n</em>-channel mercury wave as
  <a href=\"modelica://HarmonicMotion.Translational.MercuryWave\">
  MercuryWave</a>, but staged like the classic video: every ball is released
  from the <strong>same horizontal line</strong>.
</p>

<h5>How the alignment works</h5>
<p>
  Stiffness <code>c</code> and spring free length
  <code>springFreeLength</code> are identical on every channel, so the entire
  geometric difference is carried by <strong>rigid rods</strong> hung from one
  shared ceiling. Under gravity each ball sags <code>m&nbsp;g/c</code> on its
  spring, so choosing
</p>
<pre>
  rodLength<sub>i</sub> = restDepth &minus; springFreeLength &minus; m<sub>i</sub> g / c
</pre>
<p>
  places every rest position at the same depth <code>restDepth</code> below
  the ceiling. Heavier (slower) channels get shorter rods.
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
  <tr><td><code>springFreeLength</code></td>
      <td>Identical unstretched spring length (m)</td><td>0.15</td></tr>
  <tr><td><code>restDepth</code></td>
      <td>Common rest line below the ceiling (m)</td><td>1.30</td></tr>
  <tr><td><code>g</code></td>
      <td>Gravity magnitude, shared with the world (m/s²)</td>
      <td><code>Modelica.Constants.g_n</code></td></tr>
</table>
<p>
  <code>restDepth</code> must be large enough that every rod length stays
  positive, i.e.
  <code>restDepth &gt; springFreeLength + max(masses)&nbsp;g/c</code>.
</p>

<h5>Tuning law</h5>
<p>
  Unchanged from <code>MercuryWave</code>:
  <code>m<sub>i</sub> = c (T / (2&pi; N<sub>i</sub>))&sup2;</code> with
  <code>N<sub>i</sub> = X + n &minus; i</code>, so the aligned row produces
  exactly the same wave.
</p>

<h5>How to run</h5>
<p>
  Simulate for <strong>60&nbsp;s</strong>, open the <strong>Animation</strong>
  view and press play. Plot <code>oscillator[i].ball.frame_a.r_0[2]</code>
  to confirm that all balls start at the same height.
</p>
</html>"),
    experiment(
      StopTime  = 60,
      Interval  = 0.02,
      Tolerance = 1e-8,
      __Wolfram_SynchronizeWithRealTime = false),
    __Wolfram(Animation(
      cameras = {
        Camera(name = "Front", center = {1.260, -0.70, 0}, distance = 4.32,
          rotation = {0.7071, 0, 0, 0.7071}),
        Camera(name = "Perspective", center = {1.260, -0.70, 0}, distance = 4.72,
          rotation = {0.5, 0.5, 0.5, 0.5})},
      windows = {
        Window(name = "Default", camera = "Perspective", preferred = true,
          autoPlay = true, repeat = true, timeScale = 1)})),
    Diagram(coordinateSystem(preserveAspectRatio = false,
      extent = {{-120,-100},{120,100}})));
end MercuryWaveAligned;
