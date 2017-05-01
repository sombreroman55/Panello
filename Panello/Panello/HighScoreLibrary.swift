//
//  HighScoreLibrary.swift
//  Panello
//
//  Created by Andrew Roberts on 4/29/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import Foundation

class HighScoreLibrary {
    
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    public static let Instance: HighScoreLibrary = HighScoreLibrary()

    // -------------------------------------------------------------------
    // MARK: - Constructors
    // -------------------------------------------------------------------
    private init() {
        _scores.sort { $0 > $1 }
        while (_scores.count > 10) {
            _ = _scores.removeLast()
        }
    }
    
    private var _scores: [Int] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
    
    // -------------------------------------------------------------------
    // MARK: - Class functions
    // -------------------------------------------------------------------
    public func addNewScore(score: Int) {
        _scores.append(score)
        _scores.sort { $0 > $1 }
        while (_scores.count > 10) {
            _ = _scores.removeLast()
        }
    }
    
    public func getScore(atIndex index: Int) -> Int {
        return _scores[index]
    }
    
    public func getHighScore() -> Int {
        return _scores.first!
    }
    
    // -------------------------------------------------------------------
    // MARK: - Serialization
    // -------------------------------------------------------------------
}
