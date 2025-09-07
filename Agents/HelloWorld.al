// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.Agents;

using Microsoft.Sales.Customer;
using System.Utilities;
using System.Agents;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        Ref: RecordRef;
        TB: Codeunit "Temp Blob";
        FR: FieldRef;
        InS: InStream;
        An: Text;
    begin
        ClientType::
    end;
}