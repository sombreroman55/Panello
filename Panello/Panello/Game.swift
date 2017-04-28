//
//  Game.swift
//  Panello
//
//  Created by Andrew Roberts on 4/6/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class Game {
    
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    enum GameState {
        case RUNNING
        case PAUSED
        case GAME_OVER
    }
    
    //var risingSpeed: Int
    private var _state: GameState
    private var _panicked: Bool
    private var _startTime: Double
    public var _framesRun: Double
    public var state: GameState { return _state }
    public var panicked: Bool { return _panicked }
    public var startTime: Double { return _startTime }
    public var framesRun: Double { return _framesRun }

    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    /* Endless game constructor */
    init() {
        _framesRun = 0
        _state = .RUNNING
        _panicked = false
        _startTime = CACurrentMediaTime()
    }
    
    // --------------------------------------------------------------------
    // MARK: - Game methods
    // --------------------------------------------------------------------
    
    /* Game logic loop */
    func tick() {
        _framesRun = CACurrentMediaTime() - _startTime
    }
    
    func isPaused() -> Bool {
        return _state == .PAUSED
    }
    
    // --------------------------------------------------------------------
    // MARK: - Serialization
    // --------------------------------------------------------------------

}
