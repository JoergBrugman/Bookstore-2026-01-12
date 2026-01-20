codeunit 50101 "BSB Book Type Hardcover Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Buch aus Lager picken');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit UPS Premium versenden');
    end;

}