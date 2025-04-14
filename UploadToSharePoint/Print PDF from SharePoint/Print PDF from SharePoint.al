report 50101 "Print PDF from SharePoint"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    DefaultLayout = Word;
    WordLayout = 'PrintPDF-Placeholder.docx';

    dataset
    {
        dataitem(SPFile; "SharePoint File EFQ")
        {
            column(Name; Name) { }
            column(ServerRelativeUrl; ServerRelativeUrl) { }
            trigger OnAfterGetRecord()
            var
                PrintPDF: Codeunit "Print PDF Support";
                InS: InStream;
            begin
                SP.GetTableMapping(Mapping, GlobalRef);
                SP.DownloadFile(Mapping, SPFile, InS);
            end;

            trigger OnPreDataItem()
            var
                Folder: Text;
            begin
                SP.GetAccessTokenAgain(Token);
                SP.StoreAccessToken(Token);
                SP.GetTableMapping(Mapping, GlobalRef.Number);
                Folder := SP.GetFolderForRecord(GlobalRef, true);

               if SP.GetFolderContentStepTwo(SP.GetFolderContentStepOne(Mapping, Folder), FolderContent) then begin

                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }
    }


    var
        Mapping: Record "Table Mapping EFQ";
        FolderContent: Record "SharePoint File EFQ" temporary;
        SP: Codeunit "SharePoint EFQ";
        GlobalRef: RecordRef;
        Token: Text;
}