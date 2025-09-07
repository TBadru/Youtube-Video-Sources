// Chess piece Unicode symbols
const pieces = {
    // White pieces
    "K": "♔", "Q": "♕", "R": "♖", "B": "♗", "N": "♘", "P": "♙",
    // Black pieces
    "k": "♚", "q": "♛", "r": "♜", "b": "♝", "n": "♞", "p": "♟"
};

// Initial board setup
const initialBoard = [
    ["r", "n", "b", "q", "k", "b", "n", "r"],
    ["p", "p", "p", "p", "p", "p", "p", "p"],
    ["", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", ""],
    ["", "", "", "", "", "", "", ""],
    ["P", "P", "P", "P", "P", "P", "P", "P"],
    ["R", "N", "B", "Q", "K", "B", "N", "R"]
];

let selectedSquare = null;
let boardState = JSON.parse(JSON.stringify(initialBoard));

function createBoard() {
    const board = document.getElementById("chessBoard");
    console.log(board);
    board.innerHTML = "";

    for (let row = 0; row < 8; row++) {
        for (let col = 0; col < 8; col++) {
            const square = document.createElement("div");
            const isLight = (row + col) % 2 === 0;
            square.className = `square ${isLight ? "light" : "dark"}`;
            square.dataset.row = row;
            square.dataset.col = col;

            // Add piece if exists
            const piece = boardState[row][col];
            if (piece) {
                square.textContent = pieces[piece];
            }

            square.addEventListener("click", handleSquareClick);
            board.appendChild(square);
        }
    }
}

function handleSquareClick(event) {
    const square = event.target;
    const row = parseInt(square.dataset.row);
    const col = parseInt(square.dataset.col);

    // Clear previous selections
    document.querySelectorAll(".square").forEach(s => {
        s.classList.remove("selected", "possible-move");
    });

    if (selectedSquare && selectedSquare.row === row && selectedSquare.col === col) {
        // Deselect if clicking the same square
        selectedSquare = null;
        return;
    }

    if (selectedSquare && boardState[selectedSquare.row][selectedSquare.col]) {
        // Move piece

        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('MakeMove', [selectedSquare.row, selectedSquare.col, row, col]);
        // boardState[row][col] = boardState[selectedSquare.row][selectedSquare.col];
        // boardState[selectedSquare.row][selectedSquare.col] = "";
        // selectedSquare = null;
        // createBoard();
        return;
    }

    // Select piece
    if (boardState[row][col]) {
        selectedSquare = { row, col };
        square.classList.add("selected");

        // Highlight possible moves (empty squares)
        highlightPossibleMoves(row, col);
    }
}

function highlightPossibleMoves(row, col) {
    document.querySelectorAll(".square").forEach(square => {
        const r = parseInt(square.dataset.row);
        const c = parseInt(square.dataset.col);
        if (!boardState[r][c] && (r !== row || c !== col)) {
            square.classList.add("possible-move");
        }
    });
}

function RecordMove() {
    boardState[row][col] = boardState[selectedSquare.row][selectedSquare.col];
    boardState[selectedSquare.row][selectedSquare.col] = "";
    selectedSquare = null;
    createBoard();
}

function DrawBoard() {
    try {
        htmlcontainer.insertAdjacentHTML('beforeend', `<div class="chess-container">
        <h1>♔ AL Chess ♛</h1>
        
        <div class="board-container">
            <div class="rank-labels">
                <span>8</span>
                <span>7</span>
                <span>6</span>
                <span>5</span>
                <span>4</span>
                <span>3</span>
                <span>2</span>
                <span>1</span>
            </div>
            
            <div class="board" id="chessBoard"></div>
        </div>
        
        <div class="coordinates">
            <div class="file-labels">
                <span>a</span>
                <span>b</span>
                <span>c</span>
                <span>d</span>
                <span>e</span>
                <span>f</span>
                <span>g</span>
                <span>h</span>
            </div>
        </div>
    </div>`);
        console.log(htmlcontainer);
        createBoard();
    }
    catch (e) {
        console.log(e);
    }
}

function RecordMove(selectedrow, selectedcol, row, col) {
    console.log(selectedrow, selectedcol, row, col);
    boardState[row][col] = boardState[selectedrow][selectedcol];
    boardState[selectedrow][selectedcol] = "";
    selectedSquare = null;
    createBoard();
}