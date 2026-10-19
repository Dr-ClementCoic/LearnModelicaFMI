within HarmonicMotion.Tests.Rotational;
model PendulumPeriodLargeAngle
  "Verify the finite-amplitude period correction used by PendulumWave"
  import Modelica.Constants.pi;
  import Modelica.Constants.g_n;

  // L = g/(2π)² ⟹ small-angle period = 1.0 s exactly, so the exact period
  // at this amplitude is numerically equal to the correction factor itself.
  extends HarmonicMotion.Rotational.Pendulum(
    L         = g_n/(2*pi)^2,
    m         = 1.0,
    phi       = 0.5,
    x         = 0.0,
    ballColor = {200, 50, 200});

  inner Modelica.Mechanics.MultiBody.World world(
    g              = g_n,
    animateWorld   = false,
    animateGravity = false)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

  final parameter Real k = HarmonicMotion.Utilities.pendulumPeriodFactor(phi)
    "Exact-to-small-angle period ratio at the initial amplitude";
  final parameter Modelica.Units.SI.Time T_exact = k*T_period
    "Exact (finite-amplitude) period";

equation
  // Naive small-angle prediction: clearly wrong at this amplitude.
  when time > T_period then
    assert(
      abs(revolute.phi - phi) > 1e-2,
      "Sanity check failed: the small-angle formula was expected to be " +
      "noticeably wrong at phi0 = 0.5 rad, but the angle after T_period " +
      "already matched the initial angle");
  end when;

  // Corrected prediction: the pendulum must be back at its release angle.
  when time > T_exact then
    assert(
      abs(revolute.phi - phi) < 1e-3,
      "Exact-period test failed: angle after T_exact = " +
      String(revolute.phi) + " rad, expected " + String(phi) +
      " rad (tolerance 1e-3 rad)");
  end when;

  annotation (
    Documentation(info="<html>
<h4>HarmonicMotion.Tests.Rotational.PendulumPeriodLargeAngle</h4>
<p>
  Complements
  <a href=\"modelica://HarmonicMotion.Tests.Rotational.PendulumPeriod\">
  PendulumPeriod</a> (which works in the linear regime) by validating
  <a href=\"modelica://HarmonicMotion.Utilities.pendulumPeriodFactor\">
  Utilities.pendulumPeriodFactor</a> at the amplitude actually used by
  <a href=\"modelica://HarmonicMotion.Rotational.PendulumWave\">
  Rotational.PendulumWave</a>, &phi;<sub>0</sub>&nbsp;=&nbsp;0.5&nbsp;rad.
</p>
<p>
  The string length is again L&nbsp;=&nbsp;g/(2&pi;)&sup2;, so the small-angle
  period <code>T_period</code> is exactly 1.0&nbsp;s and the exact period is
  numerically equal to the correction factor,
  k&nbsp;&asymp;&nbsp;1.015852&nbsp;s.
</p>

<h5>Checks performed</h5>
<ol>
  <li><strong>Negative control</strong> at t&nbsp;=&nbsp;<code>T_period</code>:
      the angle must <em>not</em> yet have returned to
      &phi;<sub>0</sub> (deviation &gt; 10&nbsp;mrad). This proves that the
      correction is genuinely needed.</li>
  <li><strong>Positive check</strong> at t&nbsp;=&nbsp;<code>T_exact</code>:
      the angle <em>has</em> returned to &phi;<sub>0</sub> within
      1&nbsp;mrad, i.e. the AGM formula gives the true period.</li>
</ol>
<p>
  <strong>Suggested plot:</strong> <code>revolute.phi</code> versus time,
  with vertical markers at 1.0&nbsp;s and 1.0159&nbsp;s.
</p>
<p>
  There is no translational counterpart: a linear spring&ndash;mass
  oscillator is exactly isochronous, which is why
  <a href=\"modelica://HarmonicMotion.Translational.MercuryWave\">
  MercuryWave</a> needs no correction at all.
</p>
</html>"),
    experiment(
      StopTime  = 5,
      Interval  = 1e-3,
      Tolerance = 1e-10));
end PendulumPeriodLargeAngle;
