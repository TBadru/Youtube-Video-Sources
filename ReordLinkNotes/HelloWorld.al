// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.ReordLinkNotes;

using Microsoft.Sales.Customer;
using System.Environment.Configuration;
using System.Utilities;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        rl: Record "Record Link";
        m: Codeunit "Record Link Management";
    begin
        rl.findlast();
        m.WriteNote(rl, 'Hello ❤️');
        rl.Modify();
    end;
}