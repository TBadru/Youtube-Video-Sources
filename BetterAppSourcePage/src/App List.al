page 56100 "AppSource Apps"
{
    Caption = 'AppSource Apps';
    UsageCategory = Administration;
    PageType = List;
    ApplicationArea = all;
    CardPageId = "AppSource App";
    SourceTable = AppSourceApp;
    SourceTableView = sorting(Popularity) order(descending);
    layout
    {
        area(Content)
        {
            repeater(rep)
            {

                field(Title; Rec.Title)
                {
                }
                field(Publisher; Rec.Publisher)
                {
                }
                field(Rating; Rec.Rating)
                { }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Fetch)
            {
                Caption = 'Fetch List';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    SessionId: Integer;
                begin
                    StartSession(SessionId, Codeunit::"AppSource Management");
                    Message('Refresh scheduled as background job, refresh this page to see result');
                end;
            }
        }
    }
    var
        Mgt: Codeunit "AppSource Management";
}