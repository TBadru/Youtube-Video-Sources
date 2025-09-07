pageextension 50130 "Color" extends "General Journal"
{
    layout
    {
        addafter("Posting Date")
        {
            field(Color; Rec.Color)
            {
                ApplicationArea = all;
                Width = 1;
            }
        }
    }
}