page 50100 "Chess"
{
    Caption = 'AL Chess';
    ApplicationArea = all;
    layout
    {
        area(Content)
        {
            grid(g)
            {
                // usercontrol(board; ChessBoard)
                // {
                //     trigger ControlReady()
                //     begin
                //         CurrPage.board.DrawBoard();
                //     end;

                //     trigger MakeMove(fromRow: Integer; fromCol: Integer; toRow: Integer; toCol: Integer)
                //     begin
                //         if ChessEngine.MakeMove(FromJS(fromRow), fromCol + 1, FromJS(toRow), toCol + 1) then begin
                //             CurrPage.board.RecordMove(fromRow, fromCol, toRow, toCol);
                //             BoardLayout := ChessEngine.GetBoardAsText();
                //         end else
                //             error('Not a valid move');
                //     end;
                // }
                usercontrol(board; ChessBoardControl)
                {
                    trigger OnPieceMoved(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer)
                    begin
                        if ChessEngine.MakeMove(fromRow, fromCol, toRow, toCol) then begin
                            CurrPage.board.MovePiece(fromRow, fromCol, toRow, toCol);
                            BoardLayout := ChessEngine.GetBoardAsText();
                        end else
                            error('Not a valid move');
                    end;
                }
                group(g2)
                {
                    ShowCaption = false;
                    field(BoardLayout; BoardLayout)
                    {
                        MultiLine = true;
                        ShowCaption = false;
                        Editable = false;
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(test)
            {
                Caption = 'Computer Move';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    FromRow, FromCol, ToRow, ToCol : Integer;
                    FromColTxt: Text[1];
                    ToColTxt: Text[2];
                begin
                    ChessEngine.GetBestMove(FromRow, FromCol, ToRow, ToCol);
                    // ChessEngine.GetBoard(BoardLayout);
                    // exit;
                    if ChessEngine.MakeMove(FromRow, FromCol, ToRow, ToCol) then begin
                        CurrPage.board.movePiece(FromRow, fromCol, ToRow, ToCol);
                        BoardLayout := ChessEngine.GetBoardAsText();
                    end else begin
                        FromColTxt[1] := FromCol + 64;
                        ToColTxt[1] := ToCol + 64;
                        error('Not valid %1%2 to %3%4', FromColTxt, FromRow, ToColTxt, ToRow);
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        ChessEngine.Run();  // Initialize
        ChessEngine.InitializeBoard();  // Set up starting position       ChessEngine.GetBoard(BoardLayout);
        BoardLayout := ChessEngine.GetBoardAsText();

    end;

    procedure FromJS(row: Integer): Integer
    begin
        case row of
            0:
                exit(8);
            1:
                exit(7);
            2:
                exit(6);
            3:
                exit(5);
            4:
                exit(4);
            5:
                exit(3);
            6:
                exit(2);
            7:
                exit(1);
        end;
    end;

    procedure ToJS(row: Integer): Integer
    begin
        case row of
            8:
                exit(0);
            7:
                exit(1);
            6:
                exit(2);
            5:
                exit(3);
            4:
                exit(4);
            3:
                exit(5);
            2:
                exit(6);
            1:
                exit(7);
        end;
    end;

    var
        ChessEngine: Codeunit "Chess Engine";
        BoardLayout: Text;
}