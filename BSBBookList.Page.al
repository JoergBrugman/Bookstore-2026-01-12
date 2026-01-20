page 50101 "BSB Book List"
{
    Caption = 'Books';
    PageType = List;
    SourceTable = "BSB Book";
    Editable = false;
    CardPageId = "BSB Book Card";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Books)
            {
                field("No."; Rec."No.") { }
                field(Description; Rec.Description) { }
                field(ISBN; Rec.ISBN) { }
                field(Author; Rec.Author) { }
                field("No. of Pages"; Rec."No. of Pages") { Visible = false; }
                field(Type; Rec."Type") { }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links) { ApplicationArea = RecordLinks; }
            systempart(Notes; Notes) { ApplicationArea = Notes; }

        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateBooks)
            {
                Caption = 'Create Books';
                Image = CreateDocuments;
                ToolTip = 'Create Books for Demo';
                RunObject = codeunit "BSB Create Books";
            }
            action(ClassicImpl)
            {
                Caption = 'Classic Impl.';
                Image = Process;
                ToolTip = 'Classic Implementation';

                trigger OnAction()
                var
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypeNoneImpl: Codeunit "BSB Book Type None Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    IsHandled: Boolean;
                begin
                    OnBeforeHandleBookType(Rec, IsHandled);
                    if IsHandled then
                        exit;

                    case Rec.Type of
                        "BSB Book Type"::Hardcover:
                            begin
                                BSBBookTypeHardcoverImpl.StartDeployBook();
                                BSBBookTypeHardcoverImpl.StartDeliverBook();
                            end;
                        "BSB Book Type"::Paperback:
                            begin
                                BSBBookTypePaperbackImpl.StartDeployBook();
                                BSBBookTypePaperbackImpl.StartDeliverBook();
                            end;
                        else begin
                            BSBBookTypeNoneImpl.StartDeployBook();
                            BSBBookTypeNoneImpl.StartDeliverBook();
                        end;
                    end;
                end;
            }
            action(InterfaceImpl)
            {
                Caption = 'Interface Impl.';
                Image = Process;
                ToolTip = 'Interface Implementation';

                trigger OnAction()
                var
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypeNoneImpl: Codeunit "BSB Book Type None Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    IsHandled: Boolean;
                    BSBBookTypeProcess: Interface "BSB Book Type Process";
                begin
                    OnBeforeHandleBookType(Rec, IsHandled);
                    if IsHandled then
                        exit;

                    case Rec.Type of
                        "BSB Book Type"::Hardcover:
                            BSBBookTypeProcess := BSBBookTypeHardcoverImpl;
                        "BSB Book Type"::Paperback:
                            BSBBookTypeProcess := BSBBookTypePaperbackImpl;
                        else
                            BSBBookTypeProcess := BSBBookTypeNoneImpl;
                    end;
                    BSBBookTypeProcess.StartDeployBook();
                    BSBBookTypeProcess.StartDeliverBook();
                end;
            }
            action(EnumWithInterfaceImpl)
            {
                Caption = 'Enum with Interface Impl.';
                Image = Process;
                ToolTip = 'Enum with Interface Implementation';

                trigger OnAction()
                var
                    BSBBookTypeProcess: Interface "BSB Book Type Process";
                begin
                    BSBBookTypeProcess := Rec.Type;
                    BSBBookTypeProcess.StartDeployBook();
                    if BSBBookTypeProcess is "BSB Book Type Process V2" then
                        (BSBBookTypeProcess as "BSB Book Type Process V2").CheckQualityBook();
                    BSBBookTypeProcess.StartDeliverBook();
                end;
            }
            action(ToDelete)
            {
                Caption = 'List of Interfaces';
                Image = Process;
                ToolTip = 'List of Interfaces';

                trigger OnAction()
                var
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    BSBBookTypeProcess: Interface "BSB Book Type Process";
                    BSBBookTypeProcessList: List of [Interface "BSB Book Type Process"];
                begin
                    BSBBookTypeProcessList.Add(BSBBookTypeHardcoverImpl);
                    BSBBookTypeProcessList.Add(BSBBookTypePaperbackImpl);

                    foreach BSBBookTypeProcess in BSBBookTypeProcessList do begin
                        BSBBookTypeProcess.StartDeployBook();
                        BSBBookTypeProcess.StartDeliverBook();
                    end;
                end;
            }
        }
        area(Promoted)
        {
            group(Demo)
            {
                Caption = 'Demo';
                actionref(CreateBooks_Promoted; CreateBooks) { }
                actionref(ClassicImpl_Promoted; ClassicImpl) { }
                actionref(InterfaceImpl_Promoted; InterfaceImpl) { }
                actionref(EnumWithInterfaceImpl_Promoted; EnumWithInterfaceImpl) { }
            }
        }
    }

    [IntegrationEvent(false, false)]
    local procedure OnBeforeHandleBookType(Rec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;
}