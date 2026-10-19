within DiodeAttempts.Examples;
model Round1_Resistive "Round 1: switched resistor with Ron = 1 Ohm (runs, but not ideal)"
  extends Rectifier(redeclare Diodes.Round1_ResistiveDiode diode(Ron = 1));
end Round1_Resistive;
