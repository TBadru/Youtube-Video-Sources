page 50100 thistest
{
    trigger OnOpenPage()
    var
        Verify: Codeunit "Verify Test";
    begin
        //Verify.VerifyPage(this);
        this.CurrPage.Update();
        this.Update();
        //this.CurrPage.
    end;
}
report 50100 thisreport
{
    trigger OnInitReport()
    var
        Verify: Codeunit "Verify Test";
    begin
        Verify.VerifyReport(this);
    end;
}

xmlport 50100 xmlthis
{
    schema
    {
        textelement("data-set-c_Localidad")
        {
            tableelement("SAT Locality"; "SAT Locality")
            {
                XmlName = 'Localidad';
                fieldelement(Code; "SAT Locality".Code)
                {
                }
                fieldelement(State; "SAT Locality".State)
                {
                }
                fieldelement(Descripcion; "SAT Locality".Description)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    this.break();
                end;
            }
        }
    }
    trigger OnInitXmlPort()
    var
        Verify: Codeunit "Verify Test";
    begin
        this.currXMLport.Break();
        Verify.VerifyXmlport(this);
    end;

}

codeunit 50100 test
{
    trigger OnRun()
    var
        Verify: Codeunit "Verify Test";
    begin
        Verify.Verify(this);
    end;
}

codeunit 50101 "Verify Test"
{
    procedure Verify(test: Codeunit Test)
    begin

    end;

    procedure VerifyPage(p: Page thistest)
    begin

    end;

    procedure VerifyReport(r: Report thisreport)
    begin

    end;

    procedure VerifyXmlport(p: XmlPort xmlthis)
    begin

    end;
}