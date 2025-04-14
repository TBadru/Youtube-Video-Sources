// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.BarcodeAddIn;

using Microsoft.Sales.Customer;
using System.Device;

pageextension 50100 CustomerListExt extends "Customer List"
{
    layout
    {
        addfirst(content)
        {
            usercontrol(BarCode; BarcodeScannerProviderAddIn)
            {
                ApplicationArea = all;
                Visible = true;
                trigger BarcodeReceived(Barcode: Text; Format: Text)
                begin
                    message(Barcode);
                end;
            }
        }
    }
    trigger OnOpenPage();
    begin
        Message('App published: Hello world');
    end;
}