// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.CheatTheChangeLog;

using Microsoft.Sales.Customer;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        Customer: Record Customer;
        Ref: RecordRef;
        FR: FieldRef;
    begin
        // Customer.Get('C00010');
        // // Customer."Credit Limit (LCY)" := 6000;
        // // Customer.Modify(false);

        // Ref.GetTable(Customer);
        // FR := Ref.Field(Customer.FieldNo("Credit Limit (LCY)"));
        // FR.Value := 7000;
        // Ref.Modify();

        //Customer.ModifyAll("Credit Limit (LCY)", 8000, false);


    end;
}