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
    
    enum GameType {
        case TIME_TRIAL
        case ENDLESS
        case STAGE
        case PUZZLE
    }
    
    enum GameDifficulty {
        case EASY
        case MEDIUM
        case HARD
        case NONE
    }
    
    private let _state: GameState
    private let _type: GameType
    private let _difficulty: GameDifficulty
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    /* Endless game constructor */
    init() {
        _state = .RUNNING
        _type = .ENDLESS
        _difficulty = .EASY
    }
    
//    /* Stage clear game constructor */
//    init() {
//        
//    }
//    
//    /* Puzzle game constructor */
//    init() {
//        
//    }
    
    // --------------------------------------------------------------------
    // MARK: - Custom methods
    // --------------------------------------------------------------------
    
    
}
