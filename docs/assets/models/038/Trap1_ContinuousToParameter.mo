model Trap1_ContinuousToParameter
  Real x;
  parameter Real p = x;
equation
  der(x) = -x;
end Trap1_ContinuousToParameter;
