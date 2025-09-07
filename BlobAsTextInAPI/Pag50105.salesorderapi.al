page 50105 salesorderapi
{
    APIGroup = 'group';
    APIPublisher = 'hougaard';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'salesorderapi';
    DelayedInsert = true;
    EntityName = 'salesorder';
    EntitySetName = 'salesorders';
    PageType = API;
    SourceTable = "Sales Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(workDescription; WorkDescription_BlobAsTxt)
                {
                    Caption = 'Work Description';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        InS: InStream;
    begin
        Rec.CalcFields("Work Description");
        Rec."Work Description".CreateInStream(InS);
        Ins.Read(WorkDescription_BlobAsTxt);
    end;

    var
        WorkDescription_BlobAsTxt: Text;
}
