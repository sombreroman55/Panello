//
//  Game.swift
//  Panello
//
//  Created by Andrew Roberts on 4/6/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

protocol GameProtocol {
    func update()
    func reset()
    func save() // Serialization
    func load() // Serialization
}

class Game {
    
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    enum GameState {
        case RUNNING
        case PAUSED
        case GAME_OVER
    }
    
    // -------------------------------------------------------------------
    // MARK: - Public instance data
    // -------------------------------------------------------------------
    
    public var millisecondsRun: Double
    public var state: GameState
    public var panicked: Bool
    public var startTime: Double
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    /* Endless game constructor */
    init() {
        millisecondsRun = 0
        state = .RUNNING
        panicked = false
        startTime = CACurrentMediaTime() * 1000 // times 1000 for milliseconds
    }
    
    // --------------------------------------------------------------------
    // MARK: - Game methods
    // --------------------------------------------------------------------
    func isPaused() -> Bool {
        return state == .PAUSED
    }
    
    func getTime() -> Double {
        return (CACurrentMediaTime() * 1000) - startTime
    }
}
