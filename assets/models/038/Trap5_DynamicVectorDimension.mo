model Trap5_DynamicVectorDimension
  import Modelica.Mechanics.Translational.Components.Mass;

  Real x;
  parameter Integer n = integer(x);
  Mass masses[n];
equation
  der(x) = 1;
end Trap5_DynamicVectorDimension;
