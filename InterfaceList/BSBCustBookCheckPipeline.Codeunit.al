codeunit 50105 "BSB Cust Book Check Pipeline"
{
    procedure ProcessPipeline(Customer: Record Customer)
    var
        Step: Interface "BSB Cust. Book Check Step";
        Steps: List of [Interface "BSB Cust. Book Check Step"];
    begin
        CollectSteps(Steps);
        SortSteps(Steps);

        foreach Step in Steps do
            if Step.IsEnabled(Customer) then
                Message(Step.Execute(Customer));
    end;

    local procedure CollectSteps(var Steps: List of [Interface "BSB Cust. Book Check Step"])
    begin
        OnRegisterCustBookCheckSteps(Steps);
    end;

    local procedure SortSteps(var Steps: List of [Interface "BSB Cust. Book Check Step"])
    var
        Integers: Record Integer;
        Sorted: List of [Interface "BSB Cust. Book Check Step"];
        Step: Interface "BSB Cust. Book Check Step";
    begin
        foreach Step in Steps do begin
            Integers.Get(Step.GetSequence());
            Integers.Mark(true);
        end;
        Integers.MarkedOnly(true);
        if Integers.FindSet() then
            repeat
                foreach Step in Steps do
                    if Step.GetSequence() = Integers.Number then
                        Sorted.Add(Step);
            until Integers.Next() = 0;

        Steps := Sorted;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRegisterCustBookCheckSteps(var Steps: List of [Interface "BSB Cust. Book Check Step"])
    begin
    end;
}