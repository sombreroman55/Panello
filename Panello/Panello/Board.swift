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
        case RUN
        case COUNTDOWN
        case WIN
        case GAME_OVER
    }
    
    // -------------------------------------------------------------------
    // MARK: - Instance data
    // -------------------------------------------------------------------
    private var _state: BoardState
    private var _board: [[Panel]] // Board is 6 panels wide x 12 panels high
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    /* Endless game board */
    init() {
        // TODO: fill out board
        _board = []
        _state = .RUN
    }
    
//    /* Puzzle game board */
//    init() {
//        
//    }
}
