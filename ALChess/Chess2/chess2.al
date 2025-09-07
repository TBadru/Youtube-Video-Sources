controladdin ChessBoardControl
{
    /// <summary>
    /// Interactive Chess Board Control for Business Central
    /// </summary>

    // Resource files
    Scripts = 'Chess2/ChessBoard.js';
    StyleSheets = 'Chess2/ChessBoard.css';

    // Start script that initializes the control
    StartupScript = 'Chess2/startup.js';

    // Control properties
    HorizontalStretch = true;
    VerticalStretch = true;
    MinimumWidth = 550;
    MinimumHeight = 550;
    RequestedWidth = 550;
    RequestedHeight = 550;

    /// <summary>
    /// Event triggered when a piece is moved on the board by the user
    /// All coordinates are 1-based (A1 = 1,1 and H8 = 8,8)
    /// </summary>
    /// <param name="FromRow">Source row (1-8)</param>
    /// <param name="FromCol">Source column (1-8)</param>
    /// <param name="ToRow">Destination row (1-8)</param>
    /// <param name="ToCol">Destination column (1-8)</param>
    event OnPieceMoved(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer);

    /// <summary>
    /// Event triggered when the board is reset
    /// </summary>
    event OnBoardReset();

    /// <summary>
    /// Move a piece on the board programmatically (e.g., for computer moves)
    /// All coordinates are 1-based (A1 = 1,1 and H8 = 8,8)
    /// </summary>
    /// <param name="FromRow">Source row (1-8)</param>
    /// <param name="FromCol">Source column (1-8)</param>
    /// <param name="ToRow">Destination row (1-8)</param>
    /// <param name="ToCol">Destination column (1-8)</param>
    procedure movePiece(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer);
}