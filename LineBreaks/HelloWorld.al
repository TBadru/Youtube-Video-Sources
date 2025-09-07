// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.LineBreaks;

using Microsoft.Sales.Customer;
using System.RestClient;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        CR: Text[1];
        NL: Text[1];
        csv: Text;
        Lines: List of [Text];
        r: Codeunit "Rest Client";
    begin
        CR[1] := 13;
        NL[1] := 10;
        csv :=
@'1000,Hello,123
2000,More,234
3000,Last,345
';
        Lines := csv.Split(NL);
        Message('Line 2 = %1', Lines.Get(2).TrimEnd(CR) + '!!!');
    end;
}