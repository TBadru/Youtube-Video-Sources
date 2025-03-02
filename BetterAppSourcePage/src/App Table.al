table 56100 AppSourceApp
{
    Caption = 'AppSourceApp';
    DataClassification = ToBeClassified;
    DataCaptionFields = Title;

    fields
    {
        field(1; AppID; Text[100])
        {
            Caption = 'AppID';
        }
        field(2; Title; Text[250])
        {
            Caption = 'Title';
        }
        field(3; Publisher; Text[100])
        {
            Caption = 'Publisher';
        }
        field(4; Ratings; Integer)
        {
            Caption = 'Rating';
        }
        field(5; AverageRating; Decimal)
        {
            Caption = 'AverageRating';
        }
        field(6; NumberOffRatings; Integer)
        {
            Caption = 'NumberOffRatings';
        }
        field(7; Popularity; Decimal)
        {
            Caption = 'Popularity';
        }
        field(8; Icon; Media)
        {
            Caption = 'Icon';
        }
        field(9; shortDescription; Text[2048])
        {
            Caption = 'shortDescription';
        }
        field(10; Rating; Text[10])
        {
            Caption = 'Rating';
        }
        field(11; Blank; Text[1])
        { }
        field(12; EntityId; Text[200])
        { }
        field(13; LargeIcon; Text[200])
        { }
        field(14; Description; Blob)
        {

        }
        field(20; ImageViewer; Blob)
        { }
        field(21; ReleaseDate; DateTime)
        {
            Caption = 'Release Date';
        }
        field(22; AppVersion; Text[50])
        {
            Caption = 'Version';
        }
        field(31; Star1; Integer)
        {
            Caption = '1 Stars';
        }
        field(32; Star2; Integer)
        {
            Caption = '2 Stars';
        }
        field(33; Star3; Integer)
        {
            Caption = '3 Stars';
        }
        field(34; Star4; Integer)
        {
            Caption = '4 Stars';
        }
        field(35; Star5; Integer)
        {
            Caption = '5 Star Reviews';
        }
        field(40; HelpLink; Text[200])
        {
            Caption = 'Help Link';
        }
        field(41; SupportLink; Text[200])
        {
            Caption = 'Support Link';
        }
    }
    keys
    {
        key(PK; AppID)
        {
            Clustered = true;
        }
        key(PopularityKey; popularity)
        { }
    }
    fieldgroups
    {
        fieldgroup(Brick; Publisher, Title, Blank, Rating, Icon, shortDescription)
        {
        }
    }
}
