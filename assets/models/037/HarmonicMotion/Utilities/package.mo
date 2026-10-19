within HarmonicMotion;
package Utilities "Shared helper functions used by the wave models"
  extends Modelica.Icons.UtilitiesPackage;

  annotation (Documentation(info="<html>
<h4>HarmonicMotion.Utilities</h4>
<p>
  Small, side-effect-free helpers that are shared by the
  <a href=\"modelica://HarmonicMotion.Rotational\">Rotational</a> and
  <a href=\"modelica://HarmonicMotion.Translational\">Translational</a>
  wave models. Keeping them here guarantees that both variants look and
  behave consistently.
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Function</th><th>Purpose</th></tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Utilities.rainbowColors\">
        rainbowColors</a></td>
    <td>Generates <code>n</code> RGB triples with hues evenly distributed
        around the colour wheel.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Utilities.pendulumPeriodFactor\">
        pendulumPeriodFactor</a></td>
    <td>Exact ratio of the finite-amplitude pendulum period to the
        small-angle period 2&pi;&radic;(L/g).</td>
  </tr>
</table>
</html>"));
end Utilities;
