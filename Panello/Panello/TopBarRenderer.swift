//
//  TopBarRenderer.swift
//  Panello
//
//  Created by Andrew Roberts on 4/29/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class TopBarRenderer {
    private static let quad: [Float] = [ -1.0, 0.7, 1.0, 0.7, -1.0, 1.0, 1.0, 1.0 ]
   
    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    private var _topBarFragmentCoordinates: [Float]
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init() {
        _topBarFragmentCoordinates = []
        BackgroundEngine.setup()
    }
    
    // --------------------------------------------------------------------
    // MARK: - TopBarRenderer methods
    // --------------------------------------------------------------------
    
    /* Draw the background */
    func renderTopBar(type: Int) {
        _topBarFragmentCoordinates = getTexture(forGameType: type)
        glUseProgram(BackgroundEngine.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, TopBarRenderer.quad)
        glVertexAttribPointer(1, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _topBarFragmentCoordinates)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func getTexture(forGameType type: Int) -> [Float] {
        switch(type) {
        case 1:
            return BackgroundEngine.menuBackground3
        case 2:
            return BackgroundEngine.menuBackground4
        case 3:
            return BackgroundEngine.menuBackground5
        case 4:
            return BackgroundEngine.menuBackground6
        default:
            return BackgroundEngine.menuBackground3
        }
    }
}
