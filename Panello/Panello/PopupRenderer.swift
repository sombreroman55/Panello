//
//  PopupRenderer.swift
//  Panello
//
//  Created by Andrew Roberts on 4/30/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class PopupRenderer {
    
    // -------------------------------------------------------------------
    // MARK: - Public instance data
    // -------------------------------------------------------------------
    public var startPositionX: Float // Anchor X coordinate
    public var startPositionY: Float // Anchor Y coordinate
    
    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    private var texture: GLKTextureInfo? // The texture of the character
    private var textureCoordinates: [Float] // The coordinates of the texture in the bitmap
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init(startCoordinateX: Float, startCoordinateY: Float) {
        texture = try? GLKTextureLoader.texture(with: SpriteEngine.image.cgImage!, options: nil)
        textureCoordinates = []
        startPositionX = startCoordinateX
        startPositionY = startCoordinateY
        SpriteEngine.setup()
    }
    
    func renderCursor() {
        textureCoordinates = SpriteEngine.cursor
        glUseProgram(SpriteEngine.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, Panel.quad)
        glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, textureCoordinates)
        glUniform2f(glGetUniformLocation(SpriteEngine.program, "translation"), startPositionX, startPositionY)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        if let tex = texture {
            glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
        }
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func renderPauseMenu() {
        textureCoordinates = SpriteEngine.notClearedBlock
        glUseProgram(SpriteEngine.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, BorderRenderer.quad)
        glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, textureCoordinates)
        glUniform2f(glGetUniformLocation(SpriteEngine.program, "translation"), startPositionX, startPositionY)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        if let tex = texture {
            glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
        }
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
}
