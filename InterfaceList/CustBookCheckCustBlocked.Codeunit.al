codeunit 50106 "Cust Book Check Cust Blocked" implements "BSB Cust. Book Check Step"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BSB Cust Book Check Pipeline", OnRegisterCustBookCheckSteps, '', false, false)]
    local procedure "BSB Cust Book Check Pipeline_OnRegisterCustBookCheckSteps"(var Steps: List of [Interface "BSB Cust. Book Check Step"])
    begin
        Steps.Add(this);
    end;

    procedure Execute(Customer: Record Customer): Text
    begin
        if Customer.Blocked = Customer.Blocked::All then
            exit(StrSubstNo('Customer %1 ist gesperrt', Customer."No."))
        else
            exit(StrSubstNo('Customer %1 ist OK', Customer."No."));
    end;

    procedure GetSequence(): Integer
    begin
        exit(100);
    end;

    procedure IsEnabled(Customer: Record Customer): Boolean
    begin
        exit(Customer.Blocked <> Customer.Blocked::" ");
    end;
}