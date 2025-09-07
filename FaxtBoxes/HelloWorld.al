// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
pageextension 50100 CustomerListExt extends "Customer Card"
{
    layout
    {
        addfirst(factboxes)
        {
            part(SalesOrders; "Our Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "Sell-to Customer No." = field("No.");
            }
        }
    }
}