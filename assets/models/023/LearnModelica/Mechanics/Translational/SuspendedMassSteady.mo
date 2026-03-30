within LearnModelica.Mechanics.Translational; model SuspendedMassSteady "Suspended Mass on damped spring"
    
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

    // Initialization
    parameter Boolean steadyInit = true "true is steady state initialization" 
        annotation ( Dialog ( tab = "Initialization") );
    parameter .Modelica.Units.SI.Length xInit = L0 "Initial position of the mass" 
        annotation ( Dialog ( tab = "Initialization", enable = not steadyInit ) );

initial equation
    if steadyInit then
        a = 0;
        v = 0;
    else
        x = L0 "The mass shall start at the position where the spring is at rest";
    end if;
    
equation
    a = -c/m * v -k/m * (x-L0) - .Modelica.Constants.g_n "Second Newton's law";
    a = der(v);
    v = der(x);

    annotation(
        Documentation(info = "
        <html>
            <p>This model of a suspended mass allows us to toggle between two different initialization:</p>
            <ol>
                <li>a steady state initialization with steadyInit set to true.</li>
                <li>a specified initial position of the mass xInit, when steadyInit is set to false.</li>
            </ol>
        </html>"));
end SuspendedMassSteady;
