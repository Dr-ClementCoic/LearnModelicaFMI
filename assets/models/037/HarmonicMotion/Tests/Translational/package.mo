within HarmonicMotion.Tests;
package Translational "Verification models for the translational (mercury) domain"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
<h4>HarmonicMotion.Tests.Translational</h4>
<p>
  Self-contained checks of
  <a href=\"modelica://HarmonicMotion.Translational.Oscillator\">
  Translational.Oscillator</a> and
  <a href=\"modelica://HarmonicMotion.Translational.SuspendedOscillator\">
  Translational.SuspendedOscillator</a>. Each model declares its own
  <code>inner&nbsp;World</code>.
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Model</th><th>Purpose</th></tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Tests.Translational.StandaloneOscillator\">
        StandaloneOscillator</a></td>
    <td>Single spring&ndash;mass channel with non-default parameters;
        confirms that <code>Oscillator</code> simulates correctly in
        isolation.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Tests.Translational.EnergyConservation\">
        EnergyConservation</a></td>
    <td>Asserts that kinetic + elastic energy is conserved at every solver
        step over a 30&nbsp;s simulation.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Tests.Translational.OscillatorPeriod\">
        OscillatorPeriod</a></td>
    <td>Verifies that the integrated period matches
        T&nbsp;=&nbsp;2&pi;&radic;(m/c) to within 1&nbsp;mm of returned
        displacement after one cycle.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Tests.Translational.AlignedOscillator\">
        AlignedOscillator</a></td>
    <td>Verifies the sag-cancellation used by
        <code>MercuryWaveAligned</code>: the ball oscillates symmetrically
        about the common rest line, independently of its mass.</td>
  </tr>
</table>
<p>
  The rotational counterparts live in
  <a href=\"modelica://HarmonicMotion.Tests.Rotational\">Tests.Rotational</a>.
</p>
</html>"));
end Translational;
