codeunit 50102 "BSB Book Type Paperback Impl." implements "BSB Book Type Process V2"
{
    procedure StartDeployBook()
    begin
        Message('Print on Demand');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit DPD Standard versenden');
    end;

    procedure CheckQualityBook()
    begin
        Message('Qualitätsprüfung');
    end;
}