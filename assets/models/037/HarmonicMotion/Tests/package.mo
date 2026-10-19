within HarmonicMotion;
package Tests "Standalone simulation and physical-verification models"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
<h4>HarmonicMotion.Tests</h4>
<p>
  Every model in this package is fully self-contained &mdash; it declares its
  own <code>inner&nbsp;World</code> &mdash; and can therefore be simulated
  directly. The verification models contain <code>assert</code> statements,
  so a simulation that runs to completion without an assertion failure counts
  as a passing test.
</p>
<p>
  The package mirrors the structure of the library itself, with one test
  sub-package per physical domain:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Sub-package</th><th>Covers</th></tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Tests.Rotational\">Rotational</a></td>
    <td><a href=\"modelica://HarmonicMotion.Rotational.Pendulum\">
        Rotational.Pendulum</a> — standalone run, energy conservation and
        period.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Tests.Translational\">
        Translational</a></td>
    <td><a href=\"modelica://HarmonicMotion.Translational.Oscillator\">
        Translational.Oscillator</a> and
        <a href=\"modelica://HarmonicMotion.Translational.SuspendedOscillator\">
        SuspendedOscillator</a> — standalone run, energy conservation, period
        and rest-line alignment.</td>
  </tr>
</table>
<p>
  Corresponding tests use matching names and matching tolerances in both
  sub-packages, which makes the rotational and translational implementations
  directly comparable.
</p>
</html>"));
end Tests;
