//
//  StageLibrary.swift
//  Panello
//
//  Created by Andrew Roberts on 4/29/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import Foundation

class StageLibrary {
 
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    public static let Instance: StageLibrary = StageLibrary()

    // -------------------------------------------------------------------
    // MARK: - Constructors
    // -------------------------------------------------------------------
    private init() {
    }
    
    private var _stages: [Int] = [ 10, 20,
                                   30, 40,
                                   50, 60,
                                   70, 80,
                                   90, 100,
                                   110, 120 ]
    
    private var _clearFlags: [Bool] = [ false, false,
                                          false, false,
                                          false, false,
                                          false, false,
                                          false, false,
                                          false, false ]
    
    // -------------------------------------------------------------------
    // MARK: - Class functions
    // -------------------------------------------------------------------
    public func stageCleared(stage: Int) {
        _clearFlags[stage-1] = true
    }
    
    public func getStage(atIndex index: Int) -> Int {
        return _stages[index-1]
    }
    
    public func getStageCleared(atIndex index: Int) -> Bool {
        return _clearFlags[index-1]
    }
    
    public func save() {
        // Save to a JSON file
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsDirectory.appendingPathComponent("Stages.json")
        
        let dictionary: NSDictionary = dictionaryRepresentation
        
        let jsonData: Data = try! JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        try! jsonData.write(to: filePath)
    }
    
    public func load() {
        // TODO: Load from file
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsDirectory.appendingPathComponent("Stages.json")
        
        let jsonData: Data = try! Data(contentsOf: filePath)
        let dictionary: NSDictionary = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
        let flags: NSArray = dictionary.object(forKey: "stages") as! NSArray
        
        for i: Int in 0 ..< 12 {
            _clearFlags[i] = intToBool(flags.object(at: (i)) as! Int)
        }
    }
    
    private var dictionaryRepresentation: NSDictionary {
        return [ "stages":[ boolToInt(_clearFlags[0]), boolToInt(_clearFlags[1]),
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
