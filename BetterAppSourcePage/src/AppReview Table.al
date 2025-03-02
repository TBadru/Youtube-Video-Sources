table 56101 "App Review"
{
    Caption = 'App Review';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; AppId; Text[100])
        {
            Caption = 'AppId';
        }
        field(2; "Review Guid"; Guid)
        {
            Caption = 'Review Guid';
        }
        field(3; Name; Text[200])
        {
            Caption = 'Name';
        }
        field(4; Title; Text[200])
        {
            Caption = 'Title';
        }
        field(5; "Text"; Blob)
        {
            Caption = 'Text';
        }
        field(6; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(7; Rating; Text[10])
        {
            Caption = 'Rating';
        }
    }
    keys
    {
        key(PK; AppId, "Review Guid")
        {
            Clustered = true;
        }
        key(Newest; Date)
        { }
    }
}
