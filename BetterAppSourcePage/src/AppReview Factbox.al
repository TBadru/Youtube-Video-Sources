page 56103 "AppSource Reviews"
{
    ApplicationArea = All;
    Caption = 'AppSource Reviews';
    PageType = ListPart;
    SourceTable = "App Review";
    SourceTableView = sorting(Date) order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Title; Rec.Title)
                {
                    trigger OnDrillDown()
                    var
                        ReviewRec: Record "App Review";
                    begin
                        ReviewRec.Setrange(AppId, Rec.AppId);
                        ReviewRec.Setrange("Review Guid", Rec."Review Guid");
                        Page.RunModal(Page::"AppSource Review Card", ReviewRec);
                    end;
                }
                field(Rating; Rec.Rating)
                {

                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if Rec.FindFirst() then;
    end;
}
