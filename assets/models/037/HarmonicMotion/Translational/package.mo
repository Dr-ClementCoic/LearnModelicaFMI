within HarmonicMotion;
package Translational "Mercury wave — translational oscillators tuned by mass"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<h4>HarmonicMotion.Translational</h4>
<p>
  The <em>mercury wave</em>: a row of vertical spring&ndash;mass channels.
  Each channel is a translational oscillator whose period depends on its
  mass and spring stiffness,
</p>
<pre>
  T_i = 2&pi; &radic;(m_i / c)
</pre>
<p>
  All channels share one stiffness <code>c</code>, so the frequency ladder
  that produces the travelling wave is created purely by
  <strong>inertia</strong> &mdash; the translational mirror image of the
  <a href=\"modelica://HarmonicMotion.Rotational\">Rotational</a> package,
  where it is created by geometry.
</p>

<h5>Contents</h5>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Model</th><th>Description</th></tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Translational.Oscillator\">
        Oscillator</a></td>
    <td>Reusable single spring&ndash;mass <em>component</em> (gravity-free
        staging); requires an enclosing <code>inner&nbsp;World</code>.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Translational.SuspendedOscillator\">
        SuspendedOscillator</a></td>
    <td>Reusable channel for the gravity-loaded, video-style staging: an
        identical spring hung from a rigid rod that cancels the static sag.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Translational.MercuryWave\">
        MercuryWave</a></td>
    <td>Complete <em>n</em>-channel wave with staggered rest heights &mdash;
        the clearest view of the individual springs.</td>
  </tr>
  <tr>
    <td><a href=\"modelica://HarmonicMotion.Translational.MercuryWaveAligned\">
        MercuryWaveAligned</a></td>
    <td>Complete <em>n</em>-channel wave in which every mass starts on the
        <em>same</em> horizontal line, as in the classic video.</td>
  </tr>
</table>

<h5>Two stagings, one physics</h5>
<p>
  <code>MercuryWave</code> switches gravity off and lets each mass sit at its
  own unstretched spring length, which makes the springs easy to tell apart.
  <code>MercuryWaveAligned</code> keeps gravity on and cancels the static sag
  <code>m&nbsp;g/c</code> with a rigid rod of channel-specific length, so all
  masses rest on one line. Both use the identical mass ladder and therefore
  produce the identical wave.
</p>
</html>"));
end Translational;
