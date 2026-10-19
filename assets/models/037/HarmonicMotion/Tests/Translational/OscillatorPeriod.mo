within HarmonicMotion.Tests.Translational;
model OscillatorPeriod
  "Verify that the simulated period matches the analytical formula 2π√(m/c)"
  import Modelica.Constants.pi;

  // m = c/(2π)² ⟹ T_period = 2π√(m/c) = 1.0 s exactly.
  extends HarmonicMotion.Translational.Oscillator(
    c            = 10,
    m            = 10/(2*pi)^2,
    springLength = 0.5,
    amplitude    = 0.05,
    x            = 0.0,
    ballColor    = {50, 50, 200});

  inner Modelica.Mechanics.MultiBody.World world(
    gravityType    = Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity,
    animateWorld   = false,
    animateGravity = false)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

  // T_period is a final parameter inherited from Oscillator; = 1.0 s here.
  final parameter Modelica.Units.SI.Length s_initial = springLength - amplitude
    "Initial spring extension the ball must return to after one period";

equation
  // The 'when' clause generates a time event forcing the solver to step to
  // exactly t = T_period.  A linear oscillator is exactly periodic, so the
  // test measures solver accuracy only.
  when time > T_period then
    assert(
      abs(prismatic.s - s_initial) < 1e-3,
      "Period test failed: spring extension after one period = " +
      String(prismatic.s) + " m, expected " +
      String(s_initial) + " m (tolerance 1e-3 m)");
  end when;

  annotation (
    Documentation(info="<html>
<h4>HarmonicMotion.Tests.Translational.OscillatorPeriod</h4>
<p>
  Sets the mass to m&nbsp;=&nbsp;c/(2&pi;)&sup2;&nbsp;&asymp;&nbsp;0.2533&nbsp;kg
  so that the natural period is exactly <strong>1.0&nbsp;s</strong>.
</p>
<p>
  A Modelica <code>when time &gt; T_period</code> equation generates a time
  event at t&nbsp;=&nbsp;T_period, forcing the solver to step to that instant
  precisely. The assert then checks that the ball has returned to its release
  position, |s(T<sub>period</sub>)&nbsp;&minus;&nbsp;s<sub>0</sub>|&nbsp;&lt;&nbsp;1&nbsp;mm.
</p>
<p>
  Unlike the pendulum, the spring&ndash;mass oscillator is exactly linear, so
  there is no amplitude-dependent period error at all &mdash; the test purely
  validates the solver and the tuning law used by
  <a href=\"modelica://HarmonicMotion.Translational.MercuryWave\">
  Translational.MercuryWave</a>:
  m<sub>i</sub>&nbsp;=&nbsp;c&nbsp;(T/(2&pi;N<sub>i</sub>))&sup2; really does
  give N<sub>i</sub> oscillations per cycle.
</p>
<p>
  <strong>Suggested plot:</strong> <code>prismatic.s</code> versus time
  &mdash; a clean sinusoid of amplitude 0.05&nbsp;m and period 1.0&nbsp;s
  about <code>springLength</code>.
</p>
<p>
  The rotational counterpart is
  <a href=\"modelica://HarmonicMotion.Tests.Rotational.PendulumPeriod\">
  Tests.Rotational.PendulumPeriod</a>.
</p>
</html>"),
    experiment(
      StopTime  = 5,
      Interval  = 1e-3,
      Tolerance = 1e-10));
end OscillatorPeriod;
