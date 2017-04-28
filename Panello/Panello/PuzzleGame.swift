//
//  PuzzleGame.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class PuzzleGame: Game, GameProtocol {
    
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
    
    override init() {
        _board = Board()
        _highScore = 0
        super.init()
    }
    
    // --------------------------------------------------------------------
    // MARK: - GameProtocol methods
    // --------------------------------------------------------------------
    
    func update() {
        
    }
    
    func reset() {
        
    }
    
    func save() {
        
    }
    
    func load() {
        
    }
    
    // --------------------------------------------------------------------
    // MARK: - PuzzleGame methods
    // --------------------------------------------------------------------
}
