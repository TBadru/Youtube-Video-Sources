page 56101 "AppSource App"
{
    ApplicationArea = All;
    Caption = 'AppSource App';
    PageType = Card;
    SourceTable = AppSourceApp;
    Editable = false;

    layout
    {
        area(Content)
        {
            usercontrol(Images; WebAddIn)
            {
                trigger ImAmReady()
                begin
                    Mgt.RefreshInfo(Rec);
                    RefreshWebContent();
                end;
            }
            //}
        }
        area(FactBoxes)
        {
            part(AppFact; "App FactBox")
            {
                SubPageLink = AppID = field(AppID);
            }
            part(Review; "AppSource Reviews")
            {
                SubPageLink = AppId = field(AppID);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Install)
            {
                Caption = 'Install';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = MoveDown;
                trigger OnAction()
                var
                    ExtManagement: Codeunit "Extension Management";
                begin
                    ExtManagement.DeployExtension(Rec.AppID, GlobalLanguage, true);
                end;
            }
            action(VendorLink)
            {
                Caption = 'Help';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Help;
                trigger OnAction()
                begin
                    Hyperlink(Rec.HelpLink);
                end;
            }
            action(VendorLink2)
            {
                Caption = 'Support';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = OnlineHelp;
                trigger OnAction()
                begin
                    Hyperlink(Rec.SupportLink);
                end;
            }

            action(Fetch)
            {
                Caption = 'Refresh Information';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = DocInBrowser;
                trigger OnAction()
                var
                    PageNo: Integer;
                    Window: Dialog;
                    InS: InStream;
                begin
                    Mgt.RefreshInfo(Rec);
                    RefreshWebContent();
                    CurrPage.Update();
                end;
            }
        }
    }
    local procedure RefreshWebContent()
    var
        InS: InStream;
        Html: Text;
    begin
        Rec.CalcFields(ImageViewer);
        Rec.ImageViewer.CreateInStream(InS);
        InS.Read(Html);
        CurrPage.Images.Render(Html);
    end;

    var
        Mgt: Codeunit "AppSource Management";

}