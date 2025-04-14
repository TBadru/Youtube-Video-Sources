// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.HttpClientProblem;

using Microsoft.Sales.Customer;
using System.Utilities;

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        Client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Content: HttpContent;
        Headers: HttpHeaders;
        Data: Text;
    begin
        message('%1', format(false));
        Request.SetRequestUri('https://microsoft.com');
        Request.Method := 'POST';

        Data := '❤️';

        Content.WriteFrom(Data);
        Content.GetHeaders(Headers);
        Headers.Add('Content-Length', format(StrlenUTF8(Data)));
        message('strlen=%1 vs utf8=%2', strlen(Data), StrlenUTF8(Data));

        Request.Content := Content;

        if Client.Send(Request, Response) then
            message('You should not see the message, then Erik messed up!?')
        else
            error(GetLastErrorText());
    end;

    procedure StrlenUTF8(S: Text): Integer
    var
        TmpBlob: Codeunit "Temp Blob";
        OutS: OutStream;
    begin
        TmpBlob.CreateOutStream(OutS, TextEncoding::UTF8);
        OutS.WriteText(S);
        exit(TmpBlob.Length());
    end;
}