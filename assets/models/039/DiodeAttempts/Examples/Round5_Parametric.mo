within DiodeAttempts.Examples;
model Round5_Parametric "Round 5: ideal diode described by the curve parameter s"
  extends Rectifier(redeclare Diodes.Round5_ParametricDiode diode);
end Round5_Parametric;
