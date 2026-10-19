within HarmonicMotion.Tests.Translational;
model AlignedOscillator
  "Verify that the rigid rod cancels the static sag and centres the motion on the common rest line"
  import Modelica.Constants.g_n;

  // Heaviest channel of the default MercuryWaveAligned setup (largest sag),
  // with the rod length computed from the very same alignment formula.
  extends HarmonicMotion.Translational.SuspendedOscillator(
    m                = 1.01321,
    c                = 10,
    g                = g_n,
    springFreeLength = 0.15,
    rodLength        = restDepthTarget - springFreeLength - m*g/c,
    amplitude        = 0.15,
    x                = 0.0,
    ballColor        = {200, 120, 50});

  parameter Modelica.Units.SI.Length restDepthTarget = 1.30
    "Common rest line the alignment formula is solved for";

  inner Modelica.Mechanics.MultiBody.World world(
    g              = g_n,
    animateWorld   = false,
    animateGravity = false)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

  Modelica.Units.SI.Length ballDepth = -ball.frame_a.r_0[2]
    "Depth of the ball below the ceiling (measured in world coordinates)";

initial equation
  // The rod length must place the rest line exactly where it was asked to be.
  assert(
    abs(restDepth - restDepthTarget) < 1e-9,
    "Alignment formula failed: restDepth = " + String(restDepth) +
    " m, expected " + String(restDepthTarget) + " m");

equation
  // Continuous assertion: gravity and spring preload must cancel exactly, so
  // the ball never leaves the symmetric band restDepth ± amplitude.
  assert(
    abs(ballDepth - restDepth) < amplitude + 1e-4,
    "Motion is not centred on the rest line: ballDepth − restDepth = " +
    String(ballDepth - restDepth) + " m (allowed ±" + String(amplitude) + " m)");

  // Half a period after release the ball must be exactly 'amplitude' below
  // the rest line — the mirror image of its starting point.
  when time > T_period/2 then
    assert(
      abs(ballDepth - (restDepth + amplitude)) < 1e-3,
      "Half-period test failed: ball depth = " + String(ballDepth) +
      " m, expected " + String(restDepth + amplitude) +
      " m (tolerance 1e-3 m)");
  end when;

  annotation (
    Documentation(info="<html>
<h4>HarmonicMotion.Tests.Translational.AlignedOscillator</h4>
<p>
  Verifies the sag-cancellation trick that
  <a href=\"modelica://HarmonicMotion.Translational.MercuryWaveAligned\">
  MercuryWaveAligned</a> relies on. The model extends
  <a href=\"modelica://HarmonicMotion.Translational.SuspendedOscillator\">
  SuspendedOscillator</a> with the heaviest channel of the default wave
  (largest static sag) and computes its rod length from exactly the same
  formula used by the wave model:
</p>
<pre>
  rodLength = restDepthTarget &minus; springFreeLength &minus; m g / c
</pre>

<h5>Checks performed</h5>
<ol>
  <li><strong>Initial equation:</strong> the resulting
      <code>restDepth</code> equals <code>restDepthTarget</code> to within
      10<sup>&minus;9</sup>&nbsp;m — i.e. the ball really does rest on the
      common line, independently of its mass.</li>
  <li><strong>Continuous assert:</strong> the ball, measured in world
      coordinates through <code>ball.frame_a.r_0[2]</code>, never leaves the
      band <code>restDepth&nbsp;&plusmn;&nbsp;amplitude</code>. Any leftover
      gravitational bias would immediately break this bound.</li>
  <li><strong>Half-period assert:</strong> at
      t&nbsp;=&nbsp;T_period/2 the ball is exactly <code>amplitude</code>
      <em>below</em> the rest line, the mirror image of its release point.</li>
</ol>
<p>
  <strong>Suggested plot:</strong> <code>ballDepth</code> versus time — a
  sinusoid centred on 1.30&nbsp;m with amplitude 0.15&nbsp;m.
</p>
<p>
  This test has no rotational counterpart: the pendulum has no static
  equilibrium offset to compensate.
</p>
</html>"),
    experiment(
      StopTime  = 10,
      Interval  = 1e-3,
      Tolerance = 1e-10));
end AlignedOscillator;
