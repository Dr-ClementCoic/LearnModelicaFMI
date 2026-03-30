within LearnModelica.Mechanics.Translational; model SuspendedMass "Suspended mass on a damped spring"
  import SI = Modelica.Units.SI;
  import Modelica.Constants.g_n;

  parameter SI.Mass m = 10 "Mass of the suspended body";
  parameter SI.TranslationalSpringConstant k = 1000 "Spring stiffness";
  parameter SI.Length L0 = 1 "Rest length of the spring";
  parameter SI.TranslationalDampingConstant c = 30 "Damping constant";

  SI.Position x "Position of the mass";
  SI.Velocity v "Velocity of the mass";
  SI.Acceleration a "Acceleration of the mass";

equation
  a = -c/m * v - k/m * (x - L0) - g_n;
  a = der(v);
  v = der(x);

end SuspendedMass;
