// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.FilterGroup;

using Microsoft.Sales.Customer;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        Grp: Integer;
    begin
        Grp := Rec.FilterGroup();
        Rec.FilterGroup(-1);
        Rec.Setfilter(Name, '@*ski*');
        Rec.SetFilter(Contact, '@*bond*');
        Rec.FilterGroup(Grp);
        Rec.SetFilter(Address, '@*queen*');
    end;
}