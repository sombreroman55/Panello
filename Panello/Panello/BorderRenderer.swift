//
//  BorderRenderer.swift
//  Panello
//
//  Created by Andrew Roberts on 4/20/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class BorderRenderer {
    
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    
    /* Fragment shader coordinates */
    /* Array order is -X +Y -X -Y +X +Y +X -Y */
    private static let border1: [Float] = [ pixel(0), pixel(328), pixel(0), pixel(128),
                                            pixel(103), pixel(328), pixel(103), pixel(128) ]
    private static let border2: [Float] = [ pixel(104), pixel(328), pixel(104), pixel(128),
                                            pixel(207), pixel(328), pixel(207), pixel(128) ]
    private static let border3: [Float] = [ pixel(208), pixel(328), pixel(208), pixel(128),
                                            pixel(311), pixel(328), pixel(311), pixel(128) ]
    private static let border4: [Float] = [ pixel(312), pixel(328), pixel(312), pixel(128),
                                            pixel(415), pixel(328), pixel(415), pixel(128) ]
    private static let border5: [Float] = [ pixel(416), pixel(328), pixel(416), pixel(128),
                                            pixel(519), pixel(328), pixel(519), pixel(128) ]
    private static let border6: [Float] = [ pixel(520), pixel(328), pixel(520), pixel(128),
                                            pixel(623), pixel(328), pixel(623), pixel(128) ]
    
    // Vertex coordinates
    public static let quad: [Float] = [ 0.436, -1.7, 0.436, 0.0, 1.564, -1.7, 1.564, 0.0 ]
    
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
    
    func renderBorder(border: Int) {
        textureCoordinates = getTexture(forBorder: border)
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
    
    func getTexture(forBorder border: Int) -> [Float] {
        switch (border) {
        case 1:
            return BorderRenderer.border1
        case 2:
            return BorderRenderer.border2
        case 3:
            return BorderRenderer.border3
        case 4:
            return BorderRenderer.border4
        case 5:
            return BorderRenderer.border5
        case 6:
            return BorderRenderer.border6
        default:
            return BorderRenderer.border1
        }
    }
    
    private static func pixel(_ pixel: Int) -> Float {
        return Float(2*pixel + 1)/Float(2048)
    }
}
