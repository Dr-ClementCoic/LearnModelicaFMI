within HarmonicMotion.Tests.Translational;
model StandaloneOscillator
  "Single spring-mass channel run in isolation — confirms self-contained simulation"
  extends HarmonicMotion.Translational.Oscillator(
    m            = 0.5,
    c            = 10,
    springLength = 0.5,
    amplitude    = 0.15,
    x            = 0.0,
    ballColor    = {200, 50, 50});

  // World required by the MultiBody components; declared here for standalone use.
  // Gravity is off, matching the staging used by MercuryWave.
  inner Modelica.Mechanics.MultiBody.World world(
    gravityType    = Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity,
    animateWorld   = false,
    animateGravity = false)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

  annotation (
    Documentation(info="<html>
<h4>HarmonicMotion.Tests.Translational.StandaloneOscillator</h4>
<p>
  Extends <a href=\"modelica://HarmonicMotion.Translational.Oscillator\">
  Translational.Oscillator</a> with a specific set of parameters and adds the
  required <code>inner&nbsp;World</code>, making the model fully
  self-contained and simulatable without any enclosing context.
</p>
<p>
  <strong>Expected period:</strong>
  T&nbsp;=&nbsp;2&pi;&radic;(m/c)&nbsp;=&nbsp;2&pi;&radic;(0.5/10)
  &asymp;&nbsp;1.40&nbsp;s (available as the final parameter
  <code>T_period</code>).
</p>
<p>
  <strong>What to look at:</strong> the 3-D animation shows the red ball
  bouncing on its coil spring; plotting <code>prismatic.s</code> versus time
  gives a clean oscillation between
  <code>springLength &minus; amplitude</code> and
  <code>springLength + amplitude</code>.
</p>
<p>
  The rotational counterpart is
  <a href=\"modelica://HarmonicMotion.Tests.Rotational.StandalonePendulum\">
  Tests.Rotational.StandalonePendulum</a>.
</p>
</html>"),
    experiment(
      StopTime  = 10,
      Interval  = 0.01,
      Tolerance = 1e-8));
end StandaloneOscillator;
