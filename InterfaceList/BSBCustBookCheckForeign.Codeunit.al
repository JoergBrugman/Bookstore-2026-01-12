codeunit 50107 "BSB Cust. Book Check Foreign" implements "BSB Cust. Book Check Step"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BSB Cust Book Check Pipeline", OnRegisterCustBookCheckSteps, '', false, false)]
    local procedure "BSB Cust Book Check Pipeline_OnRegisterCustBookCheckSteps"(var Steps: List of [Interface "BSB Cust. Book Check Step"])
    begin
        Steps.Add(this);
    end;

    procedure Execute(Customer: Record Customer): Text
    begin
        if Customer."Country/Region Code" <> '' then
            exit(StrSubstNo('Customer %1 ist ausländisch', Customer."No."))
        else
            exit(StrSubstNo('Customer %1 ist OK (Inländer)', Customer."No."))

    end;

    procedure GetSequence(): Integer
    begin
        exit(200);
    end;

    procedure IsEnabled(Customer: Record Customer): Boolean
    begin
        exit(Customer."BSB Favorite Book No." <> '');
    end;
}