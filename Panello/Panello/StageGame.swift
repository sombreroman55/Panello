//
//  StageGame.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class StageGame {
    
    // --------------------------------------------------------------------
    // MARK: - Private instance data
    // --------------------------------------------------------------------
    
    private var _board: Board
    private var _stageNumber: Int
    private var _linesRemaining: Int
    private var _state: GameState


    
    // --------------------------------------------------------------------
    // MARK: - Public instance data
    // --------------------------------------------------------------------
    
    public var board: Board { return _board }
    public var stageNumber: Int { return _stageNumber }
    public var linesRemaining: Int { return _linesRemaining }
    public var state: GameState { return _state }

    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init(withStage stage: Int) {
        _board = Board()
        _board.fillRandom()
        _state = .RUN
        _stageNumber = stage
        _linesRemaining = StageLibrary.Instance.getStage(atIndex: stage)
    }
    
    // --------------------------------------------------------------------
    // MARK: - StageGame methods
    // --------------------------------------------------------------------
    
    func update() {
        _board.update()
    }
    
    func pauseGame() {
        _state = .PAUSE
    }
}
