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
    var _framesRun: Int
    private var _state: GameState
    private var _panicked: Bool
    private var _startTime: Double

    
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
    // MARK: - Custom methods
    // --------------------------------------------------------------------
    
    /* Game logic loop */
    func tick(timePassed: TimeInterval) {
        
    }
    
    func isPaused() -> Bool {
        return _state == .PAUSED
    }
    
    func isPanicked() -> Bool {
        return _panic
    }
    
    func getState() -> GameState {
        return _state
    }
    
    func getStartTime() -> Double {
        return _startTime
    }
}
