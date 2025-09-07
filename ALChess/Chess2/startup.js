(function() {
    'use strict';
    
    // Wait for the DOM to be ready
    function ready(fn) {
        if (document.readyState !== 'loading') {
            fn();
        } else {
            document.addEventListener('DOMContentLoaded', fn);
        }
    }
    
    // Initialize the chess board control
    function initializeChessBoard() {
        // Get the control container
        var controlContainer = document.getElementById('controlAddIn');
        
        // If container doesn't exist, create it in the body
        if (!controlContainer) {
            controlContainer = document.body;
        }
        
        // Initialize the chess board
        if (typeof ChessBoardControl !== 'undefined') {
            ChessBoardControl.initialize(controlContainer);
            
            // Register with Business Central's event system
            if (typeof Microsoft !== 'undefined' && 
                Microsoft.Dynamics && 
                Microsoft.Dynamics.NAV) {
                
                // Notify that the control is ready
                if (Microsoft.Dynamics.NAV.InvokeExtensibilityMethod) {
                    // Control is ready - notify AL if needed
                    console.log('Chess Board Control initialized successfully');
                }
                
                // Make the control available globally for AL to call
                window.ChessBoardControlInstance = ChessBoardControl;
            }
        } else {
            console.error('ChessBoardControl is not defined. Make sure ChessBoard.js is loaded.');
        }
    }
    
    // Start initialization
    ready(initializeChessBoard);
})();