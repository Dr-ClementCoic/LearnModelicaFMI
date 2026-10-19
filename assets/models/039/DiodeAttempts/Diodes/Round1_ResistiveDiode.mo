within DiodeAttempts.Diodes;
model Round1_ResistiveDiode "Rounds 1-2: current as a function of voltage (a switched resistor)"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;

  parameter Modelica.Units.SI.Resistance Ron = 1 "Resistance when conducting";

equation
  i = if v > 0 then v/Ron else 0;

  annotation (Icon(graphics={
    Line(points={{-90,0},{90,0}}, color={0,0,255}),
    Polygon(points={{30,0},{-30,40},{-30,-40},{30,0}}, lineColor={0,0,255},
      fillColor={255,255,255}, fillPattern=FillPattern.Solid),
    Line(points={{30,40},{30,-40}}, color={0,0,255}),
    Text(extent={{-150,90},{150,50}}, textString="%name", textColor={0,0,255}),
    Text(extent={{-150,-40},{150,-100}}, textString="i = v/Ron", textColor={128,128,128})}));
end Round1_ResistiveDiode;
