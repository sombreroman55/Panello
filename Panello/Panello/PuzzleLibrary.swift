//
//  PuzzleLibrary.swift
//  Panello
//
//  Created by Andrew Roberts on 4/29/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import Foundation

class PuzzleLibrary {
    
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    public static let Instance: PuzzleLibrary = PuzzleLibrary()

    // -------------------------------------------------------------------
    // MARK: - Constructors
    // -------------------------------------------------------------------
    private init() {
    }
    
    private var _puzzles: [String] =
        [//12      11      10       9       8       7       6       5       4       3       2       1
        "......\n......\n......\n......\n......\n......\n......\n......\n......\n......\n..a...\naabb.b",
        "......\n......\n......\n......\n......\n......\n......\n..cd..\n..dc..\n..cd..\n..dc..\n..cd..",
        "......\n......\n......\n......\n......\n......\n......\n......\n......\n......\n......\nefefef",
        "......\n......\n......\n......\n......\n......\n......\n......\n......\n.be...\n.eb...\n.bebb.",
        "......\n......\n......\n......\n......\n......\n......\n......\n...c..\n...da.\n..aad.\n.accda",
        "......\n......\n......\n......\n......\n......\n......\n......\n...d..\n..ed..\n.eeb..\n.bbd..",
        "......\n......\n......\n......\n......\n......\n...b..\n..bd..\n..cd..\n..bc..\n..dc..\nbbcd..",
        "......\n......\n......\n......\n......\n....c.\n....c.\n....f.\n...fc.\n..fda.\n.ddcc.\n.acca.",
        "......\n......\n......\n......\n......\n......\n......\naabbaa\ncdefdc\nceddfc\nbebbfb\ncaddac",
        "......\n......\n......\n......\n......\n......\n......\n......\n......\n..aba.\nbbabba\naeeaeb",
        "......\n......\n......\n......\n......\n......\n.bc...\n.ed...\n.ee...\n.dd...\n.bc...\n.ebbc.",
        "......\n......\n......\n......\n......\n...a..\n..af..\n..dbf.\n..efb.\n..ebe.\n.bbea.\n.dedb."
        ]
    
    private var _movesForPuzzle: [Int] = [ 1, 3,
                                           3, 2,
                                           3, 2,
                                           3, 3,
                                           5, 3,
                                           4, 4 ]
    
    private var _clearFlags: [Bool] = [ false, false,
                                        false, false,
                                        false, false,
                                        false, false,
                                        false, false,
                                        false, false ]
    
    // -------------------------------------------------------------------
    // MARK: - Class functions
    // -------------------------------------------------------------------
    
    public func puzzleCleared(atIndex index: Int) {
        _clearFlags[index] = true
    }
    
    public func getPuzzle(atIndex index: Int) -> String {
        return _puzzles[index]
    }
    
    public func getMoves(atIndex index: Int) -> Int {
        return _movesForPuzzle[index]
    }
    
    public func getStageCleared(atIndex index: Int) -> Bool {
        return _clearFlags[index]
    }
}
