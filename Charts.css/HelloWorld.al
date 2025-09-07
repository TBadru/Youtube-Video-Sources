page 50100 "Chart.css Test"
{
    PageType = UserControlHost;
    ApplicationArea = all;
    layout
    {
        area(Content)
        {
            usercontrol(chart; chartcss)
            {
                trigger ControlReady()
                var
                    HtmlBuilder: TextBuilder;
                    Customer: Record Customer;
                begin
                    HtmlBuilder.AppendLine('<table class="charts-css column">');
                    HtmlBuilder.AppendLine('    <thead>');
                    HtmlBuilder.AppendLine('    </thead>');
                    HtmlBuilder.AppendLine('    <tbody>');
                    Customer.Setrange("No.", '10000', '50000');
                    Customer.SetAutoCalcFields("Sales (LCY)");
                    if Customer.FindSet() then
                        repeat
                            HtmlBuilder.AppendLine('<tr>');
                            HtmlBuilder.AppendLine('<td style="--size: ' + Customer."Sales (LCY)".ToText() + '">' + Customer."Sales (LCY)".ToText() + '</td>');
                            HtmlBuilder.AppendLine('</tr>');
                        until Customer.Next() = 0;
                    HtmlBuilder.AppendLine('    </tbody>');
                    HtmlBuilder.AppendLine('</table>');
                    CurrPage.chart.Render(HtmlBuilder.ToText());
                    //                     CurrPage.chart.Render(
                    // @'<div id="my-chart">
                    //     <table class="charts-css bar show-primary-axis show-data-axes">
                    //     <caption> 2016 Summer Olympics Medal Table </caption>
                    //     <thead>
                    //         <tr>
                    //             <th scope="col"> Country </th>
                    //             <th scope="col"> Gold </th>
                    //             <th scope="col"> Silver </th>
                    //             <th scope="col"> Bronze </th>
                    //         </tr>
                    //     </thead>
                    //     <tbody>
                    //         <tr>
                    //             <th scope="row"> USA </th>
                    //             <td style="--size: 0.46"> 46 </td>
                    //             <td style="--size: 0.37"> 37 </td>
                    //             <td style="--size: 0.38"> 38 </td>
                    //         </tr>
                    //         <tr>
                    //             <th scope="row"> GBR </th>
                    //             <td style="--size: 0.27"> 27 </td>
                    //             <td style="--size: 0.23"> 23 </td>
                    //             <td style="--size: 0.17"> 17 </td>
                    //         </tr>
                    //         <tr>
                    //             <th scope="row"> CHN </th>
                    //             <td style="--size: 0.26"> 26 </td>
                    //             <td style="--size: 0.18"> 18 </td>
                    //             <td style="--size: 0.26"> 26 </td>
                    //         </tr>
                    //     </tbody>
                    //     </table>
                    // </div>
                    // ');
                end;
            }
        }
    }
}
