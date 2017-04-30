//
//  TextRenderer.swift
//  Panello
//
//  Created by Andrew Roberts on 4/19/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

final class TextRenderer {

    // -------------------------------------------------------------------
    // MARK: - Public instance data
    // -------------------------------------------------------------------
    
    public var startPositionX: Float // Anchor X coordinate
    public var startPositionY: Float // Anchor Y coordinate
    public var currentPositionX: Float // Offset X coordinate based on last character
    public var currentPositionY: Float // Offset Y coordinate based on last character
    public var scale: Float // Scale the letter quad
    public var width: Float
    public var height: Float
    
    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    private var _texture: GLKTextureInfo? // The texture of the character
    private var _textVertexCoordinates: [Float] // The coordinates of the vertex
    private var _textTextureCoordinates: [Float] // The coordinates of the texture in the bitmap
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init(startCoordinateX: Float, startCoordinateY: Float, scale: Float) {
        _texture = try? GLKTextureLoader.texture(with: TextEngine.image.cgImage!, options: nil)
        _textVertexCoordinates = []
        _textTextureCoordinates = []
        startPositionX = startCoordinateX
        startPositionY = startCoordinateY
        currentPositionX = startPositionX
        currentPositionY = startPositionY
        self.scale = scale
        width = 0.0
        height = 0.2 * scale
        TextEngine.setup()
    }
    
    // --------------------------------------------------------------------
    // MARK: - TextRenderer methods
    // --------------------------------------------------------------------
    
    public func touchedInside(x: Float, y: Float) -> Bool {
        if (x >= (startPositionX - (0.1 * scale)) &&
            x <= (startPositionX - (0.1 * scale)) + width &&
            y >= (startPositionY - height/2) &&
            y <= (startPositionY + height/2)) {
            return true
        }
        return false
    }
    
    public func renderLine(text: String) {
        var upper: String = text.uppercased()
        width = (Float(text.characters.count) * 0.2 * scale) + (Float(text.characters.count - 1) * (16/2048))
        for char in upper.characters {
            if (char == "I") {
                _textVertexCoordinates = [ -0.1, -0.1, -0.1, 0.1, 0.03, -0.1, 0.03, 0.1 ]
            }
            else if (char == "1") {
                _textVertexCoordinates = [ -0.1, -0.1, -0.1, 0.1, 0.0, -0.1, 0.0, 0.1 ]
            }
            else if (char == ".") {
                _textVertexCoordinates = [ -0.1, -0.1, -0.1, 0.1, -0.03, -0.1, -0.03, 0.1 ]
            }
            else {
                _textVertexCoordinates = TextEngine.quad
            }
            _textTextureCoordinates = getTexture(forCharacter: char)
            glUseProgram(TextEngine.program)
            glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _textVertexCoordinates)
            glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _textTextureCoordinates)
            glUniform2f(glGetUniformLocation(TextEngine.program, "translation"), currentPositionX, currentPositionY)
            glUniform2f(glGetUniformLocation(TextEngine.program, "scale"), scale, scale)
            glEnableVertexAttribArray(0)
            glEnableVertexAttribArray(1)
            if let tex = _texture {
                glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
            }
            glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
            currentPositionX += ((_textVertexCoordinates[4] - _textVertexCoordinates[0]) * scale) + (16/2048)
        }
        currentPositionX = startPositionX
    }
    
    private func getTexture(forCharacter character: Character) -> [Float] {
        switch(character) {
        case "A":
            return TextEngine.text_A
        case "B":
            return TextEngine.text_B
        case "C":
            return TextEngine.text_C
        case "D":
            return TextEngine.text_D
        case "E":
            return TextEngine.text_E
        case "F":
            return TextEngine.text_F
        case "G":
            return TextEngine.text_G
        case "H":
            return TextEngine.text_H
        case "I":
            return TextEngine.text_I
        case "J":
            return TextEngine.text_J
        case "K":
            return TextEngine.text_K
        case "L":
            return TextEngine.text_L
        case "M":
            return TextEngine.text_M
        case "N":
            return TextEngine.text_N
        case "O":
            return TextEngine.text_O
        case "P":
            return TextEngine.text_P
        case "Q":
            return TextEngine.text_Q
        case "R":
            return TextEngine.text_R
        case "S":
            return TextEngine.text_S
        case "T":
            return TextEngine.text_T
        case "U":
            return TextEngine.text_U
        case "V":
            return TextEngine.text_V
        case "W":
            return TextEngine.text_W
        case "X":
            return TextEngine.text_X
        case "Y":
            return TextEngine.text_Y
        case "Z":
            return TextEngine.text_Z
        case "0":
            return TextEngine.text_0
        case "1":
            return TextEngine.text_1
        case "2":
            return TextEngine.text_2
        case "3":
            return TextEngine.text_3
        case "4":
            return TextEngine.text_4
        case "5":
            return TextEngine.text_5
        case "6":
            return TextEngine.text_6
        case "7":
            return TextEngine.text_7
        case "8":
            return TextEngine.text_8
        case "9":
            return TextEngine.text_9
        case ".":
            return TextEngine.text_period
        case " ":
            return TextEngine.text_alpha
        default:
            return TextEngine.text_A
        }
    }
    
    public func renderNumber(number: Int) {
        var copy: Int = number
        var digit: Int = 0
        while (copy > 0) {
            digit = copy % 10
            if (digit == 1) {
                _textVertexCoordinates = [ -0.1, -0.1, -0.1, 0.1, 0.0, -0.1, 0.0, 0.1 ]
            }
            else {
                _textVertexCoordinates = TextEngine.quad
            }
            _textTextureCoordinates = getTexture(forNumber: digit)
            glUseProgram(TextEngine.program)
            glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _textVertexCoordinates)
            glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _textTextureCoordinates)
            glUniform2f(glGetUniformLocation(TextEngine.program, "translation"), currentPositionX, currentPositionY)
            glUniform2f(glGetUniformLocation(TextEngine.program, "scale"), scale, scale)
            glEnableVertexAttribArray(0)
            glEnableVertexAttribArray(1)
            if let tex = _texture {
                glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
            }
            glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
            currentPositionX -= ((_textVertexCoordinates[4] - _textVertexCoordinates[0]) * scale)
            copy /= 10
        }
        currentPositionX = startPositionX
    }
    
    private func getTexture(forNumber digit: Int) -> [Float] {
        switch (digit) {
        case 0:
            return TextEngine.text_0
        case 1:
            return TextEngine.text_1
        case 2:
            return TextEngine.text_2
        case 3:
            return TextEngine.text_3
        case 4:
            return TextEngine.text_4
        case 5:
            return TextEngine.text_5
        case 6:
            return TextEngine.text_6
        case 7:
            return TextEngine.text_7
        case 8:
            return TextEngine.text_8
        case 9:
            return TextEngine.text_9
        default:
            return TextEngine.text_0
        }
    }
}
