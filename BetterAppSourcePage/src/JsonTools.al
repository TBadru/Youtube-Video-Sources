codeunit 56100 "Json Tools"
{
    internal procedure Get(Obj: JsonObject; KeyTxt: Text): JsonObject
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then
            exit(t.AsObject())
        else
            error('%1 not found in %2', KeyTxt, format(Obj));
    end;

    procedure GetText(Obj: JsonObject; KeyTxt: Text): Text
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then begin
            if not t.AsValue().IsNull() then
                exit(t.AsValue().AsText());
        end else
            error('%1 not found in %2', KeyTxt, format(Obj));
    end;

    procedure GetDateTime(Obj: JsonObject; KeyTxt: Text): DateTime
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then begin
            if not t.AsValue().IsNull() then
                exit(t.AsValue().AsDateTime());
        end else
            error('%1 not found in %2', KeyTxt, format(Obj));
    end;

    internal procedure GetChildText(Obj: JsonObject; ChildElement: Text; FieldInChild: Text): Text
    begin
        exit(GetText(GetObj(Obj, ChildElement), FieldInChild));
    end;

    internal procedure GetChildText(Obj: JsonObject; ChildElement: Text; FieldInChild: Text; SilentFail: Boolean): Text
    var
        O: JsonObject;
    begin
        if Obj.Contains(ChildElement) then begin
            O := GetObj(Obj, ChildElement);
            if O.Contains(FieldInChild) then
                exit(GetText(O, FieldInChild));
        end;
    end;

    internal procedure GetChildInteger(Obj: JsonObject; ChildElement: Text; FieldInChild: Text): Integer
    begin
        exit(GetInteger(GetObj(Obj, ChildElement), FieldInChild));
    end;

    internal procedure GetTextOrDefault(Obj: JsonObject; KeyTxt: Text): Text
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then
            if not t.AsValue().IsNull() then
                exit(t.AsValue().AsText());
    end;

    internal procedure GetOption(Obj: JsonObject; KeyTxt: Text): Option
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then
            exit(t.AsValue().AsOption())
        else
            error('%1 not found in %2', KeyTxt, format(Obj));
    end;

    internal procedure GetValue(Obj: JsonObject; KeyTxt: Text): JsonValue
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then
            exit(t.AsValue())
        else
            error('Internal Error: %1 not found in %2', KeyTxt, format(Obj));
    end;

    internal procedure GetObj(Obj: JsonObject; KeyTxt: Text): JsonObject
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then
            exit(t.AsObject())
        else
            error('Internal Error: %1 not found in %2', KeyTxt, format(Obj));
    end;

    procedure GetArray(Obj: JsonObject; KeyTxt: Text): JsonArray
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then
            exit(t.AsArray())
        else
            error('Internal Error: %1 not found in %2', KeyTxt, format(Obj));
    end;

    procedure GetArrayMember(Obj: JsonObject; KeyTxt: Text; Index: Integer): JsonObject
    var
        t: JsonToken;
        t2: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then begin
            if t.AsArray().Get(Index, t2) then
                exit(t2.AsObject())
            else
                error('Internal Error: Index %1 not found in %2', Index, format(Obj));
        end else
            error('Internal Error: %1 not found in %2', KeyTxt, format(Obj));
    end;

    procedure GetBool(Obj: JsonObject; KeyTxt: Text): Boolean
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then
            exit(t.AsValue().AsBoolean())
        else
            error('Internal Error: %1 not found in %2', KeyTxt, format(Obj));
    end;

    procedure GetBoolOrDefault(Obj: JsonObject; KeyTxt: Text): Boolean
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then
            exit(t.AsValue().AsBoolean())
        else
            exit(false);
    end;

    procedure GetInteger(Obj: JsonObject; KeyTxt: Text): Integer
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then
            exit(t.AsValue().AsInteger())
        else
            error('Internal Error: %1 not found in %2', KeyTxt, format(Obj));
    end;

    procedure GetDecimal(Obj: JsonObject; KeyTxt: Text): Decimal
    var
        t: JsonToken;
    begin
        if Obj.Get(KeyTxt, T) then
            exit(t.AsValue().AsDecimal())
        else
            error('Internal Error: %1 not found in %2', KeyTxt, format(Obj));
    end;

    procedure Json2Rec(JO: JsonObject; Rec: Variant): Variant
    var
        Ref: RecordRef;
    begin
        Ref.GetTable(Rec);
        exit(Json2Rec(JO, Ref.Number()));
    end;

    procedure Json2Rec(JO: JsonObject; TableNo: Integer): Variant
    var
        Ref: RecordRef;
        FR: FieldRef;
        FieldHash: Dictionary of [Text, Integer];
        i: Integer;
        JsonKey: Text;
        T: JsonToken;
        JsonKeyValue: JsonValue;
        RecVar: Variant;
    begin
        Ref.OPEN(TableNo);
        for i := 1 to Ref.FieldCount() do begin
            FR := Ref.FieldIndex(i);
            FieldHash.Add(GetJsonFieldName(FR), FR.Number);
        end;
        Ref.Init();
        foreach JsonKey in JO.Keys() do begin
            if JO.Get(JsonKey, T) then begin
                if T.IsValue() then begin
                    JsonKeyValue := T.AsValue();
                    FR := Ref.Field(FieldHash.Get(JsonKey));
                    AssignValueToFieldRef(FR, JsonKeyValue);
                end;
            end;
        end;
        RecVar := Ref;
        exit(RecVar);
    end;

    procedure Rec2Json(Rec: Variant): JsonObject
    var
        Ref: RecordRef;
        Out: JsonObject;
        FRef: FieldRef;
        i: Integer;
    begin
        if not Rec.IsRecord then
            error('Parameter Rec is not a record');
        Ref.GetTable(Rec);
        for i := 1 to Ref.FieldCount() do begin
            FRef := Ref.FieldIndex(i);
            case FRef.Class of
                FRef.Class::Normal:
                    Out.Add(GetJsonFieldName(FRef), FieldRef2JsonValue(FRef));
                FRef.Class::FlowField:
                    begin
                        FRef.CalcField();
                        Out.Add(GetJsonFieldName(FRef), FieldRef2JsonValue(FRef));
                    end;
            end;
        end;
        exit(Out);
    end;

    local procedure FieldRef2JsonValue(FRef: FieldRef): JsonValue
    var
        V: JsonValue;
        D: Date;
        DT: DateTime;
        T: Time;
    begin
        case FRef.Type() of
            FieldType::Date:
                begin
                    D := FRef.Value;
                    V.SetValue(D);
                end;
            FieldType::Time:
                begin
                    T := FRef.Value;
                    V.SetValue(T);
                end;
            FieldType::DateTime:
                begin
                    DT := FRef.Value;
                    V.SetValue(DT);
                end;
            else
                V.SetValue(Format(FRef.Value, 0, 9));
        end;
        exit(v);
    end;

    local procedure GetJsonFieldName(FRef: FieldRef): Text
    var
        Name: Text;
        i: Integer;
    begin
        Name := FRef.Name();
        for i := 1 to Strlen(Name) do begin
            if Name[i] < '0' then
                Name[i] := '_';
        end;
        exit(Name.Replace('__', '_').TrimEnd('_').TrimStart('_'));
    end;

    local procedure AssignValueToFieldRef(var FR: FieldRef; JsonKeyValue: JsonValue)
    begin
        case FR.Type() of
            FieldType::Code,
            FieldType::Text:
                FR.Value := JsonKeyValue.AsText();
            FieldType::Integer:
                FR.Value := JsonKeyValue.AsInteger();
            FieldType::Date:
                FR.Value := JsonKeyValue.AsDate();
            else
                error('%1 is not a supported field type', FR.Type());
        end;
    end;
}