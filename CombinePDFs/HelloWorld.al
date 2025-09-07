report 50100 "Test PreRendering"
{
    WordLayout = 'test.docx';
    DefaultLayout = Word;
    dataset
    {
        dataitem(Customer; Customer)
        {

            column(Address_Customer; Address)
            {
            }
            column(Address2_Customer; "Address 2")
            {
            }
            column(Balance_Customer; Balance)
            {
            }
        }
    }
    trigger OnPreRendering(var RenderingPayload: JsonObject)
    begin
        message(format(RenderingPayload));
    end;
}