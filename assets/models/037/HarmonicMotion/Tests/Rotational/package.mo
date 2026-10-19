within HarmonicMotion.Tests;
package Rotational "Verification models for the rotational (pendulum) domain"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
<h4>HarmonicMotion.Tests.Rotational</h4>
<p>
  Self-contained checks of
  <a href=\"modelica://HarmonicMotion.Rotational.Pendulum\">
  Rotational.Pendulum</a>. Each model declares its own
  <code>inner&nbsp;World</code> with gravity set to
  <code>Modelica.Constants.g_n</code>, so the analytical formulas used in the
  asserts match the simulated model exactly.
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Model</th><th>Purpose</th></tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Tests.Rotational.StandalonePendulum\">
        StandalonePendulum</a></td>
    <td>Single pendulum with non-default parameters; confirms that
        <code>Pendulum</code> simulates correctly in isolation.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Tests.Rotational.EnergyConservation\">
        EnergyConservation</a></td>
    <td>Asserts that total mechanical energy is conserved at every solver
        step over a 30&nbsp;s simulation.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Tests.Rotational.PendulumPeriod\">
        PendulumPeriod</a></td>
    <td>Verifies that the integrated period matches the small-angle formula
        T&nbsp;=&nbsp;2&pi;&radic;(L/g) to within 1&nbsp;mrad of returned
        angle after one cycle.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Tests.Rotational.PendulumPeriodLargeAngle\">
        PendulumPeriodLargeAngle</a></td>
    <td>Verifies the finite-amplitude period correction
        <a href=\"modelica://HarmonicMotion.Utilities.pendulumPeriodFactor\">
        pendulumPeriodFactor</a> at &phi;<sub>0</sub>&nbsp;=&nbsp;0.5&nbsp;rad,
        the amplitude used by <code>PendulumWave</code>.</td>
  </tr>
</table>
<p>
  The translational counterparts live in
  <a href=\"modelica://HarmonicMotion.Tests.Translational\">
  Tests.Translational</a>.
</p>
</html>"));
end Rotational;
