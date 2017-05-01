//
//  Board.swift
//  Panello
//
//  Created by Andrew Roberts on 4/6/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

//struct Block {
//    init() {}
//    var isPanel: Bool // if true block == panel, else block == air
//    var panel: Panel?
//}

class Board {
    
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    enum BoardState {
        case RUNNING
        case COUNTDOWN
        case WIN
        case GAME_OVER
    }
    
    static let boardHeight: Int = 12
    static let boardWidth: Int = 6
    static let topRow: Int = 11
    static let panicRow: Int = 9
    static let warningRow: Int = 10
    
    // -------------------------------------------------------------------
    // MARK: - Static functions
    // -------------------------------------------------------------------
    
//    class func fillBoard() -> [[Block]] {
//        var b: [[Block]] = []
//        for i: Int in 0 ..< 6 {
//            for j: Int in 0 ..< boardWidth {
//                b[i][j].isPanel = true
//                b[i][j].panel = Panel()
//            }
//        }
//        return b
//    }
//    
//    class func fillBuffer() -> [Block] {
//        var b: [Block] = []
//        for i: Int in 0 ..< boardWidth {
//            
//        }
//    }
    
    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    // -------------------------------------------------------------------
    // MARK: - Public instance data
    // -------------------------------------------------------------------
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    // --------------------------------------------------------------------
    // MARK: - Board functions
    // --------------------------------------------------------------------
}
