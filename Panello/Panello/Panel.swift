//
//  Panel.swift
//  Panello
//
//  Created by Andrew Roberts on 4/8/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class Panel {
    
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    // Panel's color
    enum PanelColor {
        case RED
        case YELLOW
        case GREEN
        case CYAN
        case BLUE
        case PURPLE
    }
    
    // State of panel
    enum PanelState {
        case NORMAL
        case FLOATING
        case MATCHED
        case POPPING
        case SWAP_RIGHT
        case SWAP_LEFT
    }

    // Vertex coordinates
    private static let quad: [Float] = [ -0.088, -0.068, -0.088, 0.068, 0.088, -0.068, 0.088, 0.068 ]
    
    // -------------------------------------------------------------------
    // MARK: - Static functions
    // -------------------------------------------------------------------
    
    /* Randomly generate a color for a panel */
    class func getRandomColor() -> PanelColor {
        let choice: Int = 1 + Int(arc4random_uniform(UInt32(6 - 1 + 1)))
        switch (choice) {
        case 1:
            return .RED
        case 2:
            return .YELLOW
        case 3:
            return .GREEN
        case 4:
            return .CYAN
        case 5:
            return .BLUE
        case 6:
            return .PURPLE
        default:
            return .RED
        }
    }
    
    // Texture sheet is 116x154
    // Sprites are 16x16 with 3px padding on all sides
    // Format is WxH
    // X is horizontal, Y is vertical going down
    // Arrays are |TL, BR| |TL, TR| |BL, BR| |BL, TR|
    //            |-X  +Y| |-X  -Y| |+X  +Y| |+X  -Y|
    /* Return the coordinates for the given color's sprite on the spritesheet */
    class func getNormalTexture(forColor color: PanelColor) -> [Float] {
        switch (color) {
        case .PURPLE:
            return SpriteEngine.purpleBlockNormal
        case .BLUE:
            return SpriteEngine.blueBlockNormal
        case .RED:
            return SpriteEngine.redBlockNormal
        case .CYAN:
            return SpriteEngine.cyanBlockNormal
        case .YELLOW:
            return SpriteEngine.yellowBlockNormal
        case .GREEN:
            return SpriteEngine.greenBlockNormal
        }
    }
    
    // -------------------------------------------------------------------
    // MARK: - Instance data
    // -------------------------------------------------------------------
    public var positionX: Float = 0.0
    public var positionY: Float = 0.0
    public var color: PanelColor // The color of the block
    public var state: PanelState // The state of the block
    
    private var texture: GLKTextureInfo? // The texture of the block
    private var textureCoordinates: [Float] // The coordinates of the texture in the sprite sheet
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    init() {
        color = Panel.getRandomColor()
        state = .NORMAL
        
        texture = try? GLKTextureLoader.texture(with: SpriteEngine.image.cgImage!, options: nil)
        textureCoordinates = Panel.getNormalTexture(forColor: color)
        SpriteEngine.setup()
    }
    
    // --------------------------------------------------------------------
    // MARK: - Panel methods
    // --------------------------------------------------------------------
    
    /* Draw the panel */
    func draw() {
        // Send Geometry (attributes)
        // Send any other info (uniforms)
        // Draw
        glUseProgram(SpriteEngine.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, Panel.quad)
        glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, textureCoordinates)
        glUniform2f(glGetUniformLocation(SpriteEngine.program, "translation"), positionX, positionY)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        if let tex = texture {
            glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
        }
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    public func touchedInside(x: Float, y: Float) -> Bool {
        if (x >= (positionX - 0.088) &&
            x <= (positionX + 0.088) &&
            y >= (positionY - 0.068) &&
            y <= (positionY + 0.068)) {
            return true
        }
        return false
    }
}
