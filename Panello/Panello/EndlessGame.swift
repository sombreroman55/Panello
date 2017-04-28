//
//  EndlessGame.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class EndlessGame: Game, GameProtocol {
    
    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    private var _board: Board
    private var _highScore: Int
    
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
        if (board.state == Board.BoardState.COUNTDOWN) {
            
        }
        
        if (state == .RUNNING) {
            millisecondsRun += 1
            board.update()
            if (!panicked && board.panicked) {
                panicked = true
            }
            if (panicked && !board.panicked) {
                panicked = false
            }
            if (board.score > highScore) {
                _highScore = board.score
            }
        }
        checkGameOver()
    }
    
    func reset() {
        state = Game.GameState.RUNNING
        startTime = CACurrentMediaTime()
        //_board = _board.reset()
        panicked = false;
    }
    
    func save() {
        
    }
    
    func load() {
        
    }
    
    // --------------------------------------------------------------------
    // MARK: - EndlessGame methods
    // --------------------------------------------------------------------
    
    func checkGameOver () {
        if (_board.state == Board.BoardState.GAME_OVER) {
            // TODO: -save high score information
            state = .GAME_OVER
        }
    }
}
