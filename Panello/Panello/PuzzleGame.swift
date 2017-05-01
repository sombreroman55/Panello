//
//  PuzzleGame.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class PuzzleGame {
    
    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    public var _board: Board
    public var _highScore: Int
    
    // -------------------------------------------------------------------
    // MARK: - Public instance data
    // -------------------------------------------------------------------
    
    public var board: Board { return _board }
    public var highScore: Int { return _highScore }    
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init() {
        _board = Board()
        _highScore = 0
    }
    
    // --------------------------------------------------------------------
    // MARK: - PuzzleGame methods
    // --------------------------------------------------------------------
}
