//
//  Board.swift
//  Panello
//
//  Created by Andrew Roberts on 4/6/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class Board {
    
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    enum BoardState {
        case RUNNING
        case COUNTDOWN
        case WIN
        case GAME_OVER
    }
    
    static let normalExplodingFrames: Int = 61
    //the total explosion time for a combo is 61 + 9 * n, where n is the  number of blocks
    static let additionalExplodingFrames: Int = 9
    static let swapDelayFrames: Int = 3
    static let boardHeight: Int = 24
    static let boardWidth: Int = 6
    static let topRow: Int = 11
    static let panicRow: Int = 9
    static let warningRow: Int = 10
    static let floatFrames: Int = 12
    static let stackRiseTimer: Int = 32
    static let countdownTimer: Int = 3000
    
    // -------------------------------------------------------------------
    // MARK: - Static functions
    // -------------------------------------------------------------------
    class func fillBoard() -> [[Panel]] {
        
    }
    
    // -------------------------------------------------------------------
    // MARK: - Instance data
    // -------------------------------------------------------------------
    private var _game: Game
    private var _state: BoardState
    private var _buffer: [Panel] // Buffering row is 6 panels wide
    private var _board: [[Panel]] // Board is 6 panels wide x 12 panels high
    private var _forceRaiseRow: Bool
    private var _blocksPoppingOrFalling: Bool
    private var _chainOnThisFrame: Bool // true if a chain has occurred during this frame
    private var _chainEndOnThisFrame: Bool // true if a chain ended on this frame
    private var _panelOnTopRow: Bool
    private var _panicked: Bool
    private var _warnColumns: [Bool] // 6 panels wide
    private var _framesRun: Int
    private var _panelsMatchedThisFrame: Int
    private var _boardOffset: Int
    private var _raiseFullRowFrames: Int // frames to raise stack one row
    private var _raiseFullRowTimer: Int
    private var _graceTimer: Int
    private var _chainCount: Int
    private var _sizeOfLastChain: Int
    private var _matchRowLocation: Int
    private var _matchColumnLocation: Int
    private var _score: Int
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    /* Endless game board */
    init(game: Game) {
        _game = game
        _board = Board.fillBoard()
        _state = .COUNTDOWN
        _framesRun = 0
        _warnColumns = Array(repeating: false, count: 6)
        _panelsMatchedThisFrame = 0
        _boardOffset = 0
        _raiseFullRowFrames = 10
        _raiseFullRowTimer = 0
        _forceRaiseRow = false
        _graceTimer = 0
        _chainCount = 1
        _chainOnThisFrame = false
        _chainEndOnThisFrame = false
        _sizeOfLastChain = 0
        _panelOnTopRow = false
        _panicked = false
        _score = 0
    }
    
    // --------------------------------------------------------------------
    // MARK: - Board functions
    // --------------------------------------------------------------------
    
    func update() {
        if (_state == .COUNTDOWN) {
            
        }
    }
}
