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
    private static let border1: [Float] = [ (0/624), (201/201), (0/624), (0/201),
                                            (104/624), (201/201), (104/624), (0/201) ]
    private static let border2: [Float] = [ (104/624), (201/201), (104/624), (0/201),
                                            (208/624), (201/201), (208/624), (0/201) ]
    private static let border3: [Float] = [ (208/624), (201/201), (208/624), (0/201),
                                            (312/624), (201/201), (312/624), (0/201) ]
    private static let border4: [Float] = [ (312/624), (201/201), (312/624), (0/201),
                                            (416/624), (201/201), (416/624), (0/201) ]
    private static let border5: [Float] = [ (416/624), (201/201), (416/624), (0/201),
                                            (520/624), (201/201), (520/624), (0/201) ]
    private static let border6: [Float] = [ (520/624), (201/201), (520/624), (0/201),
                                            (624/624), (201/201), (624/624), (0/201) ]
    
    // Border bitmap spritesheet
    private static let image: UIImage = UIImage(named: "borders.png")!
    // Vertex coordinates
    private static let quad: [Float] = [ 0.0, -1.7, 0.0, 0.0, 2.0, -1.7, 2.0, 0.0 ]
    
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
        texture = try? GLKTextureLoader.texture(with: BorderRenderer.image.cgImage!, options: nil)
        textureCoordinates = []
        startPositionX = startCoordinateX
        startPositionY = startCoordinateY
        SpriteEngine.setup()
    }
    
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
}
