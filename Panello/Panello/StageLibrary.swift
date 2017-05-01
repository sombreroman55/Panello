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
    
    private var _clearFlags: [ Bool ] = [ false, false,
                                          false, false,
                                          false, false,
                                          false, false,
                                          false, false,
                                          false, false ]
    
    // -------------------------------------------------------------------
    // MARK: - Class functions
    // -------------------------------------------------------------------
    public func stageCleared(stage: Int) {
        _clearFlags[stage] = true
    }
    
    public func getStage(atIndex index: Int) -> Int {
        return _stages[index]
    }
    
    public func getStageCleared(atIndex index: Int) -> Bool {
        return _clearFlags[index]
    }
}
