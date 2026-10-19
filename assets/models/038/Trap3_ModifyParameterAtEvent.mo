model Trap3_ModifyParameterAtEvent
  parameter Real p = 1.0;
equation
  when sample(0, 1) then
    p = 2.0;
  end when;
end Trap3_ModifyParameterAtEvent;
