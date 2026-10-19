within HarmonicMotion;
package Rotational "Pendulum wave — rotational oscillators tuned by string length"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<h4>HarmonicMotion.Rotational</h4>
<p>
  The <em>pendulum wave</em>: a row of planar pendula suspended from a common
  axis. Each pendulum is a rotational oscillator whose small-angle period
  depends only on its string length,
</p>
<pre>
  T_i = 2&pi; &radic;(L_i / g)
</pre>
<p>
  so the frequency ladder that produces the travelling wave is created purely
  by <strong>geometry</strong>. This is the classic classroom demonstration.
</p>

<h5>Contents</h5>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Model</th><th>Description</th></tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Rotational.Pendulum\">Pendulum</a></td>
    <td>Reusable single-pendulum <em>component</em>; requires an enclosing
        <code>inner&nbsp;World</code>.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Rotational.PendulumWave\">
        PendulumWave</a></td>
    <td>Complete <em>n</em>-pendulum array with the tuned length ladder and
        rainbow colouring &mdash; simulate this one.</td>
  </tr>
</table>

<h5>Relation to the translational variant</h5>
<p>
  <a href=\"modelica://HarmonicMotion.Translational\">Translational</a>
  builds exactly the same wave from spring&ndash;mass channels. The two
  packages use identical parameter names (<code>n</code>, <code>T</code>,
  <code>X</code>), the identical tuning law
  <code>N<sub>i</sub> = X + n &minus; i</code> and the same
  <a href=\"modelica://HarmonicMotion.Utilities.rainbowColors\">colour
  function</a>, so results can be compared one-to-one.
</p>
</html>"));
end Rotational;
