within ;
package DiodeAttempts "Five attempts at modelling an ideal diode, ending with the curve parameter s"
  extends Modelica.Icons.Package;

  annotation (
    uses(Modelica(version="4.1.0")),
    Documentation(info="<html>
<p>
  Companion models for newsletter article 039. An ideal diode has an L-shaped
  characteristic: it can be written neither as <code>i = f(v)</code> nor as
  <code>v = g(i)</code>. Each round in <a href=\"modelica://DiodeAttempts.Examples\">Examples</a>
  tries a different formulation in the same half-wave rectifier.
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>Round</th><th>Formulation</th><th>Outcome</th></tr>
  <tr><td>1</td><td><code>i = if v &gt; 0 then v/Ron else 0</code></td><td>Runs, but not ideal</td></tr>
  <tr><td>2</td><td>Same with <code>Ron = 0</code></td><td>Division by zero</td></tr>
  <tr><td>3</td><td>If-equation switched by <code>v</code></td><td>Never settles on a mode</td></tr>
  <tr><td>4</td><td>If-equation switched by <code>i</code></td><td>Never conducts (silently wrong)</td></tr>
  <tr><td>5</td><td>Curve parameter <code>s</code></td><td>Works</td></tr>
</table>
<p>
  <a href=\"modelica://DiodeAttempts.Examples.CompareWithMSL\">CompareWithMSL</a> shows that
  the <code>s</code> formulation with <code>Ron</code>, <code>Goff</code> and
  <code>Vknee</code> reproduces <code>Modelica.Electrical.Analog.Ideal.IdealDiode</code>.
</p>
</html>"));
end DiodeAttempts;
