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
    
    /* Background designs */
    
    /* Game types:
            1 = Endless
            2 = Time Trial
            3 = Stage
            4 = Puzzle
    */

    private static let endlessBar: [Float] = [ (226/255), (86/255), (136/255), 1.0,
                                               (226/255), (86/255), (136/255), 1.0,
                                               (226/255), (86/255), (136/255), 1.0,
                                               (226/255), (86/255), (136/255), 1.0, ]
    
    private static let timeTrialBar: [Float] = [ (226/255), (152/255), (68/255), 1.0,
                                                 (226/255), (152/255), (68/255), 1.0,
                                                 (226/255), (152/255), (68/255), 1.0,
                                                 (226/255), (152/255), (68/255), 1.0, ]
    
    private static let stageBar: [Float] = [ (68/255), (226/255), (70/255), 1.0,
                                             (68/255), (226/255), (70/255), 1.0,
                                             (68/255), (226/255), (70/255), 1.0,
                                             (68/255), (226/255), (70/255), 1.0, ]
    
    private static let puzzleBar: [Float] = [ (68/255), (226/255), (192/255), 1.0,
                                              (68/255), (226/255), (192/255), 1.0,
                                              (68/255), (226/255), (192/255), 1.0,
                                              (68/255), (226/255), (192/255), 1.0, ]
    
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
            return TopBarRenderer.endlessBar
        case 2:
            return TopBarRenderer.timeTrialBar
        case 3:
            return TopBarRenderer.stageBar
        case 4:
            return TopBarRenderer.puzzleBar
        default:
            return TopBarRenderer.endlessBar
        }
    }
}
