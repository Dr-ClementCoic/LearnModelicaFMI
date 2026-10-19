within ;
package HarmonicMotion "Reproducing fascinating experiments in harmonic motion"
  extends Modelica.Icons.Package;

  annotation (
    Documentation(info="<html>
<h4>HarmonicMotion</h4>
<p>
  A Modelica package that reproduces the mesmerising <em>harmonic-motion
  wave</em> experiments: a row of independent oscillators whose natural
  frequencies form an evenly spaced ladder. Released together, they drift
  out of phase, trace a travelling wave, briefly split into counter-rotating
  patterns, and finally re-synchronise after a fixed cycle time.
</p>
<p>
  The same idea is realised twice &mdash; once with <strong>rotational</strong>
  oscillators (pendula, tuned by string length) and once with
  <strong>translational</strong> oscillators (spring&ndash;mass channels, tuned
  by mass). Both variants share the same parameter names, the same tuning
  formula and the same colouring scheme so that they can be compared directly.
</p>

<h5>Contents</h5>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Sub-package</th><th>Description</th></tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Rotational\">Rotational</a></td>
    <td>Pendulum wave: planar pendula tuned through their string length
        <code>L</code>.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Translational\">Translational</a></td>
    <td>Mercury wave: vertical spring&ndash;mass channels tuned through their
        mass <code>m</code>.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Utilities\">Utilities</a></td>
    <td>Shared helper functions (colour generation).</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Tests\">Tests</a></td>
    <td>Self-contained simulation and physical-verification models.</td>
  </tr>
</table>

<h5>Common design</h5>
<p>
  Every wave model exposes the same four tuning parameters:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Symbol</th><th>Meaning</th></tr>
  <tr><td><code>n</code></td><td>Number of oscillators</td></tr>
  <tr><td><code>T</code></td><td>Pattern (re-synchronisation) cycle time</td></tr>
  <tr><td><code>X</code></td><td>Oscillations performed by the slowest element in <code>T</code></td></tr>
  <tr><td><code>amplitude</code> / <code>phi0</code></td><td>Common initial displacement</td></tr>
</table>
<p>
  Oscillator <em>i</em> performs <code>N<sub>i</sub> = X + n &minus; i</code>
  oscillations during <code>T</code>, so element&nbsp;1 is the fastest and
  element&nbsp;<code>n</code> the slowest. The tuning laws follow directly
  from the period of each oscillator type:
</p>
<pre>
  Rotational     T_i = k &middot; 2&pi;&radic;(L_i/g)   &rArr;   L_i = g &middot; (T / (2&pi; k N_i))&sup2;
  Translational  T_i = 2&pi;&radic;(m_i/c)       &rArr;   m_i = c &middot; (T / (2&pi; N_i))&sup2;
</pre>
<p>
  The extra factor <code>k</code> in the rotational law is the
  finite-amplitude correction
  <a href=\"modelica://HarmonicMotion.Utilities.pendulumPeriodFactor\">
  pendulumPeriodFactor(phi0)</a>: a pendulum is only isochronous for small
  angles, whereas a linear spring&ndash;mass oscillator is isochronous
  exactly.
</p>

<h5>Colours</h5>
<p>
  All wave models colour their oscillators with
  <a href=\"modelica://HarmonicMotion.Utilities.rainbowColors\">
  Utilities.rainbowColors</a>, which distributes hues evenly around the
  colour wheel, so the same index always gets the same colour in both
  variants.
</p>

<h5>Quick start</h5>
<ol>
  <li>Simulate
      <a href=\"modelica://HarmonicMotion.Rotational.PendulumWave\">
      Rotational.PendulumWave</a> for 54&nbsp;s and open the 3-D animation.</li>
  <li>Simulate
      <a href=\"modelica://HarmonicMotion.Translational.MercuryWaveAligned\">
      Translational.MercuryWaveAligned</a> for 60&nbsp;s for the
      video-style version in which all masses start on one line.</li>
  <li>Run the models in
      <a href=\"modelica://HarmonicMotion.Tests\">Tests</a> to verify
      physical correctness (energy conservation, periods, rest positions).</li>
</ol>
</html>"),
    uses(Modelica(version="4.0.0")),
    version="2.0.0");
end HarmonicMotion;
