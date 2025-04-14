tableextension 50100 "GL" extends "Gen. Journal Line"
{
    fields
    {
        field(50100; SharePointFolder; Text[30])
        {

        }
        modify("Document No.")
        {
            trigger OnAfterValidate()
            begin
                SharePointFolder := Rec."Document No." + ' ' + format(Rec."Posting Date");
            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                SharePointFolder := Rec."Document No." + ' ' + format(Rec."Posting Date");
            end;
        }
    }
}

