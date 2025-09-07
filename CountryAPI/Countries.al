pageextension 50100 "Country Page" extends "Countries/Regions"
{
    actions
    {
        addlast(Processing)
        {
            action(UpdateList)
            {
                Caption = 'Update Country List';
                ApplicationArea = all;
                trigger OnAction()
                var
                    Client: HttpClient;
                    Response: HttpResponseMessage;
                    CountryArray: JsonArray;
                    CountryJson: JsonObject;
                    NameJson: JsonObject;
                    T: JsonToken;
                    ResponseTxt: Text;
                    CountryRec: Record "Country/Region";
                begin
                    Client.Get('https://restcountries.com/v3.1/all?fields=name,cca2,ccn3', Response);
                    if Response.IsSuccessStatusCode() then begin
                        Response.Content.ReadAs(ResponseTxt);
                        CountryArray.ReadFrom(ResponseTxt);
                        foreach T in CountryArray do begin
                            CountryJson := T.AsObject();
                            if not CountryRec.Get(CountryJson.GetText('cca2')) then begin
                                CountryRec.Init();
                                CountryRec.Code := CountryJson.GetText('cca2');
                                CountryRec.Insert(true);
                            end;
                            NameJson := CountryJson.GetObject('name');
                            CountryRec.Validate(Name, NameJson.GetText('common'));
                            CountryRec.Validate("ISO Code", CountryRec.Code);
                            CountryRec.Validate("ISO Numeric Code", CountryJson.GetText('ccn3'));
                            CountryRec.Modify(true);
                        end;
                    end else
                        error('API returned %1', Response.HttpStatusCode);
                end;
            }
        }
    }
}