within DiodeAttempts.Examples;
model Round2_ZeroResistance "Round 2: the same switched resistor with Ron = 0 (division by zero)"
  extends Rectifier(redeclare Diodes.Round1_ResistiveDiode diode(Ron = 0));
end Round2_ZeroResistance;
