within DiodeAttempts.Diodes;
model Round5_ParametricDiode "Round 5: ideal diode described by the curve parameter s"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;

  Real s(start = 0, unit = "1") "Position along the L-shaped characteristic";
  Boolean off "True when blocking";

protected
  constant Modelica.Units.SI.Voltage unitVoltage = 1 "Gives s*unitVoltage the unit V";
  constant Modelica.Units.SI.Current unitCurrent = 1 "Gives s*unitCurrent the unit A";

equation
  off = s < 0;
  v = if off then s*unitVoltage else 0;
  i = if off then 0 else s*unitCurrent;

  annotation (Icon(graphics={
    Line(points={{-90,0},{90,0}}, color={0,0,255}),
    Polygon(points={{30,0},{-30,40},{-30,-40},{30,0}}, lineColor={0,0,255},
      fillColor={255,255,255}, fillPattern=FillPattern.Solid),
    Line(points={{30,40},{30,-40}}, color={0,0,255}),
    Text(extent={{-150,90},{150,50}}, textString="%name", textColor={0,0,255}),
    Text(extent={{-150,-40},{150,-100}}, textString="s", textColor={0,140,72})}));
end Round5_ParametricDiode;
