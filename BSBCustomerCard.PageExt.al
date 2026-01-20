pageextension 50100 "BSB Customer Card" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group("BSB Bookstore")
            {
                Caption = 'Bookstore';

                field("BSB Favorite Book No."; Rec."BSB Favorite Book No.")
                {
                    ApplicationArea = All;
                }
                field("BSB Favorite Book Description"; Rec."BSB Favorite Book Description")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter(Control149)
        {
            part(BSBBookFactbox; "BSB Book Factbox")
            {
                SubPageLink = "No." = field("BSB Favorite Book No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("BSB ProcessPipeline")
            {
                Caption = 'Process Pipeline';
                Image = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    BSBCustBookCheckPipeline: Codeunit "BSB Cust Book Check Pipeline";
                begin
                    BSBCustBookCheckPipeline.ProcessPipeline(Rec);
                end;

            }
        }
    }
}