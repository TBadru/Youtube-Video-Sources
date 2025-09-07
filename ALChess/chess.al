codeunit 50100 "Chess Engine"
{
    // Chess piece representations
    var
        Empty: Integer;
        WPawn: Integer;
        WKnight: Integer;
        WBishop: Integer;
        WRook: Integer;
        WQueen: Integer;
        WKing: Integer;
        BPawn: Integer;
        BKnight: Integer;
        BBishop: Integer;
        BRook: Integer;
        BQueen: Integer;
        BKing: Integer;
        Board: array[8, 8] of Integer;
        WhiteToMove: Boolean;
        MaxDepth: Integer;

    trigger OnRun()
    begin
        InitializePieces();
        InitializeBoard();
        MaxDepth := 4;
    end;

    local procedure InitializePieces()
    begin
        Empty := 0;
        WPawn := 1;
        WKnight := 2;
        WBishop := 3;
        WRook := 4;
        WQueen := 5;
        WKing := 6;
        BPawn := -1;
        BKnight := -2;
        BBishop := -3;
        BRook := -4;
        BQueen := -5;
        BKing := -6;
    end;

    procedure InitializeBoard()
    var
        i: Integer;
        j: Integer;
    begin
        // Clear board
        for i := 1 to 8 do
            for j := 1 to 8 do
                Board[i, j] := Empty;

        // White pieces
        Board[1, 1] := WRook;
        Board[1, 2] := WKnight;
        Board[1, 3] := WBishop;
        Board[1, 4] := WQueen;
        Board[1, 5] := WKing;
        Board[1, 6] := WBishop;
        Board[1, 7] := WKnight;
        Board[1, 8] := WRook;
        for i := 1 to 8 do
            Board[2, i] := WPawn;

        // Black pieces
        Board[8, 1] := BRook;
        Board[8, 2] := BKnight;
        Board[8, 3] := BBishop;
        Board[8, 4] := BQueen;
        Board[8, 5] := BKing;
        Board[8, 6] := BBishop;
        Board[8, 7] := BKnight;
        Board[8, 8] := BRook;
        for i := 1 to 8 do
            Board[7, i] := BPawn;

        WhiteToMove := true;
    end;

    procedure GetBestMove(var FromRow: Integer; var FromCol: Integer; var ToRow: Integer; var ToCol: Integer)
    var
        BestScore: Integer;
        Score: Integer;
        i, j, k, l : Integer;
        TempPiece: Integer;
    begin
        if WhiteToMove then
            BestScore := -999999
        else
            BestScore := 999999;

        FromRow := 0;
        FromCol := 0;
        ToRow := 0;
        ToCol := 0;

        for i := 1 to 8 do
            for j := 1 to 8 do
                if (WhiteToMove and (Board[i, j] > 0)) or ((not WhiteToMove) and (Board[i, j] < 0)) then
                    for k := 1 to 8 do
                        for l := 1 to 8 do
                            if IsValidMove(i, j, k, l) then begin
                                TempPiece := Board[k, l];
                                Board[k, l] := Board[i, j];
                                Board[i, j] := Empty;
                                WhiteToMove := not WhiteToMove;

                                Score := Minimax(MaxDepth - 1, -999999, 999999, not WhiteToMove);

                                Board[i, j] := Board[k, l];
                                Board[k, l] := TempPiece;
                                WhiteToMove := not WhiteToMove;

                                if (WhiteToMove and (Score > BestScore)) or ((not WhiteToMove) and (Score < BestScore)) then begin
                                    BestScore := Score;
                                    FromRow := i;
                                    FromCol := j;
                                    ToRow := k;
                                    ToCol := l;
                                end;
                            end;
    end;

    local procedure Minimax(Depth: Integer; Alpha: Integer; Beta: Integer; MaximizingPlayer: Boolean): Integer
    var
        BestScore: Integer;
        Score: Integer;
        i, j, k, l : Integer;
        TempPiece: Integer;
    begin
        if Depth = 0 then
            exit(EvaluateBoard());

        if MaximizingPlayer then begin
            BestScore := -999999;
            for i := 1 to 8 do
                for j := 1 to 8 do
                    if Board[i, j] > 0 then
                        for k := 1 to 8 do
                            for l := 1 to 8 do
                                if IsValidMove(i, j, k, l) then begin
                                    TempPiece := Board[k, l];
                                    Board[k, l] := Board[i, j];
                                    Board[i, j] := Empty;

                                    Score := Minimax(Depth - 1, Alpha, Beta, false);

                                    Board[i, j] := Board[k, l];
                                    Board[k, l] := TempPiece;

                                    if Score > BestScore then
                                        BestScore := Score;
                                    if BestScore > Alpha then
                                        Alpha := BestScore;
                                    if Beta <= Alpha then
                                        exit(BestScore);
                                end;
            exit(BestScore);
        end else begin
            BestScore := 999999;
            for i := 1 to 8 do
                for j := 1 to 8 do
                    if Board[i, j] < 0 then
                        for k := 1 to 8 do
                            for l := 1 to 8 do
                                if IsValidMove(i, j, k, l) then begin
                                    TempPiece := Board[k, l];
                                    Board[k, l] := Board[i, j];
                                    Board[i, j] := Empty;

                                    Score := Minimax(Depth - 1, Alpha, Beta, true);

                                    Board[i, j] := Board[k, l];
                                    Board[k, l] := TempPiece;

                                    if Score < BestScore then
                                        BestScore := Score;
                                    if BestScore < Beta then
                                        Beta := BestScore;
                                    if Beta <= Alpha then
                                        exit(BestScore);
                                end;
            exit(BestScore);
        end;
    end;

    local procedure EvaluateBoard(): Integer
    var
        Score: Integer;
        i, j : Integer;
    begin
        Score := 0;
        for i := 1 to 8 do
            for j := 1 to 8 do
                Score += GetPieceValue(Board[i, j], i, j);
        exit(Score);
    end;

    local procedure GetPieceValue(Piece: Integer; Row: Integer; Col: Integer): Integer
    var
        Value: Integer;
        PositionBonus: Integer;
    begin
        Value := 0;
        PositionBonus := 0;

        // Center control bonus
        if (Row in [3, 4, 5, 6]) and (Col in [3, 4, 5, 6]) then
            PositionBonus := 10;
        if (Row in [4, 5]) and (Col in [4, 5]) then
            PositionBonus := 20;

        case Piece of
            WPawn:
                Value := 100 + PositionBonus + (Row - 1) * 5;
            WKnight:
                Value := 320 + PositionBonus;
            WBishop:
                Value := 330 + PositionBonus;
            WRook:
                Value := 500;
            WQueen:
                Value := 900 + PositionBonus;
            WKing:
                Value := 20000;
            BPawn:
                Value := -100 - PositionBonus - (8 - Row) * 5;
            BKnight:
                Value := -320 - PositionBonus;
            BBishop:
                Value := -330 - PositionBonus;
            BRook:
                Value := -500;
            BQueen:
                Value := -900 - PositionBonus;
            BKing:
                Value := -20000;
        end;
        exit(Value);
    end;

    procedure IsValidMove(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer): Boolean
    var
        Piece: Integer;
        Target: Integer;
    begin
        if (FromRow < 1) or (FromRow > 8) or (FromCol < 1) or (FromCol > 8) then
            exit(false);
        if (ToRow < 1) or (ToRow > 8) or (ToCol < 1) or (ToCol > 8) then
            exit(false);
        if (FromRow = ToRow) and (FromCol = ToCol) then
            exit(false);

        Piece := Board[FromRow, FromCol];
        Target := Board[ToRow, ToCol];

        if Piece = Empty then
            exit(false);

        // Can't capture own piece
        if (Piece > 0) and (Target > 0) then
            exit(false);
        if (Piece < 0) and (Target < 0) then
            exit(false);

        case Abs(Piece) of
            1: // Pawn
                exit(IsValidPawnMove(FromRow, FromCol, ToRow, ToCol, Piece > 0));
            2: // Knight
                exit(IsValidKnightMove(FromRow, FromCol, ToRow, ToCol));
            3: // Bishop
                exit(IsValidBishopMove(FromRow, FromCol, ToRow, ToCol));
            4: // Rook
                exit(IsValidRookMove(FromRow, FromCol, ToRow, ToCol));
            5: // Queen
                exit(IsValidQueenMove(FromRow, FromCol, ToRow, ToCol));
            6: // King
                exit(IsValidKingMove(FromRow, FromCol, ToRow, ToCol));
        end;
        exit(false);
    end;

    local procedure IsValidPawnMove(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer; IsWhite: Boolean): Boolean
    var
        Direction: Integer;
        StartRow: Integer;
    begin
        if IsWhite then begin
            Direction := 1;
            StartRow := 2;
        end else begin
            Direction := -1;
            StartRow := 7;
        end;

        // Forward move
        if FromCol = ToCol then begin
            if (ToRow = FromRow + Direction) and (Board[ToRow, ToCol] = Empty) then
                exit(true);
            if (FromRow = StartRow) and (ToRow = FromRow + 2 * Direction) and
               (Board[FromRow + Direction, FromCol] = Empty) and (Board[ToRow, ToCol] = Empty) then
                exit(true);
        end;

        // Capture
        if (Abs(FromCol - ToCol) = 1) and (ToRow = FromRow + Direction) then
            if (IsWhite and (Board[ToRow, ToCol] < 0)) or ((not IsWhite) and (Board[ToRow, ToCol] > 0)) then
                exit(true);

        exit(false);
    end;

    local procedure IsValidKnightMove(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer): Boolean
    var
        RowDiff: Integer;
        ColDiff: Integer;
    begin
        RowDiff := Abs(ToRow - FromRow);
        ColDiff := Abs(ToCol - FromCol);
        exit(((RowDiff = 2) and (ColDiff = 1)) or ((RowDiff = 1) and (ColDiff = 2)));
    end;

    local procedure IsValidBishopMove(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer): Boolean
    var
        RowDiff: Integer;
        ColDiff: Integer;
        RowDir: Integer;
        ColDir: Integer;
        i: Integer;
    begin
        RowDiff := Abs(ToRow - FromRow);
        ColDiff := Abs(ToCol - FromCol);

        if RowDiff <> ColDiff then
            exit(false);

        if ToRow > FromRow then RowDir := 1 else RowDir := -1;
        if ToCol > FromCol then ColDir := 1 else ColDir := -1;

        for i := 1 to RowDiff - 1 do
            if Board[FromRow + i * RowDir, FromCol + i * ColDir] <> Empty then
                exit(false);

        exit(true);
    end;

    local procedure IsValidRookMove(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer): Boolean
    var
        i: Integer;
        MinVal: Integer;
        MaxVal: Integer;
    begin
        if (FromRow <> ToRow) and (FromCol <> ToCol) then
            exit(false);

        if FromRow = ToRow then begin
            if FromCol < ToCol then begin
                MinVal := FromCol;
                MaxVal := ToCol;
            end else begin
                MinVal := ToCol;
                MaxVal := FromCol;
            end;
            for i := MinVal + 1 to MaxVal - 1 do
                if Board[FromRow, i] <> Empty then
                    exit(false);
        end else begin
            if FromRow < ToRow then begin
                MinVal := FromRow;
                MaxVal := ToRow;
            end else begin
                MinVal := ToRow;
                MaxVal := FromRow;
            end;
            for i := MinVal + 1 to MaxVal - 1 do
                if Board[i, FromCol] <> Empty then
                    exit(false);
        end;
        exit(true);
    end;

    local procedure IsValidQueenMove(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer): Boolean
    begin
        exit(IsValidRookMove(FromRow, FromCol, ToRow, ToCol) or IsValidBishopMove(FromRow, FromCol, ToRow, ToCol));
    end;

    local procedure IsValidKingMove(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer): Boolean
    begin
        exit((Abs(ToRow - FromRow) <= 1) and (Abs(ToCol - FromCol) <= 1));
    end;

    procedure MakeMove(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer): Boolean
    begin
        if not IsValidMove(FromRow, FromCol, ToRow, ToCol) then
            exit(false);

        Board[ToRow, ToCol] := Board[FromRow, FromCol];
        Board[FromRow, FromCol] := Empty;
        WhiteToMove := not WhiteToMove;
        exit(true);
    end;

    procedure GetPieceAt(Row: Integer; Col: Integer): Integer
    begin
        if (Row < 1) or (Row > 8) or (Col < 1) or (Col > 8) then
            exit(Empty);
        exit(Board[Row, Col]);
    end;

    procedure SetPieceAt(Row: Integer; Col: Integer; Piece: Integer)
    begin
        if (Row >= 1) and (Row <= 8) and (Col >= 1) and (Col <= 8) then
            Board[Row, Col] := Piece;
    end;

    procedure IsWhiteTurn(): Boolean
    begin
        exit(WhiteToMove);
    end;

    procedure SetSearchDepth(Depth: Integer)
    begin
        if Depth > 0 then
            MaxDepth := Depth;
    end;

    procedure GetBoardAsText(): Text
    var
        BoardText: Text;
        i, j : Integer;
        PieceChar: Text[1];
    begin
        BoardText := '';
        for i := 8 downto 1 do begin
            for j := 1 to 8 do begin
                case Board[i, j] of
                    Empty:
                        PieceChar := '.';
                    WPawn:
                        PieceChar := 'P';
                    WKnight:
                        PieceChar := 'N';
                    WBishop:
                        PieceChar := 'B';
                    WRook:
                        PieceChar := 'R';
                    WQueen:
                        PieceChar := 'Q';
                    WKing:
                        PieceChar := 'K';
                    BPawn:
                        PieceChar := 'p';
                    BKnight:
                        PieceChar := 'n';
                    BBishop:
                        PieceChar := 'b';
                    BRook:
                        PieceChar := 'r';
                    BQueen:
                        PieceChar := 'q';
                    BKing:
                        PieceChar := 'k';
                end;
                BoardText += PieceChar + ' ';
            end;
            if i > 1 then
                BoardText += '\';
        end;
        exit(BoardText);
    end;
}