within LearnModelica.Mechanics.Translational; model SuspendedMassInitialized "Suspended Mass on damped spring"
    
    // Mass
    parameter .Modelica.Units.SI.Mass m = 10 "Mass of the mass";
    .Modelica.Units.SI.Position x "Position of the mass";
    .Modelica.Units.SI.Velocity v "Speed of the mass";
    .Modelica.Units.SI.Acceleration a "Acceleration of the mass";

    // Spring
    parameter .Modelica.Units.SI.TranslationalSpringConstant k = 1000 "Spring stiffness constant";
    parameter .Modelica.Units.SI.Length L0 = 1 "Rest length of the spring";

    // Damper
    parameter .Modelica.Units.SI.TranslationalDampingConstant c = 30 "Damping constant";

initial equation
    x = L0 "The mass shall start at the position where the spring is at rest";

equation
    a = -c/m * v -k/m * (x-L0) - .Modelica.Constants.g_n "Second Newton's law";
    a = der(v);
    v = der(x);

end SuspendedMassInitialized;
