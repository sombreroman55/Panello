//
//  PuzzleGame.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

struct PuzzleBoardStack {
    var boards = [Board]()
    
    mutating func push(_ board: Board) {
        boards.append(board)
    }
    
    mutating func pop() -> Board {
        return boards.removeLast()
    }
    
    mutating func clear() {
        boards.removeAll()
    }
    
    mutating func count() -> Int {
        return boards.count
    }
}

class PuzzleGame {
    
    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    private var _board: Board
    private var _movesLeft: Int
    private var _puzzleNumber: Int
    private var _moveStack: PuzzleBoardStack = PuzzleBoardStack()
    private var _state: GameState

    
    // -------------------------------------------------------------------
    // MARK: - Public instance data
    // -------------------------------------------------------------------
    
    public var puzzleNumber: Int { return _puzzleNumber }
    public var board: Board { return _board }
    public var movesLeft: Int { return _movesLeft }
    public var state: GameState { return _state }

    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init(withPuzzle puzzle: Int) {
        _puzzleNumber = puzzle
        _board = Board()
        _board.buildPuzzleBoard(puzzle: puzzle)
        _state = .RUN
        _moveStack.push(_board)
        _movesLeft = PuzzleLibrary.Instance.getMoves(atIndex: puzzle)
    }
    
    // --------------------------------------------------------------------
    // MARK: - PuzzleGame methods
    // --------------------------------------------------------------------
    
    func update() {
        _board.update()
        checkGameOver()
    }
    
    func moveTaken() {
        let copy: Board = _board
        _moveStack.push(copy)
        _movesLeft -= 1
        _board.writeBoard()
    }
    
    func undoMove() {
        if (_moveStack.count() > 0) {
            _board = _moveStack.pop()
            _movesLeft += 1
            _board.writeBoard()
        }
    }
    
    func checkWin() {
        if (_board.blocksOnBoard == 0 && _movesLeft == 0) {
            PuzzleLibrary.Instance.puzzleCleared(puzzle: _puzzleNumber)
            _board.state = .WIN
            _state = .END
        }
    }
    
    func checkGameOver() {
        if (_board.blocksOnBoard != 0 && _movesLeft == 0) {
            _board.state = .GAME_OVER
            _state = .END
        }
    }
    
    func pauseGame() {
        _state = .PAUSE
    }
}
