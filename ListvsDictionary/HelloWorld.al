// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.ListvsDictionary;

using Microsoft.Sales.Customer;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        //List: List of [Text];

        Dict: Dictionary of [Code[20], Text];
    //Hash: HashTable of [Code[20]];
    // Dict: JsonObject;
    // List: JsonArray;
    begin


        Dict.Add('C0454', 'Data1');
        Dict.Add('10000', 'Data2');
        Dict.Add('ABC343', 'Data3');
        Dict.Add('JJJFR', 'Data4');
        Dict.Add('YOUTUBE', 'Data5');

        message(Dict.Get('YOUTUBE'));



        // List.Add('Data1');
        // List.Add('Data2');
        // List.Add('Data3');
        // List.Add('Data4');
        // List.Add('Data5');

        // Message(List.Get(1));
        // List.RemoveAt(1);
        // List.Add('Data6');
        // Message(List.Get(1));



    end;
}