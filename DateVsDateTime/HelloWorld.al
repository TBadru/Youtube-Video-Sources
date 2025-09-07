// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.DateVsDateTime;

using Microsoft.Sales.Customer;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        dur: Duration;
        Date0: Date;
        date1: DateTime;
    begin
        Date0 := 20241231D;
        dur := 1000 * 60 * 60 * 24;
        date1 := CurrentDateTime() + dur;
        message('%1', Date0);
    end;
}