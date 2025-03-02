// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.userSelection;

using Microsoft.Sales.Customer;
using System.Device;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage()
    var
        Camera: Codeunit Camera;
        InS: InStream;
        PictureName: Text;
    begin
        if Camera.IsAvailable() then begin
            if Camera.GetPicture(InS, PictureName) then begin
                Rec.FindLast();
                Rec.Image.ImportStream(InS, PictureName);
                Rec.Modify();
            end;
        end else
            message('Boo, no camera!');

    end;
}