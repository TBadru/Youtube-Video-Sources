codeunit 50100 "OOAL"
{
    procedure New(): Codeunit OOAL
    var
        Empty: JsonObject;
    begin
        exit(new(Empty));
    end;

    procedure New(Data: JsonObject): Codeunit OOAL
    var
        O: Codeunit OOAL;
    begin
        _Data := Data.Clone().AsObject();
    end;

    procedure Clone(var source: Codeunit OOAL): Codeunit OOAL
    var
        O: Codeunit OOAL;
    begin
        exit(New(source.Data()));
    end;

    procedure Data(): JsonObject
    begin
        exit(_Data);
    end;

    var
        _Data: JsonObject;

        enum ObjectType
    {

    }
}
