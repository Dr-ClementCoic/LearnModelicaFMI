within HarmonicMotion.Utilities;
function pendulumPeriodFactor
  "Ratio of the exact pendulum period to the small-angle period 2π√(L/g)"
  extends Modelica.Icons.Function;

  input Modelica.Units.SI.Angle phi0(min = 0, max = Modelica.Constants.pi)
    "Swing amplitude (maximum angle from vertical)";
  output Real factor(min = 1) "T_exact / (2π√(L/g))";

protected
  constant Integer nIter = 10 "AGM iterations (converges quadratically)";
  Real a "Arithmetic mean of the AGM iteration";
  Real b "Geometric mean of the AGM iteration";
  Real aNext "Next arithmetic mean";

algorithm
  // Exact result via the arithmetic-geometric mean:
  //   T_exact / T_small = 1 / AGM(1, cos(phi0/2))
  a := 1;
  b := Modelica.Math.cos(phi0/2);
  for i in 1:nIter loop
    aNext := (a + b)/2;
    b     := sqrt(a*b);
    a     := aNext;
  end for;
  factor := 1/a;

  annotation (Documentation(info="<html>
<h4>HarmonicMotion.Utilities.pendulumPeriodFactor</h4>

<h5>Syntax</h5>
<pre>
  factor = HarmonicMotion.Utilities.<strong>pendulumPeriodFactor</strong>(phi0);
</pre>

<h5>Description</h5>
<p>
  A pendulum is only harmonic in the small-angle limit. Its exact period is
</p>
<pre>
  T_exact = 4 &radic;(L/g) &middot; K(sin(&phi;&sub0;/2))
          = 2&pi; &radic;(L/g) &middot; factor(&phi;&sub0;)
</pre>
<p>
  where <code>K</code> is the complete elliptic integral of the first kind.
  This function returns that <code>factor</code>, computed <em>exactly</em>
  (to machine precision) from the arithmetic&ndash;geometric mean identity
</p>
<pre>
  factor(&phi;&sub0;) = 1 / AGM(1, cos(&phi;&sub0;/2))
</pre>
<p>
  Ten AGM iterations are more than enough &mdash; the iteration converges
  quadratically, so machine precision is reached after about five.
</p>

<h5>Typical values</h5>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\">
  <tr><th>&phi;&sub0; (rad)</th><th>factor</th><th>period error of the small-angle formula</th></tr>
  <tr><td>0.05</td><td>1.000156</td><td>0.016&nbsp;%</td></tr>
  <tr><td>0.30</td><td>1.005644</td><td>0.56&nbsp;%</td></tr>
  <tr><td>0.50</td><td>1.015852</td><td>1.59&nbsp;%</td></tr>
  <tr><td>1.00</td><td>1.065720</td><td>6.57&nbsp;%</td></tr>
</table>

<h5>Why it matters here</h5>
<p>
  <a href=\"modelica://HarmonicMotion.Rotational.PendulumWave\">
  Rotational.PendulumWave</a> releases every pendulum from the <em>same</em>
  angle <code>phi0</code>, so every period is stretched by the same factor.
  Dividing the tuning frequency by this factor makes the row re-synchronise
  after exactly <code>T</code> seconds instead of
  <code>T&nbsp;&middot;&nbsp;factor</code>. At the default
  <code>phi0&nbsp;=&nbsp;0.5&nbsp;rad</code> the uncorrected drift is about
  half an oscillation over 30&ndash;44 cycles, which visibly destroys the
  pattern.
</p>
<p>
  The translational
  <a href=\"modelica://HarmonicMotion.Translational.MercuryWave\">
  MercuryWave</a> needs no such correction: a linear spring&ndash;mass
  oscillator is exactly isochronous.
</p>
</html>"));
end pendulumPeriodFactor;
