// pageextension 50100 "test" extends "Customer List"
// {
//     trigger OnOpenPage()
//     var
//         erl: recordRef;
//     //x: Record "Email Rate Limit";
//     begin
//         erl.open(8912);
//         erl.findfirst();
//         erl.field(5).value(10);
//         erl.modify();
//     end;
// }

codeunit 50100 "Install hack"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        erl: recordRef;
    //x: Record "Email Rate Limit";
    begin
        erl.open(8912);
        if erl.findfirst() then begin
            erl.field(5).value(10);
            erl.modify();
        end;
    end;
}


