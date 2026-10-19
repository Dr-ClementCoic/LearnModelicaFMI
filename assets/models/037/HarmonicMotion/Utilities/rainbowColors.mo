within HarmonicMotion.Utilities;
function rainbowColors
  "Return n RGB triples with hues evenly distributed around the colour wheel"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;

  input Integer n(min = 1) = 15 "Number of colours to generate";
  output Integer colors[n, 3]
    "RGB triples in the range 0...255, one row per oscillator";

protected
  Real h "Hue angle of the current colour (rad)";

algorithm
  for i in 1:n loop
    h := 2*pi*(i - 1)/n;
    colors[i, 1] := integer(127.5*(1 + sin(h)));
    colors[i, 2] := integer(127.5*(1 + sin(h + 2*pi/3)));
    colors[i, 3] := integer(127.5*(1 + sin(h + 4*pi/3)));
  end for;

  annotation (Documentation(info="<html>
<h4>HarmonicMotion.Utilities.rainbowColors</h4>

<h5>Syntax</h5>
<pre>
  colors = HarmonicMotion.Utilities.<strong>rainbowColors</strong>(n);
</pre>

<h5>Description</h5>
<p>
  Returns an <code>n&times;3</code> integer matrix of RGB values that can be
  assigned directly to an array of
  <code>Modelica.Mechanics.MultiBody.Types.Color</code>, e.g.
</p>
<pre>
  parameter Modelica.Mechanics.MultiBody.Types.Color ballColors[n] =
    HarmonicMotion.Utilities.rainbowColors(n);
</pre>
<p>
  Hue <em>i</em> is placed at
  h<sub>i</sub>&nbsp;=&nbsp;2&pi;(i&nbsp;&minus;&nbsp;1)/n and converted to
  RGB with the classic sinusoidal HSV approximation
</p>
<pre>
  R = 127.5 (1 + sin h)
  G = 127.5 (1 + sin(h + 2&pi;/3))
  B = 127.5 (1 + sin(h + 4&pi;/3))
</pre>
<p>
  The result is fully parametric in <code>n</code>: the colours stay evenly
  spaced for any number of oscillators, and index <em>i</em> always receives
  the same colour in every model that uses this function.
</p>
</html>"));
end rainbowColors;
