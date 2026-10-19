within DiodeAttempts.Diodes;
model ParametricDiodeWithLosses "Round 5 plus on-resistance, off-conductance and knee voltage (as in the MSL)"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;

  parameter Modelica.Units.SI.Resistance Ron = 1e-5 "Resistance when conducting";
  parameter Modelica.Units.SI.Conductance Goff = 1e-5 "Conductance when blocking";
  parameter Modelica.Units.SI.Voltage Vknee = 0 "Forward threshold voltage";

  Real s(start = 0, unit = "1") "Position along the characteristic";
  Boolean off "True when blocking";

protected
  constant Modelica.Units.SI.Voltage unitVoltage = 1 "Gives s*unitVoltage the unit V";
  constant Modelica.Units.SI.Current unitCurrent = 1 "Gives s*unitCurrent the unit A";

equation
  off = s < 0;
  v = (if off then s*unitVoltage else Ron*s*unitCurrent) + Vknee;
  i = (if off then Goff*s*unitVoltage else s*unitCurrent) + Goff*Vknee;

  annotation (Icon(graphics={
    Line(points={{-90,0},{90,0}}, color={0,0,255}),
    Polygon(points={{30,0},{-30,40},{-30,-40},{30,0}}, lineColor={0,0,255},
      fillColor={255,255,255}, fillPattern=FillPattern.Solid),
    Line(points={{30,40},{30,-40}}, color={0,0,255}),
    Text(extent={{-150,90},{150,50}}, textString="%name", textColor={0,0,255}),
    Text(extent={{-150,-40},{150,-100}}, textString="s + losses", textColor={0,140,72})}));
end ParametricDiodeWithLosses;
