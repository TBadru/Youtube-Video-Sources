page 50100 "Our Factbox"
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Order));
    Editable = false;
    Caption = 'Sales Orders!';
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            repeater(Rep)
            {

                field("No."; Rec."No.")
                {
                    trigger OnDrillDown()
                    begin
                        Page.RunModal(Page::"Sales Order", Rec);
                    end;
                }
                field("Order Date"; Rec."Order Date")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Test)
            {
                Caption = 'Test';
                Scope = Repeater;
                trigger OnAction()
                var

                begin
                    message('hello!');
                end;
            }
        }
    }
}