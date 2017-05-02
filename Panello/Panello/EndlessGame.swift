//
//  EndlessGame.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class EndlessGame {
    
    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    private var _board: Board
    private var _score: Int
    private var _highScore: Int
    private var _state: GameState
    private var scoreAdded: Bool
    
    // -------------------------------------------------------------------
    // MARK: - Public instance data
    // -------------------------------------------------------------------
    
    public var board: Board { return _board }
    public var score: Int { return _score }
    public var highScore: Int { return _highScore }
    public var state: GameState { return _state }
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init() {
        _board = Board()
        _board.fillRandom()
        _state = .RUN
        _score = 0
        _highScore = HighScoreLibrary.Instance.getHighScore()
        scoreAdded = false
    }

    // --------------------------------------------------------------------
    // MARK: - EndlessGame methods
    // --------------------------------------------------------------------

    func update() {
        if (_score > _highScore) {
            _highScore = _score
        }
        _score = _board.score
        _board.update()
        checkGameOver()
    }
    
    func pauseGame() {
        _state = .PAUSE
    }
    
    func checkGameOver() {
        if (_board.state == .GAME_OVER && !scoreAdded) {
            HighScoreLibrary.Instance.addScore(score: _score)
            scoreAdded = true
        }
    }
}
