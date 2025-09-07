// ChessBoard.js - Business Central Chess Board ControlAddin
// Main JavaScript file for the chess board control

var ChessBoardControl = (function() {
    'use strict';
    
    var board = [];
    var selectedSquare = null;
    var currentTurn = 'white';
    var lastMove = null;
    var container = null;
    
    var pieces = {
        'K': '♔', 'Q': '♕', 'R': '♖', 'B': '♗', 'N': '♘', 'P': '♙',
        'k': '♚', 'q': '♛', 'r': '♜', 'b': '♝', 'n': '♞', 'p': '♟'
    };
    
    function setupInitialPosition() {
        // Initialize empty board
        board = Array(8).fill(null).map(function() { 
            return Array(8).fill(null); 
        });
        
        // Set up initial chess position
        // White pieces (row 1 and 2 - array indices 0 and 1)
        board[0] = ['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R'];  // Row 1
        board[1] = ['P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'];  // Row 2
        
        // Black pieces (row 7 and 8 - array indices 6 and 7)
        board[6] = ['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'];  // Row 7
        board[7] = ['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'];  // Row 8
    }
    
    function createBoard() {
        container.innerHTML = '';
        
        // Create main chess container
        var chessContainer = document.createElement('div');
        chessContainer.className = 'chess-container';
        
        // Create board element
        var boardElement = document.createElement('div');
        boardElement.className = 'chess-board';
        boardElement.id = 'chessBoard';
        
        // Add rank labels (8 to 1) and squares
        for (var rank = 8; rank >= 1; rank--) {
            // Add rank label
            var rankLabel = document.createElement('div');
            rankLabel.className = 'rank-label';
            rankLabel.textContent = rank;
            boardElement.appendChild(rankLabel);
            
            // Add squares for this rank
            for (var file = 0; file < 8; file++) {
                var square = document.createElement('div');
                var row = rank - 1;  // rank 8 = row 7, rank 1 = row 0
                var col = file;
                
                square.className = 'square';
                square.className += (row + col) % 2 === 0 ? ' light' : ' dark';
                square.dataset.row = row;
                square.dataset.col = col;
                square.id = 'square-' + row + '-' + col;
                
                boardElement.appendChild(square);
            }
        }
        
        // Add corner space
        var corner = document.createElement('div');
        corner.className = 'corner';
        boardElement.appendChild(corner);
        
        // Add file labels (a to h)
        for (var file = 0; file < 8; file++) {
            var fileLabel = document.createElement('div');
            fileLabel.className = 'file-label';
            fileLabel.textContent = String.fromCharCode(97 + file);
            boardElement.appendChild(fileLabel);
        }
        
        chessContainer.appendChild(boardElement);
        
        // Add turn indicator
        var turnIndicator = document.createElement('div');
        turnIndicator.className = 'turn-indicator';
        turnIndicator.id = 'turnIndicator';
        turnIndicator.textContent = 'White to move';
        chessContainer.appendChild(turnIndicator);
        
        // Add controls
        var controls = document.createElement('div');
        controls.className = 'controls';
        
        var resetButton = document.createElement('button');
        resetButton.className = 'btn';
        resetButton.textContent = 'Reset Board';
        resetButton.onclick = reset;
        controls.appendChild(resetButton);
        
        chessContainer.appendChild(controls);
        container.appendChild(chessContainer);
        
        // Attach event listeners
        boardElement.addEventListener('click', handleBoardClick);
    }
    
    function render() {
        for (var row = 0; row < 8; row++) {
            for (var col = 0; col < 8; col++) {
                var square = document.getElementById('square-' + row + '-' + col);
                if (square) {
                    // Clear square
                    square.innerHTML = '';
                    square.className = 'square';
                    square.className += (row + col) % 2 === 0 ? ' light' : ' dark';
                    
                    // Add piece if present
                    var piece = board[row][col];
                    if (piece) {
                        var pieceElement = document.createElement('span');
                        pieceElement.className = 'piece';
                        pieceElement.textContent = pieces[piece];
                        square.appendChild(pieceElement);
                    }
                    
                    // Highlight last move
                    if (lastMove) {
                        if ((lastMove.fromRow === row && lastMove.fromCol === col) ||
                            (lastMove.toRow === row && lastMove.toCol === col)) {
                            square.classList.add('last-move');
                        }
                    }
                }
            }
        }
    }
    
    function handleBoardClick(event) {
        var square = event.target.closest('.square');
        if (!square) return;
        
        var row = parseInt(square.dataset.row);
        var col = parseInt(square.dataset.col);
        
        if (selectedSquare) {
            // Try to make a move
            if (isValidMoveBasic(selectedSquare.row, selectedSquare.col, row, col)) {
                makeMove(selectedSquare.row, selectedSquare.col, row, col);
            }
            // Clear selection
            clearHighlights();
            selectedSquare = null;
        } else {
            // Select a piece
            var piece = board[row][col];
            if (piece && isPieceCurrentPlayer(piece)) {
                selectedSquare = { row: row, col: col };
                highlightSquare(row, col);
                showValidMoves(row, col);
            }
        }
    }
    
    function clearHighlights() {
        var squares = document.querySelectorAll('.square');
        squares.forEach(function(sq) {
            sq.classList.remove('selected', 'valid-move');
        });
    }
    
    function highlightSquare(row, col) {
        var square = document.getElementById('square-' + row + '-' + col);
        if (square) {
            square.classList.add('selected');
        }
    }
    
    function showValidMoves(fromRow, fromCol) {
        for (var row = 0; row < 8; row++) {
            for (var col = 0; col < 8; col++) {
                if (isValidMoveBasic(fromRow, fromCol, row, col)) {
                    var square = document.getElementById('square-' + row + '-' + col);
                    if (square) {
                        square.classList.add('valid-move');
                    }
                }
            }
        }
    }
    
    function isPieceCurrentPlayer(piece) {
        if (currentTurn === 'white') {
            return piece === piece.toUpperCase();
        } else {
            return piece === piece.toLowerCase();
        }
    }
    
    function isValidMoveBasic(fromRow, fromCol, toRow, toCol) {
        // Basic validation - check if target square is empty or has opponent piece
        var piece = board[fromRow][fromCol];
        var target = board[toRow][toCol];
        
        if (!piece) return false;
        if (target && isPieceCurrentPlayer(target)) return false;
        if (fromRow === toRow && fromCol === toCol) return false;
        
        // Very basic move validation (simplified for demo)
        // In a real implementation, you would validate actual chess rules here
        return true;
    }
    
    function makeMove(fromRow, fromCol, toRow, toCol) {
        var piece = board[fromRow][fromCol];
        board[toRow][toCol] = piece;
        board[fromRow][fromCol] = null;
        
        lastMove = {
            fromRow: fromRow,
            fromCol: fromCol,
            toRow: toRow,
            toCol: toCol
        };
        
        // Switch turns
        currentTurn = currentTurn === 'white' ? 'black' : 'white';
        updateTurnIndicator();
        
        render();
        
        // Notify Business Central about the move
        // Convert to 1-based indexing for AL
        notifyMove(fromRow + 1, fromCol + 1, toRow + 1, toCol + 1);
    }
    
    function updateTurnIndicator() {
        var indicator = document.getElementById('turnIndicator');
        if (indicator) {
            indicator.textContent = currentTurn === 'white' ? 'White to move' : 'Black to move';
        }
    }
    
    function notifyMove(fromRow, fromCol, toRow, toCol) {
        // Notify Business Central through the NAV event system
        if (typeof Microsoft !== 'undefined' && 
            Microsoft.Dynamics && 
            Microsoft.Dynamics.NAV && 
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod) {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnPieceMoved', 
                [fromRow, fromCol, toRow, toCol]);
        }
    }
    
    // Public method to be called from AL to make a move on the board
    function movePiece(fromRow, fromCol, toRow, toCol) {
        // Convert from 1-based (AL) to 0-based (JS) indexing
        fromRow = fromRow - 1;
        fromCol = fromCol - 1;
        toRow = toRow - 1;
        toCol = toCol - 1;

        console.log('movePieve',fromRow,fromCol,toRow,toCol);
        
        if (fromRow >= 0 && fromRow < 8 && fromCol >= 0 && fromCol < 8 &&
            toRow >= 0 && toRow < 8 && toCol >= 0 && toCol < 8) {
            
            var piece = board[fromRow][fromCol];
            if (piece) {
                board[toRow][toCol] = piece;
                board[fromRow][fromCol] = null;
                lastMove = {
                    fromRow: fromRow,
                    fromCol: fromCol,
                    toRow: toRow,
                    toCol: toCol
                };
                
                currentTurn = currentTurn === 'white' ? 'black' : 'white';
                updateTurnIndicator();
                render();
            }
        }
    }
    
    function reset() {
        setupInitialPosition();
        currentTurn = 'white';
        lastMove = null;
        selectedSquare = null;
        updateTurnIndicator();
        render();
        
        // Notify Business Central
        if (typeof Microsoft !== 'undefined' && 
            Microsoft.Dynamics && 
            Microsoft.Dynamics.NAV && 
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod) {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnBoardReset', []);
        }
    }
    
    function initialize(controlContainer) {
        container = controlContainer;
        setupInitialPosition();
        createBoard();
        render();
        
        // Register the MovePiece method with Business Central
        if (typeof Microsoft !== 'undefined' && 
            Microsoft.Dynamics && 
            Microsoft.Dynamics.NAV && 
            Microsoft.Dynamics.NAV.RegisterCallbackMethod) {
            Microsoft.Dynamics.NAV.RegisterCallbackMethod('MovePiece', movePiece);
        }
    }
    
    // Public API
    return {
        initialize: initialize,
        movePiece: movePiece,
        reset: reset
    };
})();