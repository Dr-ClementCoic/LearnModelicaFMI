within DiodeAttempts.Examples;
model Round3_VoltageSwitched "Round 3: ideal diode switched by its voltage"
  extends Rectifier(redeclare Diodes.Round3_VoltageSwitchedDiode diode);
end Round3_VoltageSwitched;
