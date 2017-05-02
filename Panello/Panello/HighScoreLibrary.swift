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
    public static var Instance: HighScoreLibrary = HighScoreLibrary()

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
    public func addScore(score: Int) {
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
    
    public func save() {
        // Save to a JSON file
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsDirectory.appendingPathComponent("HighScores.json")
        
        let dictionary: NSDictionary = dictionaryRepresentation
        
        let jsonData: Data = try! JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        try! jsonData.write(to: filePath)
    }
    
    public func load() {        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsDirectory.appendingPathComponent("HighScores.json")
        
        let jsonData: Data = try! Data(contentsOf: filePath)
        let dictionary: NSDictionary = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
        let flags: NSArray = dictionary.object(forKey: "scores") as! NSArray
        
        for i: Int in 0 ..< 10 {
            _scores[i] = flags.object(at: (i)) as! Int
        }
    }
    
    private var dictionaryRepresentation: NSDictionary {
        return [ "scores":[ _scores[0], _scores[1], _scores[2], _scores[3], _scores[4], _scores[5], _scores[6], _scores[7], _scores[8], _scores[9] ] ]
    }
}
