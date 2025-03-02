controladdin WebAddIn
{
    StartupScript = 'WebAddIn/startup.js';
    Scripts = 'WebAddIn/script.js';
    HorizontalStretch = true;
    VerticalStretch = true;
    //RequestedHeight = 6000;

    event ImAmReady();
    procedure Render(html: Text);
}