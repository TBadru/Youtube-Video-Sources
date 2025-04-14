// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.ReadNotes;

using Microsoft.Sales.Customer;
using System.Environment.Configuration;
using System.Utilities;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        RL: Record "Record Link";
        Ref: RecordRef;
        FR: FieldRef;
        TmpBlob: Codeunit "Temp Blob";
        TmpStr: Text;
        InS: InStream;
        x: Codeunit "Record Link Management";
    begin
        RL.Setrange(Type, RL.Type::Note);
        if RL.FindSet() then
            repeat
                Ref.GetTable(RL);
                FR := Ref.Field(RL.FieldNo(Note));
                TmpBlob.FromFieldRef(FR);
                if TmpBlob.Length() > 0 then begin
                    TmpBlob.CreateInStream(InS, TextEncoding::UTF8);
                    InS.Read(TmpStr);
                    message('%1 vs %2', x.ReadNote(RL), TmpStr);
                end else
                    message('empty');
            until RL.Next() = 0;
    end;

}