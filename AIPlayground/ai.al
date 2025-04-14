Codeunit 50105 AI
{
    procedure Setup(Provider: Enum "AI Provider"; URL: Text; AccessKey: Text)
    begin
        CurrentProvider := Provider;
        _Key := AccessKey;
        _URL := URL;
        _temperature := 0.7;
        _top_p := 0.95;
        _maxtokens := 4000;
    end;

    procedure Temperature(temperature: Decimal)
    begin
        _temperature := temperature;
    end;

    procedure TopP(top_p: Decimal)
    begin
        _top_p := top_p;
    end;

    procedure MaxTokens(maxtokens: Integer)
    begin
        _maxtokens := maxtokens;
    end;

    procedure AddSystem(Msg: Text)
    begin
        _System.Add(Msg);
    end;

    procedure AddUser(Msg: Text)
    begin
        _User.Add(Msg);
    end;

    [TryFunction]
    procedure TryCall(var Result: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        Client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Content: HttpContent;
        Headers: HttpHeaders;
        ResponseTxt: Text;
        ResponseJson: JsonObject;
        Choices: JsonArray;
        Choice: JsonObject;
        T: JsonToken;

    begin
        Request.SetRequestUri(_URL);
        Request.Method('POST');
        Request.GetHeaders(Headers);
        case CurrentProvider of
            CurrentProvider::AzureOpenAI:
                if _Key <> '' then
                    Headers.Add('api-key', _Key);
            CurrentProvider::ChatGPTOpenAI:
                if _key <> '' then
                    Headers.Add('Authorization', 'bearer ' + _Key);
        end;
        Headers.Add('User-Agent', 'Business Central');
        Request.Content(BuildContent(BuildPayload()));
        Client.Timeout(300000);

        if Client.Send(Request, Response) then begin
            if Response.IsBlockedByEnvironment() then
                error('"Allow HttpClient Requests" is turned off for this extension in Extension Management');
            Response.Content().ReadAs(ResponseTxt);
            if Response.IsSuccessStatusCode() then begin
                ResponseJson.ReadFrom(ResponseTxt);
                if ResponseJson.Get('choices', T) then begin
                    Choices := T.AsArray();
                    if Choices.Get(0, T) then begin
                        Choice := T.AsObject();
                        if Choice.Get('message', T) then
                            if T.AsObject().Get('content', T) then begin
                                Result := T.AsValue().AsText();
                                _LastResult := Result;
                            end;

                    end else
                        error('Unexpected GPT result: %1', ResponseTxt);
                end else
                    error('Unexpected GPT result: %1', ResponseTxt);
            end else
                error('GPT HTTP Error: %1 (%2)', Response.HttpStatusCode, ResponseTxt);
        end else
            error('Http Error: %1', GetLastErrorText());
    end;

    Procedure BuildPayload(): JsonObject
    var
        SingleContent: JsonObject;
        Contents: JsonArray;
        Messages: JsonArray;
        MsgTxt: Text;
        Msg: JsonObject;
        ResponseFormat: JsonObject;
        Payload: JsonObject;
    begin
        foreach MsgTxt in _System do begin
            clear(SingleContent);
            SingleContent.Add('type', 'text');
            SingleContent.Add('text', MsgTxt);
            Contents.add(SingleContent);
        end;
        Msg.Add('content', Contents);
        Msg.Add('role', 'system');
        Messages.Add(Msg);

        Clear(Contents);
        foreach MsgTxt in _User do begin
            clear(SingleContent);
            SingleContent.Add('type', 'text');
            SingleContent.Add('text', MsgTxt);
            Contents.add(SingleContent);
        end;
        Clear(Msg);
        Msg.Add('content', Contents);
        Msg.Add('role', 'user');
        Messages.Add(Msg);

        case CurrentProvider of
            CurrentProvider::AzureOpenAI:
                begin
                    if _JsonObjectMode then begin
                        ResponseFormat.Add('type', 'json_object');
                        Payload.Add('response_format', ResponseFormat);
                    end;
                end;
            CurrentProvider::ChatGPTOpenAI:
                begin
                    if _Model <> '' then
                        payload.add('model', _model)
                    else
                        Payload.Add('model', 'gpt-4o-mini');
                end;
            CurrentProvider::LMStudio:
                begin
                    // Not supported yet
                end;
        end;

        Payload.Add('messages', Messages);
        Payload.Add('temperature', _temperature);
        Payload.Add('top_p', _top_p);
        Payload.Add('max_tokens', _maxtokens);
        Payload.Add('stream', false);

        exit(Payload);
    end;

    local procedure BuildContent(Payload: JsonObject): HttpContent
    var
        Content: HttpContent;
        Headers: HttpHeaders;
        TempBlob: Codeunit "Temp Blob";
        InS: InStream;
        OutS: OutStream;
    begin
        TempBlob.CreateOutStream(OutS, TextEncoding::UTF8);
        OutS.WriteText(format(Payload));
        TempBlob.CreateInStream(InS, TextEncoding::UTF8);
        Content.WriteFrom(InS);

        Content.GetHeaders(Headers);
        Headers.Remove('Content-Type');
        Headers.Add('Content-Type', 'application/json');

        exit(Content);
    end;

    procedure GetJson(): JsonToken
    var
        t: JsonToken;
        Result: Text;
        parts: List of [Text];
    begin
        _JsonObjectMode := true;
        if TryCall(Result) then begin
            if Result.Contains('```json') then begin
                parts := Result.split('```');
                t.ReadFrom(parts.get(2).Substring(5));
            end else
                t.ReadFrom(Result)
        end else
            error(GetLastErrorText);
        _JsonObjectMode := false;
        Exit(t);
    end;

    procedure GetText(): Text
    var
        Result: Text;
    begin
        _JsonObjectMode := false;
        if TryCall(Result) then
            exit(Result)
        else
            error(GetLastErrorText);
    end;

    procedure Model(UseModel: Text)
    begin
        _Model := UseModel;
    end;

    procedure JsonSchema(Schema: JsonObject)
    begin
        _JsonSchema := Schema;
    end;

    var
        _maxtokens: Integer;
        _top_p: Decimal;
        _temperature: Decimal;
        _JsonSchema: JsonObject;
        _JsonObjectMode: Boolean;
        _System: List of [Text];
        _User: List of [Text];
        _URL: Text;
        _Key: Text;
        _LastResult: Text;
        CurrentProvider: Enum "AI Provider";
        _Model: Text;
}

enum 50100 "AI Provider"
{
    value(0; AzureOpenAI)
    {
        Caption = 'Azure Open AI';
    }
    value(1; ChatGPTOpenAI)
    {
        Caption = 'ChatGPT Open AI';
    }
    value(10; LMStudio)
    {
        Caption = 'LM Studio';
    }
}