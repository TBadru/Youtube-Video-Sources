codeunit 56101 "AppSource Management"
{
    trigger OnRun()
    begin
        RefreshAppList();
    end;

    procedure BuildWebPageContent(Description: Text; ResourceList: List of [Text]; LinkList: List of [Text]; LogoUrl: Text): Text
    var
        HtmlBuilder: TextBuilder;
        Resource: Text;
        i: Integer;
    begin
        HtmlBuilder.AppendLine('<!DOCTYPE html>');
        HtmlBuilder.AppendLine('<html>');
        HtmlBuilder.AppendLine('<head>');
        HtmlBuilder.AppendLine('<style>');
        HtmlBuilder.AppendLine('button{');
        HtmlBuilder.AppendLine('    border: none;');
        HtmlBuilder.AppendLine('    cursor: pointer;');
        HtmlBuilder.AppendLine('    color: white;');
        HtmlBuilder.AppendLine('    background: none;');
        HtmlBuilder.AppendLine('    transition: all .3s ease-in-out;');
        HtmlBuilder.AppendLine('}');
        HtmlBuilder.AppendLine('.container {');
        HtmlBuilder.AppendLine('  width: 100%;');
        HtmlBuilder.AppendLine('  height: 170px;');
        HtmlBuilder.AppendLine('  display: flex;');
        HtmlBuilder.AppendLine('  justify-content: center;');
        HtmlBuilder.AppendLine('  align-items: top;');
        HtmlBuilder.AppendLine('  background-color: white;');
        HtmlBuilder.AppendLine('}');

        HtmlBuilder.AppendLine('.carousel-view {');
        HtmlBuilder.AppendLine('  display: flex;');
        HtmlBuilder.AppendLine('  justify-content: space-between;');
        HtmlBuilder.AppendLine('  align-items: top;');
        HtmlBuilder.AppendLine('  gap: 10px;');
        HtmlBuilder.AppendLine('  padding: 10px 0;');
        HtmlBuilder.AppendLine('  transition: all 0.25s ease-in;');
        HtmlBuilder.AppendLine('}');

        HtmlBuilder.AppendLine('.carousel-view .item-list {');
        HtmlBuilder.AppendLine('  max-width: 100%;');
        HtmlBuilder.AppendLine('  width: 70vw;');
        HtmlBuilder.AppendLine('  padding: 10px 10px;');
        HtmlBuilder.AppendLine('  display: flex;');
        HtmlBuilder.AppendLine('  gap: 48px;');
        HtmlBuilder.AppendLine('  scroll-behavior: smooth;');
        HtmlBuilder.AppendLine('  transition: all 0.25s ease-in;');
        HtmlBuilder.AppendLine('  -ms-overflow-style: none; ');
        HtmlBuilder.AppendLine('  scrollbar-width: none;');
        HtmlBuilder.AppendLine('  overflow: auto;');
        HtmlBuilder.AppendLine('  scroll-snap-type: x mandatory;');
        HtmlBuilder.AppendLine('}');
        HtmlBuilder.AppendLine('.item-list::-webkit-scrollbar {');
        HtmlBuilder.AppendLine('  display: none;');
        HtmlBuilder.AppendLine('}');
        HtmlBuilder.AppendLine('.prev-btn {');
        HtmlBuilder.AppendLine('  background = none;');
        HtmlBuilder.AppendLine('  cursor: pointer;');
        HtmlBuilder.AppendLine('}');
        HtmlBuilder.AppendLine('.next-btn {');
        HtmlBuilder.AppendLine('  cursor: pointer;');
        HtmlBuilder.AppendLine('}');
        HtmlBuilder.AppendLine('.item {');
        HtmlBuilder.AppendLine('  scroll-snap-align: center;');
        HtmlBuilder.AppendLine('  min-width: 213px;');
        HtmlBuilder.AppendLine('  height: 120px;');
        HtmlBuilder.AppendLine('  background-color: deeppink;');
        HtmlBuilder.AppendLine('  border-radius:8px;');
        HtmlBuilder.AppendLine('}');
        HtmlBuilder.AppendLine('</style>');
        HtmlBuilder.AppendLine('</head>');
        HtmlBuilder.AppendLine('<body>');
        HtmlBuilder.AppendLine('  <div style=''font-size: 14px; font-family: "Segoe UI", Segoe, device-segoe, Tahoma, Helvetica, Arial, sans-serif !important;font-weight: normal !important;font-style: normal !important;text-transform: none !important;''>');
        HtmlBuilder.AppendLine('    <img src="' + LogoUrl + '" style="float: right; margin-right: 15px;">');
        HtmlBuilder.AppendLine(Description);
        HtmlBuilder.AppendLine('  </div>');
        HtmlBuilder.AppendLine('  <div class="container">');
        HtmlBuilder.AppendLine('  <div class="carousel-view">');
        HtmlBuilder.AppendLine('    <button id="prev-btn" class="prev-btn">');
        HtmlBuilder.AppendLine('     <svg viewBox="0 0 512 512" width="20" title="chevron-circle-left">');
        HtmlBuilder.AppendLine('  <path d="M256 504C119 504 8 393 8 256S119 8 256 8s248 111 248 248-111 248-248 248zM142.1 273l135.5 135.5c9.4 9.4 24.6 9.4 33.9 0l17-17c9.4-9.4 9.4-24.6 0-33.9L226.9 256l101.6-101.6c9.4-9.4 9.4-24.6 0-33.9l-17-17c-9.4-9.4-24.6-9.4-33.9 0L142.1 239c-9.4 9.4-9.4 24.6 0 34z" />');
        HtmlBuilder.AppendLine('</svg>');
        HtmlBuilder.AppendLine('    </button>');
        HtmlBuilder.AppendLine('    <div id="item-list" class="item-list">');
        for i := 1 to ResourceList.Count() do begin
            HtmlBuilder.AppendLine('          <img id="item" class="item" src="' + ResourceList.Get(i) + '" onclick="window.open(''' + LinkList.Get(i) + ''');"/>');
        end;
        HtmlBuilder.AppendLine('        </div>');
        HtmlBuilder.AppendLine('    <button id="next-btn" class="next-btn">');
        HtmlBuilder.AppendLine('          <svg viewBox="0 0 512 512" width="20" title="chevron-circle-right">');
        HtmlBuilder.AppendLine('  <path d="M256 8c137 0 248 111 248 248S393 504 256 504 8 393 8 256 119 8 256 8zm113.9 231L234.4 103.5c-9.4-9.4-24.6-9.4-33.9 0l-17 17c-9.4 9.4-9.4 24.6 0 33.9L285.1 256 183.5 357.6c-9.4 9.4-9.4 24.6 0 33.9l17 17c9.4 9.4 24.6 9.4 33.9 0L369.9 273c9.4-9.4 9.4-24.6 0-34z" />');
        HtmlBuilder.AppendLine('</svg>');
        HtmlBuilder.AppendLine('        </button>');
        HtmlBuilder.AppendLine('    </div>');
        HtmlBuilder.AppendLine('</div>');
        HtmlBuilder.AppendLine('<script>');
        HtmlBuilder.AppendLine('const prev = document.getElementById(''prev-btn'')');
        HtmlBuilder.AppendLine('const next = document.getElementById(''next-btn'')');
        HtmlBuilder.AppendLine('const list = document.getElementById(''item-list'')');

        HtmlBuilder.AppendLine('const itemWidth = 150');
        HtmlBuilder.AppendLine('const padding = 10');

        HtmlBuilder.AppendLine('prev.addEventListener(''click'',()=>{');
        HtmlBuilder.AppendLine('  list.scrollLeft -= itemWidth + padding');
        HtmlBuilder.AppendLine('})');

        HtmlBuilder.AppendLine('next.addEventListener(''click'',()=>{');
        HtmlBuilder.AppendLine('  list.scrollLeft += itemWidth + padding');
        HtmlBuilder.AppendLine('})');
        HtmlBuilder.AppendLine('var links = document.links;');
        HtmlBuilder.AppendLine('for (var i = 0; i < links.length; i++) {');
        HtmlBuilder.AppendLine('     links[i].target = "_blank";');
        HtmlBuilder.AppendLine('}');
        HtmlBuilder.AppendLine('</script>');
        HtmlBuilder.AppendLine('</body>');
        HtmlBuilder.AppendLine('</html>');
        exit(HtmlBuilder.ToText());
    end;

    internal procedure RefreshInfo(var AppRec: Record AppSourceApp)
    var
        HttpClient: HttpClient;
        Response: HttpResponseMessage;
        Html: Text;
        JsonText: Text;
        AppSourceJson: JsonObject;
        Apps: JsonObject;
        T: JsonToken;
        DataList: JsonArray;
        App: JsonObject;
        Json: Codeunit "Json Tools";
        IdParts: List of [Text];
        detailInformation: JsonObject;
        Images: JsonArray;
        Image: JsonObject;
        OutS: OutStream;
        T2: JsonToken;
        i: Integer;
        ResourceList: List of [Text];
        LinkList: List of [Text];
        ReviewsTxt: Text;
        Reviews: JsonArray;
        Review: JsonObject;
        AppReviewRec: Record "App Review";
        CustomerInfo: JsonObject;
    begin
        if HttpClient.Get('https://appsource.microsoft.com/en-us/product/dynamics-365-business-central/' + AppRec.EntityId, Response) then begin
            if Response.IsSuccessStatusCode() then begin
                Response.Content.ReadAs(Html);
                JsonText := Html.Substring(Html.IndexOf('window.__INITIAL_STATE__ = ') + 27);
                JsonText := JsonText.Substring(1, JsonText.IndexOf('</script>'));
                AppSourceJson.ReadFrom(JsonText);
                AppSourceJson.Get('apps', T);
                Apps := T.AsObject();
                Apps.Get('dataList', T);
                DataList := T.AsArray();
                if DataList.Count() = 0 then
                    exit;

                foreach T in dataList do begin
                    App := T.AsObject();
                    IdParts := Json.GetText(App, 'entityId').Split('|');

                    if Json.GetText(App, 'entityId') = AppRec.EntityId then begin
                        detailInformation := Json.GetObj(App, 'detailInformation');
                        AppRec.Description.CreateOutStream(OutS);
                        OutS.Write(AddStyle(Json.GetText(detailInformation, 'Description')));
                        Images := Json.GetArray(detailInformation, 'Images');
                        foreach T2 in Images do begin
                            Image := T2.AsObject();
                            ResourceList.Add(Json.GetText(Image, 'ImageUri'));
                            LinkList.Add(Json.GetText(Image, 'ImageUri'));
                        end;

                        Images := Json.GetArray(detailInformation, 'DemoVideos');
                        foreach T2 in Images do begin
                            Image := T2.AsObject();
                            ResourceList.Add(Json.GetText(Image, 'ThumbnailURL'));
                            LinkList.Add(Json.GetText(Image, 'VideoLink'));
                        end;
                        AppRec.ImageViewer.CreateOutStream(OutS);
                        AppRec.AppVersion := Json.GetText(detailInformation, 'AppVersion');
                        AppRec.ReleaseDate := Json.GetDateTime(detailInformation, 'ReleaseDate');
                        AppRec.LargeIcon := Json.GetText(detailInformation, 'LargeIconUri');
                        AppRec.HelpLink := Json.GetText(detailInformation, 'HelpLink');
                        AppRec.SupportLink := Json.GetText(detailInformation, 'SupportLink');
                        AppRec.Modify();

                        OUtS.Write(BuildWebPageContent(Json.GetText(detailInformation, 'Description'), ResourceList, LinkList, AppRec.LargeIcon));
                    end;
                end;
            end else
                exit;
        end;
        if HttpClient.Get('https://main.prod.marketplacereviews.azure.com/reviews?api-version=2021-03-01&filter_empty_titles=true&offer_Id=' + AppRec.EntityId, Response) then begin
            if Response.IsSuccessStatusCode() then begin
                Response.Content.ReadAs(ReviewsTxt);
                Reviews.ReadFrom(ReviewsTxt);
                AppRec.Star1 := 0;
                AppRec.Star2 := 0;
                AppRec.Star3 := 0;
                AppRec.Star4 := 0;
                AppRec.Star5 := 0;
                foreach T in Reviews do begin
                    Review := T.AsObject();

                    if not AppReviewRec.Get(AppRec.AppID, Json.GetText(Review, 'id')) then begin
                        AppReviewRec.Init();
                        AppReviewRec.AppId := AppRec.AppID;
                        AppReviewRec."Review Guid" := Json.GetText(Review, 'id');
                        AppReviewRec.Insert();
                    end;
                    CustomerInfo := Json.GetObj(Review, 'customer_info');
                    AppReviewRec.Name := Json.GetText(CustomerInfo, 'name');
                    AppReviewRec.Date := Json.GetDateTime(Review, 'created_at').Date;
                    AppReviewRec.Rating := ShowRating(Json.GetInteger(Review, 'rating'));
                    AppReviewRec.Title := Json.GetText(Review, 'title');
                    AppReviewRec.Text.CreateOutStream(OutS);
                    OutS.Write(Json.GetText(Review, 'content'));
                    AppReviewRec.Modify();
                    case Json.GetInteger(Review, 'rating') of
                        1:
                            AppRec.Star1 += 1;
                        2:
                            AppRec.Star2 += 1;
                        3:
                            AppRec.Star3 += 1;
                        4:
                            AppRec.Star4 += 1;
                        5:
                            AppRec.Star5 += 1;
                        else
                            error('!!!');
                    end;
                end;
                AppRec.Modify();
            end;
        end;
    end;

    local procedure ShowRating(Rating: Decimal): Text
    var
        Output: Text;
        i: Integer;
    begin
        if Rating = 0 then
            exit('');
        for i := 1 to round(Rating, 1) do
            Output += '★';
        exit(Output);
    end;

    local procedure ShowRating(Rec: Record AppSourceApp): Text
    var
        Output: Text;
        i: Integer;
    begin
        if Rec.AverageRating = 0 then
            exit('');
        for i := 1 to round(Rec.AverageRating, 1) do
            Output += '⭐';
        exit(Output);
    end;

    procedure AddStyle(html: Text): Text
    begin

        exit('<div style=''font-size: 14px; font-family: "Segoe UI", Segoe, device-segoe, Tahoma, Helvetica, Arial, sans-serif !important;font-weight: normal !important;font-style: normal !important;text-transform: none !important;''>' + html + '</div>');
    end;

    internal procedure RefreshAppList()
    var
        HttpClient: HttpClient;
        Response: HttpResponseMessage;
        Html: Text;
        JsonText: Text;
        AppSourceJson: JsonObject;
        Apps: JsonObject;
        T: JsonToken;
        DataList: JsonArray;
        App: JsonObject;
        Json: Codeunit "Json Tools";
        AppRec: Record AppSourceApp;
        IdParts: List of [Text];
        PageNo: Integer;
        Window: Dialog;
        InS: InStream;
    begin
        if GuiAllowed() then
            Window.Open('Reading from AppSource #1#######');
        PageNo := 1;
        while HttpClient.Get('https://appsource.microsoft.com/en-us/marketplace/apps?product=dynamics-365-business-central&page=' + format(PageNo), Response) do begin
            if GuiAllowed() then
                Window.Update(1, PageNo);
            if Response.IsSuccessStatusCode() then begin
                Response.Content.ReadAs(Html);
                JsonText := Html.Substring(Html.IndexOf('window.__INITIAL_STATE__ = ') + 27);
                JsonText := JsonText.Substring(1, JsonText.IndexOf('</script>'));
                AppSourceJson.ReadFrom(JsonText);
                AppSourceJson.Get('apps', T);
                Apps := T.AsObject();
                Apps.Get('dataList', T);
                DataList := T.AsArray();
                if DataList.Count() = 0 then
                    exit;

                foreach T in dataList do begin
                    App := T.AsObject();
                    IdParts := Json.GetText(App, 'entityId').Split('|');

                    if not AppRec.Get(IdParts.Get(3).Substring(8)) then begin
                        AppRec.Init();
                        AppRec.AppID := IdParts.Get(3).Substring(8);
                        AppRec.Insert();
                    end;

                    AppRec.EntityId := Json.GetText(App, 'entityId');
                    AppRec.Title := Json.GetText(App, 'title');
                    AppRec.shortDescription := Json.GetText(App, 'shortDescription');
                    AppRec.Publisher := Json.GetText(App, 'publisher');
                    AppRec.AverageRating := Json.GetDecimal(App, 'AverageRating');
                    AppRec.Rating := ShowRating(AppRec.AverageRating);
                    AppRec.Popularity := Json.GetDecimal(App, 'popularity');

                    if not AppRec.Icon.HasValue() then
                        If HttpClient.Get(Json.GetText(App, 'iconURL'), Response) then begin
                            Response.Content.ReadAs(InS);
                            AppRec.Icon.ImportStream(InS, AppRec.AppID);
                        end;

                    AppRec.Modify();
                end;
                PageNo += 1;
                Commit();
            end else
                exit;
        end;
    end;
}