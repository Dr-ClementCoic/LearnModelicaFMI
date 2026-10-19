within HarmonicMotion.Tests.Rotational;
model PendulumPeriod
  "Verify that the simulated period matches the small-angle analytical formula"
  import Modelica.Constants.pi;
  import Modelica.Constants.g_n;

  // L = g/(2π)² ⟹ T_period = 2π√(L/g) = 1.0 s exactly.
  extends HarmonicMotion.Rotational.Pendulum(
    L         = g_n/(2*pi)^2,
    m         = 1.0,
    phi       = 0.05,
    x         = 0.0,
    ballColor = {50, 50, 200});

  inner Modelica.Mechanics.MultiBody.World world(
    g              = g_n,
    animateWorld   = false,
    animateGravity = false)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

  // T_period is a final parameter inherited from Pendulum; ≈ 1.0 s here.

equation
  // The 'when' clause generates a time event forcing the solver to step to
  // exactly t = T_period.  At that instant the pendulum should have returned
  // to its initial angle (for small phi the nonlinear correction is < 1e-7 rad).
  when time > T_period then
    assert(
      abs(revolute.phi - phi) < 1e-3,
      "Period test failed: angle after one period = " +
      String(revolute.phi) + " rad, expected " +
      String(phi) + " rad (tolerance 1e-3 rad)");
  end when;

  annotation (
    Documentation(info="<html>
<h4>HarmonicMotion.Tests.Rotational.PendulumPeriod</h4>
<p>
  Sets the string length to
  L&nbsp;=&nbsp;g/(2&pi;)&sup2;&nbsp;&asymp;&nbsp;0.2485&nbsp;m so that the
  small-angle period is exactly <strong>1.0&nbsp;s</strong>. The initial
  angle &phi;&nbsp;=&nbsp;0.05&nbsp;rad (&asymp;&nbsp;2.9&deg;) keeps the
  motion well inside the linear regime
  (&Delta;T/T&nbsp;&asymp;&nbsp;&phi;&sup2;/16&nbsp;&asymp;&nbsp;1.6&times;10<sup>&minus;4</sup>).
</p>
<p>
  A Modelica <code>when time &gt; T_period</code> equation generates a time
  event at t&nbsp;=&nbsp;T_period, forcing the solver to step to that instant
  precisely. The assert then checks that
  |&phi;(T<sub>period</sub>)&nbsp;&minus;&nbsp;&phi;<sub>0</sub>|&nbsp;&lt;&nbsp;1&nbsp;mrad.
</p>
<p>
  This test validates the tuning law used by
  <a href=\"modelica://HarmonicMotion.Rotational.PendulumWave\">
  Rotational.PendulumWave</a>: if <code>T_period</code> is right, then
  choosing L<sub>i</sub>&nbsp;=&nbsp;g&nbsp;(T/(2&pi;N<sub>i</sub>))&sup2;
  really does give N<sub>i</sub> oscillations per cycle.
</p>
<p>
  <strong>Suggested plot:</strong> <code>revolute.phi</code> versus time
  &mdash; a clean sinusoid of amplitude 0.05&nbsp;rad and period 1.0&nbsp;s.
</p>
<p>
  The translational counterpart is
  <a href=\"modelica://HarmonicMotion.Tests.Translational.OscillatorPeriod\">
  Tests.Translational.OscillatorPeriod</a>.
</p>
</html>"),
    experiment(
      StopTime  = 5,
      Interval  = 1e-3,
      Tolerance = 1e-10));
end PendulumPeriod;
