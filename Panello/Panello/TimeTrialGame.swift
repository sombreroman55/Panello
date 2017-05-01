//
//  TimeTrialGame.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class TimeTrialGame {
    
    // --------------------------------------------------------------------
    // MARK: - Private instance data
    // --------------------------------------------------------------------
    
    private var _board: Board
    private var _score: Int
    private var _timeRemaining: Int
    private var _state: GameState

    
    // --------------------------------------------------------------------
    // MARK: - Public instance data
    // --------------------------------------------------------------------
    
    public var board: Board { return _board }
    public var score: Int { return _score }
    public var timeRemaining: Int { return _timeRemaining }
    public var state: GameState { return _state }

    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init(withTime time: Int) {
        _board = Board()
        _board.fillRandom()
        _state = .RUN
        _timeRemaining = time
        _score = 0
    }
    
    // --------------------------------------------------------------------
    // MARK: - TimeTrialGame methods
    // --------------------------------------------------------------------
    
    func update() {
        _board.update()
    }
    
    func pauseGame() {
        _state = .PAUSE
    }
}
