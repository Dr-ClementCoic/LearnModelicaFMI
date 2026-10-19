within DiodeAttempts.Examples;
model Round4_CurrentSwitched "Round 4: ideal diode switched by its current"
  extends Rectifier(redeclare Diodes.Round4_CurrentSwitchedDiode diode);
end Round4_CurrentSwitched;
