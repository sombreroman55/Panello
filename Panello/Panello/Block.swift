//
//  Block.swift
//  Panello
//
//  Created by Andrew Roberts on 5/1/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import Foundation

struct Block {
    var air: Bool
    var panel: Panel?
    
    init() {
        air = true
        panel = nil
    }
}
