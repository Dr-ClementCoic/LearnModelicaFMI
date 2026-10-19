within HarmonicMotion.Tests.Rotational;
model StandalonePendulum
  "Single pendulum run in isolation — confirms self-contained simulation"
  extends HarmonicMotion.Rotational.Pendulum(
    L         = 0.5,
    m         = 1.0,
    phi       = 0.3,
    x         = 0.0,
    ballColor = {200, 50, 50});

  // World required by the MultiBody components; declared here for standalone use.
  inner Modelica.Mechanics.MultiBody.World world(
    g              = Modelica.Constants.g_n,
    animateWorld   = false,
    animateGravity = false)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

  annotation (
    Documentation(info="<html>
<h4>HarmonicMotion.Tests.Rotational.StandalonePendulum</h4>
<p>
  Extends <a href=\"modelica://HarmonicMotion.Rotational.Pendulum\">
  Rotational.Pendulum</a> with a specific set of parameters and adds the
  required <code>inner&nbsp;World</code>, making the model fully
  self-contained and simulatable without any enclosing context.
</p>
<p>
  <strong>Expected period:</strong>
  T&nbsp;=&nbsp;2&pi;&radic;(L/g)&nbsp;=&nbsp;2&pi;&radic;(0.5/9.80665)
  &asymp;&nbsp;1.42&nbsp;s (available as the final parameter
  <code>T_period</code>).
</p>
<p>
  <strong>What to look at:</strong> the 3-D animation shows the red bob
  swinging; plotting <code>revolute.phi</code> versus time gives a clean
  oscillation of amplitude 0.3&nbsp;rad.
</p>
<p>
  The translational counterpart is
  <a href=\"modelica://HarmonicMotion.Tests.Translational.StandaloneOscillator\">
  Tests.Translational.StandaloneOscillator</a>.
</p>
</html>"),
    experiment(
      StopTime  = 10,
      Interval  = 0.01,
      Tolerance = 1e-8));
end StandalonePendulum;
