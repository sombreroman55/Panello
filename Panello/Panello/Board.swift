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
    
    static let normalExplodingMilliseconds: Int = 61
    //the total explosion time for a combo is 61 + 9 * n, where n is the  number of blocks
    static let additionalExplodingMilliseconds: Int = 9
    static let swapDelayMilliseconds: Int = 3
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
    
//    class func fillBoard() -> [[Panel]] {
//    }
    
    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    //private var _game: Game?
    private var _state: BoardState
    //private var _buffer: [Panel] // Buffering row is 6 panels wide
    //private var _board: [[Panel]] // Board is 6 panels wide x 12 panels high
    private var _forceRaiseRow: Bool
    private var _blocksPoppingOrFalling: Bool
    private var _chainOnThisFrame: Bool // true if a chain has occurred during this frame
    private var _chainEndOnThisFrame: Bool // true if a chain ended on this frame
    private var _panelOnTopRow: Bool
    private var _panicked: Bool
    private var _warnColumns: [Bool] // 6 panels wide
    private var _framesRun: Int = 0
    private var _panelsMatchedThisFrame: Int = 0
    private var _boardOffset: Int = 0
    private var _raiseFullRowFrames: Int = 0 // frames to raise stack one row
    private var _raiseFullRowTimer: Int = 0
    private var _graceTimer: Int = 0
    private var _chainCount: Int = 0
    private var _sizeOfLastChain: Int = 0
    private var _matchRowLocation: Int = 0
    private var _matchColumnLocation: Int = 0
    private var _score: Int = 0
    
    // -------------------------------------------------------------------
    // MARK: - Public instance data
    // -------------------------------------------------------------------
    
    //public var game: Game? { return _game }
    public var state: BoardState { return _state }
    //public var buffer: [Panel] { return _buffer }
    //public var board: [[Panel]] { return _board }
    public var forceRaiseRow: Bool { return _forceRaiseRow }
    public var blocksPoppingOrFalling: Bool { return _blocksPoppingOrFalling }
    public var chainOnThisFrame: Bool { return _chainOnThisFrame }
    public var chainEndOnThisFrame: Bool { return _chainEndOnThisFrame }
    public var panelOnTopRow: Bool { return _panelOnTopRow }
    public var panicked: Bool { return _panicked }
    public var warnColumns: [Bool] { return _warnColumns }
    public var framesRun: Int { return _framesRun }
    public var panelsMatchedThisFrame: Int { return _panelsMatchedThisFrame }
    public var boardOffset: Int { return _boardOffset }
    public var raiseFullRowFrames: Int { return _raiseFullRowFrames }
    public var raiseFullRowTimer: Int { return _raiseFullRowTimer }
    public var graceTimer: Int { return _graceTimer }
    public var chainCount: Int { return _chainCount }
    public var sizeOfLastChain: Int { return _sizeOfLastChain }
    public var matchRowLocation: Int { return _matchRowLocation }
    public var matchColumnLocation: Int { return _matchColumnLocation }
    public var score: Int { return _score }
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init() {
        //_game = nil
        //_board = Board.fillBoard()
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
        _blocksPoppingOrFalling = false
        _chainOnThisFrame = false
        _chainEndOnThisFrame = false
        _sizeOfLastChain = 0
        _panelOnTopRow = false
        _panicked = false
        _score = 0
    }
    
    /* Init from string */
//    init (dictionary: NSDictionary) {
//        
//    }
    
    // --------------------------------------------------------------------
    // MARK: - Board functions
    // --------------------------------------------------------------------
    
    func update() {
        if (_state == .COUNTDOWN) {
            
        }
    }
}
