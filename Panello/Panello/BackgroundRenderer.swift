//
//  Background.swift
//  Panello
//
//  Created by Andrew Roberts on 4/18/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//
// TODO: -Add animated background shapes to background?
//       -Add functionality to select background

import GLKit

class BackgroundRenderer {

    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    private var _backgroundFragmentCoordinates: [Float]
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init() {
        _backgroundFragmentCoordinates = []
        BackgroundEngine.setup()
    }
    
    // --------------------------------------------------------------------
    // MARK: - BackgroundRenderer methods
    // --------------------------------------------------------------------
    
    /* Draw the background for a game */
    func renderMenuBackground(menuBackground: Int) {
        _backgroundFragmentCoordinates = getTexture(forMenuBackground: menuBackground)
        glUseProgram(BackgroundEngine.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, BackgroundEngine.menuQuad)
        glVertexAttribPointer(1, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _backgroundFragmentCoordinates)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func getTexture(forMenuBackground menuBackground: Int) -> [Float] {
        switch (menuBackground) {
        case 1: // Title
            return BackgroundEngine.menuBackground1
        case 2: // Main
            return BackgroundEngine.menuBackground2
        case 3: // BG Select
            return BackgroundEngine.menuBackground3
        case 4: // Time Select
            return BackgroundEngine.menuBackground4
        case 5: // Stage Select
            return BackgroundEngine.menuBackground5
        case 6: // Puzzle Select
            return BackgroundEngine.menuBackground6
        case 7: // High Scores
            return BackgroundEngine.menuBackground7
        case 8: // Tutorial
            return BackgroundEngine.menuBackground8
        case 9: // Credits
            return BackgroundEngine.menuBackground9
        default: // Should not get called
            return BackgroundEngine.menuBackground1
        }
    }
    
    /* Draw the background for a game */
    func renderGameBackground(gameBackground: Int) {
        _backgroundFragmentCoordinates = getTexture(forGameBackground: gameBackground)
        glUseProgram(BackgroundEngine.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, BackgroundEngine.gameQuad)
        glVertexAttribPointer(1, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _backgroundFragmentCoordinates)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func getTexture(forGameBackground gameBackground: Int) -> [Float] {
        switch (gameBackground) {
        case 1:
            return BackgroundEngine.gameBackground1
        case 2:
            return BackgroundEngine.gameBackground2
        case 3:
            return BackgroundEngine.gameBackground3
        case 4:
            return BackgroundEngine.gameBackground4
        case 5:
            return BackgroundEngine.gameBackground5
        case 6:
            return BackgroundEngine.gameBackground6
        default:
            return BackgroundEngine.gameBackground1
        }
    }
    
    func renderPreviewBackground(background: Int) {
        let backVertices = getVertices(forBackground: background)
        _backgroundFragmentCoordinates = getTexture(forGameBackground: background)
        glUseProgram(BackgroundEngine.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, backVertices)
        glVertexAttribPointer(1, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _backgroundFragmentCoordinates)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func getVertices(forBackground background: Int) -> [Float] {
        switch (background) {
        case 1:
            return BackgroundEngine.previewQuad1
        case 2:
            return BackgroundEngine.previewQuad2
        case 3:
            return BackgroundEngine.previewQuad3
        case 4:
            return BackgroundEngine.previewQuad4
        case 5:
            return BackgroundEngine.previewQuad5
        case 6:
            return BackgroundEngine.previewQuad6
        default:
            return BackgroundEngine.previewQuad1
        }
    }
}
