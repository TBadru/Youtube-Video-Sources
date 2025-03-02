// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.WildcardMatchingStrings;

using Microsoft.Sales.Customer;
using System.Utilities;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        s1, s2 : Text;
        Regex: Codeunit Regex;
        Parts: list of [text];
        mrec: Record StringMatch;
    begin
        // s1 := '12345678';
        // s2 := '*B3*';
        // mrec.Match := s1;
        mrec.MatchDec := 123.345;
        mrec.insert();
        mrec.setfilter(MatchDec, '120..125');
        message('Filter %1 in %2 = %3', s2, s1, not mrec.IsEmpty());
    end;
}

table 50100 "StringMatch"
{
    TableType = Temporary;

    fields
    {
        field(1; Match; Text[2000])
        {

        }
        field(2; MatchDec; Decimal)
        { }
    }
}