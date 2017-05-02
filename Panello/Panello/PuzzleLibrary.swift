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
    
    public func puzzleCleared(puzzle: Int) {
        _clearFlags[puzzle-1] = true
    }
    
    public func getPuzzle(atIndex index: Int) -> String {
        return _puzzles[index-1]
    }
    
    public func getMoves(atIndex index: Int) -> Int {
        return _movesForPuzzle[index-1]
    }
    
    public func getPuzzleCleared(atIndex index: Int) -> Bool {
        return _clearFlags[index-1]
    }
    
    public func save() {
        // Save to a JSON file
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsDirectory.appendingPathComponent("Puzzles.json")
        
        let dictionary: NSDictionary = dictionaryRepresentation
        
        let jsonData: Data = try! JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        try! jsonData.write(to: filePath)
    }
    
    public func load() {        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsDirectory.appendingPathComponent("Puzzles.json")
        
        let jsonData: Data = try! Data(contentsOf: filePath)
        let dictionary: NSDictionary = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
        let flags: NSArray = dictionary.object(forKey: "puzzles") as! NSArray
        
        for i: Int in 0 ..< 12 {
            _clearFlags[i] = intToBool(flags.object(at: (i)) as! Int)
        }
    }
    
    private var dictionaryRepresentation: NSDictionary {
        return  ["puzzles":[ boolToInt(_clearFlags[0]), boolToInt(_clearFlags[1]),
                             boolToInt(_clearFlags[2]), boolToInt(_clearFlags[3]),
                             boolToInt(_clearFlags[4]), boolToInt(_clearFlags[5]),
                             boolToInt(_clearFlags[6]), boolToInt(_clearFlags[7]),
                             boolToInt(_clearFlags[8]), boolToInt(_clearFlags[9]),
                             boolToInt(_clearFlags[10]), boolToInt(_clearFlags[11]) ] ]
    }
    
    private func boolToInt(_ bool: Bool) -> Int {
        if (bool) {
            return 1
        }
        return 0
    }
    
    private func intToBool(_ int: Int) -> Bool {
        if (int == 1) {
            return true
        }
        return false
    }
}
