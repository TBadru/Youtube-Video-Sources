// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.RestrictedTable;

using Microsoft.Sales.Customer;
using Microsoft.Integration.Shopify;
using System.Utilities;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        Ref: RecordRef;
        FR: FieldRef;
        i: Integer;
        d: Date;
    begin
        Ref.Open(30114);
        Ref.FindFirst();
        FR := Ref.Field(2);
        message('%1', FR.Value);
    end;
}