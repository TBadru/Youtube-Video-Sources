controladdin ChessBoard
{
    RequestedWidth = 500;
    MaximumWidth = 500;
    MinimumWidth = 500;
    RequestedHeight = 570;
    MaximumHeight = 570;
    MinimumHeight = 570;
    Scripts = 'chess.js';
    StartupScript = 'startup.js';
    StyleSheets = 'style.css';
    procedure DrawBoard();
    event MakeMove(fromRow: Integer; fromCol: Integer; toRow: Integer; toCol: Integer);
    procedure RecordMove(fromRow: Integer; fromCol: Integer; toRow: Integer; toCol: Integer);
    event ControlReady();
}