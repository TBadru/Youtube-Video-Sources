
function Render(html) {
    try {
        document.open();
        document.write(html);
        document.close();
        //controlAddIn.innerHTML = html;
        window.addEventListener('resize', function (event) {
            var heightindicator = window.parent.document.querySelector('div[class~="control-addin-form"]');
            window.frameElement.style.height = (heightindicator.offsetHeight - 5).toString() + "px";
            window.frameElement.style.maxHeight = (heightindicator.offsetHeight - 5).toString() + "px";
            console.log('frame height', heightindicator.offsetHeight);
        }, true);
    
    }
    catch (e) {
        console.log(e);
    }
}