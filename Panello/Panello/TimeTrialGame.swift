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
    private var _timeSelected: Int
    private var _timeRemaining: Int
    private var _state: GameState
    private var _startTime: Double

    
    // --------------------------------------------------------------------
    // MARK: - Public instance data
    // --------------------------------------------------------------------
    
    public var board: Board { return _board }
    public var score: Int { return _score }
    public var timeSelected: Int { return _timeSelected }
    public var timeRemaining: Int { return _timeRemaining }
    public var state: GameState { return _state }
    public var startTime: Double { return _startTime }
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init(withTime time: Int) {
        _board = Board()
        _board.fillRandom()
        _state = .RUN
        _timeSelected = time
        _timeRemaining = _timeSelected
        _score = 0
        _startTime = CACurrentMediaTime()
    }
    
    // --------------------------------------------------------------------
    // MARK: - TimeTrialGame methods
    // --------------------------------------------------------------------
    
    func update() {
        _board.update()
        _timeRemaining = _timeSelected - Int(CACurrentMediaTime() - _startTime)
    }
    
    func pauseGame() {
        _state = .PAUSE
    }
    
    func checkGameFinish() {
        
    }
    
    func checkGameOver() {
        
    }
}
