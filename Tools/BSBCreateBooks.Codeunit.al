codeunit 50149 "BSB Create Books"
{
    trigger OnRun()
    var
        Cnt: Integer;
        OrdinalsList: List of [Integer];
        OrdinalCnt: Integer;
    begin
        BSBBook.DeleteAll();
        OrdinalsList := BSBBook.Type.Ordinals();
        OrdinalCnt := OrdinalsList.Count();
        for Cnt := 1 to 100 do CreateBook(Cnt, OrdinalsList.Get((Cnt - 1) mod OrdinalCnt + 1));
    end;

    var
        BSBBook: Record "BSB Book";

    local procedure CreateBook(Int: Integer; BookTypeInt: Integer)
    var
        Suffix: Text;
    begin
        BSBBook.Init();
        Suffix := Format(int, 0, '<Integer,3><Filler Character,0>');
        if not BSBBook.Get('B' + Suffix) then BSBBook."No." := 'B' + Suffix;
        BSBBook.Validate(Description, 'Buch ' + Suffix);
        BSBBook.Author := 'Autor ' + Suffix;
        BSBBook."Author Provision %" := Int mod 10;
        BSBBook.ISBN := CopyStr(Suffix, 1, MaxStrLen(BSBBook.ISBN));
        BSBBook."No. of Pages" := Int * 10;
        BSBBook.Type := "BSB Book Type".FromInteger(BookTypeInt);
        BSBBook."Date of Publishing" := Today() + Int;
        if not BSBBook.Insert(true) then BSBBook.Modify(true);
    end;
}
