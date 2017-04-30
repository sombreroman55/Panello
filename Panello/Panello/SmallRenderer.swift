//
//  SmallRenderer.swift
//  Panello
//
//  Created by Andrew Roberts on 4/30/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class SmallRenderer {
    
    // Vertex coordinates
    private static let smallQuad: [Float] = [ -0.06, -0.06, -0.06, 0.06, 0.06, -0.06, 0.06, 0.06 ]
    private static let bigQuad: [Float] = [ -0.12, -0.12, -0.12, 0.12, 0.12, -0.12, 0.12, 0.12 ]
    
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
    
    // --------------------------------------------------------------------
    // MARK: - BorderRenderer methods
    // --------------------------------------------------------------------
    
    public func touchedInsideSmall(x: Float, y: Float) -> Bool {
        if (x >= (startPositionX - 0.06) &&
            x <= (startPositionX + 0.06) &&
            y >= (startPositionY - 0.06) &&
            y <= (startPositionY + 0.06)) {
            return true
        }
        return false
    }
    
    public func touchedInsideBig(x: Float, y: Float) -> Bool {
        if (x >= (startPositionX - 0.12) &&
            x <= (startPositionX + 0.12) &&
            y >= (startPositionY - 0.12) &&
            y <= (startPositionY + 0.12)) {
            return true
        }
        return false
    }
    
    func renderSmallBorder() {
        textureCoordinates = SpriteEngine.smallBorder
        glUseProgram(SpriteEngine.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, SmallRenderer.bigQuad)
        glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, textureCoordinates)
        glUniform2f(glGetUniformLocation(SpriteEngine.program, "translation"), startPositionX, startPositionY)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        if let tex = texture {
            glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
        }
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func renderUnclear() {
        textureCoordinates = SpriteEngine.notClearedBlock
        glUseProgram(SpriteEngine.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, SmallRenderer.smallQuad)
        glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, textureCoordinates)
        glUniform2f(glGetUniformLocation(SpriteEngine.program, "translation"), startPositionX, startPositionY)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        if let tex = texture {
            glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
        }
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func renderClear() {
        textureCoordinates = SpriteEngine.clearedBlock
        glUseProgram(SpriteEngine.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, SmallRenderer.smallQuad)
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
