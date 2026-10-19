within HarmonicMotion.Tests.Rotational;
model EnergyConservation
  "Assert that mechanical energy is conserved throughout a pendulum swing"
  extends HarmonicMotion.Rotational.Pendulum(
    L         = 1.0,
    m         = 1.0,
    phi       = 0.3,
    x         = 0.0,
    ballColor = {50, 200, 50});

  inner Modelica.Mechanics.MultiBody.World world(
    g              = Modelica.Constants.g_n,
    animateWorld   = false,
    animateGravity = false)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

  // ---- Energy quantities ----
  Modelica.Units.SI.Energy E_kinetic =
    0.5*m*(L*revolute.w)^2
    "Kinetic energy of the bob — ½ m (L ω)²";
  Modelica.Units.SI.Energy E_potential =
    m*Modelica.Constants.g_n*L*(1 - cos(revolute.phi))
    "Gravitational potential energy relative to the lowest point";
  Modelica.Units.SI.Energy E_total =
    E_kinetic + E_potential
    "Total mechanical energy (should be constant)";
  final parameter Modelica.Units.SI.Energy E_initial =
    m*Modelica.Constants.g_n*L*(1 - cos(phi))
    "Initial mechanical energy = m g L (1 − cos φ₀)";

equation
  // Continuous assertion: fires on any solver step where energy drifts.
  // Tighten the bound by reducing the solver Tolerance if needed.
  assert(
    abs(E_total - E_initial) < 1e-4,
    "Energy conservation violated: |Delta_E| = " +
    String(abs(E_total - E_initial)) + " J (tolerance 1e-4 J)");

  annotation (
    Documentation(info="<html>
<h4>HarmonicMotion.Tests.Rotational.EnergyConservation</h4>
<p>
  Extends <a href=\"modelica://HarmonicMotion.Rotational.Pendulum\">
  Rotational.Pendulum</a>, adds an <code>inner&nbsp;World</code> for
  standalone simulation, computes the total mechanical energy and asserts
  conservation at every solver step.
</p>
<p>
  Because the string is massless (<code>density&nbsp;=&nbsp;0</code>) and the
  revolute joint is ideal, the only mechanical energy is:
</p>
<pre>
  E_kinetic   = &frac12; m (L &omega;)&sup2;
  E_potential = m g L (1 &minus; cos &phi;)
  E_total     = E_kinetic + E_potential  &equiv;  m g L (1 &minus; cos &phi;&sub0;)
</pre>
<p>
  The assert fires if |E_total&nbsp;&minus;&nbsp;E_initial| exceeds
  10<sup>&minus;4</sup>&nbsp;J. Reduce the solver <em>Tolerance</em>
  (currently 10<sup>&minus;10</sup>) for a tighter bound.
</p>
<p>
  <strong>Suggested plots:</strong> <code>E_total</code>,
  <code>E_kinetic</code>, <code>E_potential</code> versus time &mdash;
  <code>E_total</code> should be a flat horizontal line.
</p>
<p>
  The translational counterpart is
  <a href=\"modelica://HarmonicMotion.Tests.Translational.EnergyConservation\">
  Tests.Translational.EnergyConservation</a>.
</p>
</html>"),
    experiment(
      StopTime  = 30,
      Interval  = 0.01,
      Tolerance = 1e-10));
end EnergyConservation;
