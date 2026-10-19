within DiodeAttempts.Diodes;
model Round3_VoltageSwitchedDiode "Round 3: ideal diode, mode decided by the voltage"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;

  Boolean on "True when conducting";

equation
  on = v > 0;
  if on then
    v = 0 "Closed switch: no voltage drop";
  else
    i = 0 "Open switch: no current";
  end if;

  annotation (Icon(graphics={
    Line(points={{-90,0},{90,0}}, color={0,0,255}),
    Polygon(points={{30,0},{-30,40},{-30,-40},{30,0}}, lineColor={0,0,255},
      fillColor={255,255,255}, fillPattern=FillPattern.Solid),
    Line(points={{30,40},{30,-40}}, color={0,0,255}),
    Text(extent={{-150,90},{150,50}}, textString="%name", textColor={0,0,255}),
    Text(extent={{-150,-40},{150,-100}}, textString="on = v > 0", textColor={128,128,128})}));
end Round3_VoltageSwitchedDiode;
