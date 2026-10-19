within HarmonicMotion.Tests.Translational;
model EnergyConservation
  "Assert that mechanical energy is conserved throughout a spring-mass oscillation"
  extends HarmonicMotion.Translational.Oscillator(
    m            = 1.0,
    c            = 10,
    springLength = 0.5,
    amplitude    = 0.15,
    x            = 0.0,
    ballColor    = {50, 200, 50});

  inner Modelica.Mechanics.MultiBody.World world(
    gravityType    = Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity,
    animateWorld   = false,
    animateGravity = false)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

  // ---- Energy quantities ----
  Modelica.Units.SI.Energy E_kinetic =
    0.5*m*prismatic.v^2
    "Kinetic energy of the ball — ½ m v²";
  Modelica.Units.SI.Energy E_elastic =
    0.5*c*(prismatic.s - springLength)^2
    "Elastic energy stored in the spring — ½ c (s − s_unstretched)²";
  Modelica.Units.SI.Energy E_total =
    E_kinetic + E_elastic
    "Total mechanical energy (should be constant)";
  final parameter Modelica.Units.SI.Energy E_initial =
    0.5*c*amplitude^2
    "Initial mechanical energy = ½ c amplitude²";

equation
  // Continuous assertion: fires on any solver step where energy drifts.
  // Tighten the bound by reducing the solver Tolerance if needed.
  assert(
    abs(E_total - E_initial) < 1e-4,
    "Energy conservation violated: |Delta_E| = " +
    String(abs(E_total - E_initial)) + " J (tolerance 1e-4 J)");

  annotation (
    Documentation(info="<html>
<h4>HarmonicMotion.Tests.Translational.EnergyConservation</h4>
<p>
  Extends <a href=\"modelica://HarmonicMotion.Translational.Oscillator\">
  Translational.Oscillator</a>, adds a gravity-free
  <code>inner&nbsp;World</code> for standalone simulation, computes the total
  mechanical energy and asserts conservation at every solver step.
</p>
<p>
  Gravity is switched off and the prismatic joint is ideal, so the only
  mechanical energy is:
</p>
<pre>
  E_kinetic = &frac12; m v&sup2;
  E_elastic = &frac12; c (s &minus; springLength)&sup2;
  E_total   = E_kinetic + E_elastic  &equiv;  &frac12; c amplitude&sup2;
</pre>
<p>
  With the parameters used here
  E_initial&nbsp;=&nbsp;&frac12;&nbsp;&middot;&nbsp;10&nbsp;&middot;&nbsp;0.15&sup2;
  =&nbsp;0.1125&nbsp;J, so the 10<sup>&minus;4</sup>&nbsp;J bound corresponds
  to a relative drift below 10<sup>&minus;3</sup>. Reduce the solver
  <em>Tolerance</em> (currently 10<sup>&minus;10</sup>) for a tighter bound.
</p>
<p>
  <strong>Suggested plots:</strong> <code>E_total</code>,
  <code>E_kinetic</code>, <code>E_elastic</code> versus time &mdash;
  <code>E_total</code> should be a flat horizontal line.
</p>
<p>
  The rotational counterpart is
  <a href=\"modelica://HarmonicMotion.Tests.Rotational.EnergyConservation\">
  Tests.Rotational.EnergyConservation</a>.
</p>
</html>"),
    experiment(
      StopTime  = 30,
      Interval  = 0.01,
      Tolerance = 1e-10));
end EnergyConservation;
