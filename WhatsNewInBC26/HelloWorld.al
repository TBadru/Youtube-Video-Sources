// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.WhatsNewInBC26;

using Microsoft.Sales.Customer;
using System.Integration;
using Microsoft.Bank.Statement;

pageextension 50100 CustomerListExt extends "Customer List"
{
    actions
    {
        addfirst(processing)
        {
            action("Open the bank Statement here Sheryl!")
            {
                RunObject = page "Bank Account Statement";
                ApplicationArea = all;
            }
        }
    }
    trigger OnOpenPage();
    var
        s: Text;
        d: Decimal;
        l: Label 'Hello YouTube';
        da: Date;
        dt: DateTime;
    begin
        s := 'INVOICE1000';
        s := l.
        d := 123.456;
        da := today();
        dt := CurrentDateTime();
        //s := IncStr(s,);

        Message('%1 vs %2', d.ToText(), dt.ToText(true), format(dt, 0, 9));
    end;
}

page 50100 "test"
{
    PageType = UserControlHost;
    layout
    {
        area(Content)
        {
            usercontrol(web; WebPageViewer)
            {
                trigger ControlAddInReady(CallbackUrl: Text)
                begin
                    this.CurrPage.web.Navigate('https://www.hougaard.com');
                end;
            }
        }
    }
}