page 56104 "AppSource Review Card"
{
    ApplicationArea = All;
    Caption = 'AppSource Review';
    DataCaptionExpression = Rec.Title;
    PageType = Card;
    SourceTable = "App Review";
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Review';

                field(Name; Rec.Name)
                {
                }
                field("Date"; Rec."Date")
                {
                }
                field(Rating; Rec.Rating)
                {
                }
            }
            group(Text)
            {
                ShowCaption = false;
                usercontrol(review; WebPageViewer)
                {
                    trigger ControlAddInReady(CallbackUrl: Text)
                    var
                        InS: InStream;
                        Content: Text;
                    begin
                        Rec.CalcFields(Text);
                        Rec.Text.CreateInStream(InS);
                        Ins.Read(Content);
                        CurrPage.review.SetContent(AddStyle(Rec.Title, Content));
                    end;
                }
            }
        }
    }
    procedure AddStyle(Title: Text; html: Text): Text
    begin

        exit('<html><body><div style=''font-size: 18px; font-family: "Segoe UI", Segoe, device-segoe, Tahoma, Helvetica, Arial, sans-serif !important;font-weight: bold !important;font-style: normal !important;text-transform: none !important;''>' + Title + '</div></br><div style=''font-size: 14px; font-family: "Segoe UI", Segoe, device-segoe, Tahoma, Helvetica, Arial, sans-serif !important;font-weight: normal !important;font-style: normal !important;text-transform: none !important;''>' + html + '</div></body></html>');
    end;
}
