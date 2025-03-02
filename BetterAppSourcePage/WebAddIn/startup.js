var controlAddIn = document.getElementById('controlAddIn');
controlAddIn.innerHTML = '<div style="display: flex;justify-content: center;align-items: center;height: 50%; font-size: 30px; font-family: arial;">Loading ....</div>';

var heightindicator = window.parent.document.querySelector('div[class~="control-addin-form"]');
if (heightindicator != null) {
    console.log('frame height', heightindicator.offsetHeight);
    window.frameElement.style.height = (heightindicator.offsetHeight - 5).toString() + "px";
    window.frameElement.style.maxHeight = (heightindicator.offsetHeight - 5).toString() + "px";
}
else
    console.log('missing height indicator');

window.frameElement.style.overflowY = 'scroll';
window.frameElement.scrolling = true;

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ImAmReady', []);