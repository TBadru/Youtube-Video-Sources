page 56102 "App FactBox"
{
    PageType = CardPart;
    SourceTable = AppSourceApp;
    Caption = 'Information';
    ApplicationArea = all;
    layout
    {
        area(Content)
        {
            field(Publisher; Rec.Publisher)
            {
                trigger OnDrillDown()
                var
                    App2: Record AppSourceApp;
                begin
                    App2.Setrange(Publisher, Rec.Publisher);
                    Page.Run(Page::"AppSource Apps", App2);
                end;
            }
            field(AppVersion; Rec.AppVersion)
            {

            }
            field(ReleaseDate; DT2Date(Rec.ReleaseDate))
            {
                Caption = 'Release Date';
            }
            field(Star5; Rec.Star5)
            {
                ToolTip = 'Specifies the value of the 5 Stars field.', Comment = '%';
            }
            field(Star4; Rec.Star4)
            {
                ToolTip = 'Specifies the value of the 4 Stars field.', Comment = '%';
            }
            field(Star3; Rec.Star3)
            {
                ToolTip = 'Specifies the value of the 3 Stars field.', Comment = '%';
            }
            field(Star2; Rec.Star2)
            {
                ToolTip = 'Specifies the value of the 2 Stars field.', Comment = '%';
            }
            field(Star1; Rec.Star1)
            {
                ToolTip = 'Specifies the value of the 1 Stars field.', Comment = '%';
            }
        }
    }
}