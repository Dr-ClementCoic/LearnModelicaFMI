within DiodeAttempts.Diodes;
model Round4_CurrentSwitchedDiode "Round 4: ideal diode, mode decided by the current"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;

  Boolean on "True when conducting";

equation
  on = i > 0;
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
    Text(extent={{-150,-40},{150,-100}}, textString="on = i > 0", textColor={128,128,128})}));
end Round4_CurrentSwitchedDiode;
