//
//  SpriteEngine.swift
//  Panello
//
//  Created by Andrew Roberts on 4/28/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

final class SpriteEngine {
    
    public static var program: GLuint = 0
    // Text bitmap spritesheet
    public static let image: UIImage = UIImage(named: "assets.png")!
    
    /* Setup the OpenGL program if necessary. Compiles and links vertex and fragment shaders. */
    public static func setup() {
        
        if (program != 0) {
            return
        }
        
        // Vertex Shader
        let borderVertexShaderPath: String = Bundle.main.path(forResource: "SpriteVertex", ofType: "glsl", inDirectory: nil)!
        let borderVertexShaderSource: NSString = try! NSString(contentsOfFile: borderVertexShaderPath, encoding: String.Encoding.utf8.rawValue)
        var borderVertexShaderData = borderVertexShaderSource.cString(using: String.Encoding.utf8.rawValue)
        
        let borderVertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
        
        glShaderSource(borderVertexShader, 1, &borderVertexShaderData, nil)
        glCompileShader(borderVertexShader)
        
        // check if compilation succeeded
        var borderVertexShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(borderVertexShader, GLenum(GL_COMPILE_STATUS), &borderVertexShaderCompileStatus)
        if (borderVertexShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(borderVertexShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(borderVertexShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Border vertex shader compilation successful.")
        }
        
        
        // Fragment Shader
        let borderFragmentShaderPath: String = Bundle.main.path(forResource: "SpriteFragment", ofType: "glsl", inDirectory: nil)!
        let borderFragmentShaderSource: NSString = try! NSString(contentsOfFile: borderFragmentShaderPath, encoding: String.Encoding.utf8.rawValue)
        var borderFragmentShaderData = borderFragmentShaderSource.cString(using: String.Encoding.utf8.rawValue)
        
        let borderFragmentShader: GLuint = glCreateShader(GLenum(GL_FRAGMENT_SHADER))
        
        // why is nil allowed??
        glShaderSource(borderFragmentShader, 1, &borderFragmentShaderData, nil)
        glCompileShader(borderFragmentShader)
        
        // check if compilation succeeded
        var borderFragmentShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(borderFragmentShader, GLenum(GL_COMPILE_STATUS), &borderFragmentShaderCompileStatus)
        if (borderFragmentShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(borderFragmentShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(borderFragmentShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Border fragment shader compilation successful.")
        }
        
        
        // Compile Program
        program = glCreateProgram()
        glAttachShader(program, borderVertexShader)
        glAttachShader(program, borderFragmentShader)
        glBindAttribLocation(program, 0, "position")
        glBindAttribLocation(program, 1, "texture")
        glLinkProgram(program)
        
        
        var borderProgramLinkStatus: GLint = GL_FALSE
        glGetProgramiv(program, GLenum(GL_LINK_STATUS), &borderProgramLinkStatus)
        if (borderProgramLinkStatus == GL_FALSE) {
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetProgramiv(program, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetProgramInfoLog(program, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Linking failed.")
        }
    }
    
    private static func pixel(_ pixel: Int) -> Float {
        return Float(2*pixel + 1)/Float(2048)
    }
    
    /* Vertices */
    //public static let blockQuad: [Float] // blocks and exloding blocks
    //public static let borderQuad: [Float]
    //public static let clearFlagQuad: [Float]
    //public static let stopFlagQuad: [Float]
    //public static let smallQuad: [Float] // small border, unclear, clear, cursor
    //public static let popupQuad: [Float]
    
    /* Texture */
    public static let purpleBlockNormal: [Float] = [ pixel(0), pixel(15), pixel(0), pixel(0),
                                                     pixel(15), pixel(15), pixel(15), pixel(0) ]
    public static let purpleBlockUp: [Float] = [ pixel(0), pixel(31), pixel(0), pixel(16),
                                                 pixel(15), pixel(31), pixel(15), pixel(16) ]
    public static let purpleBlockTop: [Float] = [ pixel(0), pixel(47), pixel(0), pixel(32),
                                                  pixel(15), pixel(47), pixel(15), pixel(32) ]
    public static let purpleBlockSquish: [Float] = [ pixel(0), pixel(63), pixel(0), pixel(48),
                                                     pixel(15), pixel(63), pixel(15), pixel(48) ]
    public static let purpleBlockDark: [Float] = [ pixel(0), pixel(79), pixel(0), pixel(64),
                                                   pixel(15), pixel(79), pixel(15), pixel(64) ]
    public static let purpleBlockFace: [Float] = [ pixel(0), pixel(95), pixel(0), pixel(80),
                                                   pixel(15), pixel(95), pixel(15), pixel(80) ]
    public static let purpleBlockWhite: [Float] = [ pixel(0), pixel(111), pixel(0), pixel(96),
                                                    pixel(15), pixel(111), pixel(15), pixel(96) ]
    public static let purpleBlockBlack: [Float] = [ pixel(0), pixel(127), pixel(0), pixel(112),
                                                    pixel(15), pixel(127), pixel(15), pixel(112) ]
    
    public static let blueBlockNormal: [Float] = [ pixel(16), pixel(15), pixel(16), pixel(0),
                                                   pixel(31), pixel(15), pixel(31), pixel(0) ]
    public static let blueBlockUp: [Float] = [ pixel(16), pixel(31), pixel(16), pixel(16),
                                               pixel(31), pixel(31), pixel(31), pixel(16) ]
    public static let blueBlockTop: [Float] = [ pixel(16), pixel(47), pixel(16), pixel(32),
                                                pixel(31), pixel(47), pixel(31), pixel(32) ]
    public static let blueBlockSquish: [Float] = [ pixel(16), pixel(63), pixel(16), pixel(48),
                                                   pixel(31), pixel(63), pixel(31), pixel(48) ]
    public static let blueBlockDark: [Float] = [ pixel(16), pixel(79), pixel(16), pixel(64),
                                                 pixel(31), pixel(79), pixel(31), pixel(64) ]
    public static let blueBlockFace: [Float] = [ pixel(16), pixel(95), pixel(16), pixel(80),
                                                 pixel(31), pixel(95), pixel(31), pixel(80) ]
    public static let blueBlockWhite: [Float] = [ pixel(16), pixel(111), pixel(16), pixel(96),
                                                  pixel(31), pixel(111), pixel(31), pixel(96) ]
    public static let blueBlockBlack: [Float] = [ pixel(16), pixel(127), pixel(16), pixel(112),
                                                  pixel(31), pixel(127), pixel(31), pixel(112) ]
    
    public static let redBlockNormal: [Float] = [ pixel(32), pixel(15), pixel(32), pixel(0),
                                                  pixel(47), pixel(15), pixel(47), pixel(0) ]
    public static let redBlockUp: [Float] = [ pixel(32), pixel(31), pixel(32), pixel(16),
                                              pixel(47), pixel(31), pixel(47), pixel(16) ]
    public static let redBlockTop: [Float] = [ pixel(32), pixel(47), pixel(32), pixel(32),
                                               pixel(47), pixel(47), pixel(47), pixel(32) ]
    public static let redBlockSquish: [Float] = [ pixel(32), pixel(63), pixel(32), pixel(48),
                                                  pixel(47), pixel(63), pixel(47), pixel(48) ]
    public static let redBlockDark: [Float] = [ pixel(32), pixel(79), pixel(32), pixel(64),
                                                pixel(47), pixel(79), pixel(47), pixel(64) ]
    public static let redBlockFace: [Float] = [ pixel(32), pixel(95), pixel(32), pixel(80),
                                                pixel(47), pixel(95), pixel(47), pixel(80) ]
    public static let redBlockWhite: [Float] = [ pixel(32), pixel(111), pixel(32), pixel(96),
                                                 pixel(47), pixel(111), pixel(47), pixel(96) ]
    public static let redBlockBlack: [Float] = [ pixel(32), pixel(127), pixel(32), pixel(112),
                                                 pixel(47), pixel(127), pixel(47), pixel(112) ]
    
    public static let cyanBlockNormal: [Float] = [ pixel(48), pixel(15), pixel(48), pixel(0),
                                                   pixel(63), pixel(15), pixel(63), pixel(0) ]
    public static let cyanBlockUp: [Float] = [ pixel(48), pixel(31), pixel(48), pixel(16),
                                               pixel(63), pixel(31), pixel(63), pixel(16) ]
    public static let cyanBlockTop: [Float] = [ pixel(48), pixel(47), pixel(48), pixel(32),
                                                pixel(63), pixel(47), pixel(63), pixel(32) ]
    public static let cyanBlockSquish: [Float] = [ pixel(48), pixel(63), pixel(48), pixel(48),
                                                   pixel(63), pixel(63), pixel(63), pixel(48) ]
    public static let cyanBlockDark: [Float] = [ pixel(48), pixel(79), pixel(48), pixel(64),
                                                 pixel(63), pixel(79), pixel(63), pixel(64) ]
    public static let cyanBlockFace: [Float] = [ pixel(48), pixel(95), pixel(48), pixel(80),
                                                 pixel(63), pixel(95), pixel(63), pixel(80) ]
    public static let cyanBlockWhite: [Float] = [ pixel(48), pixel(111), pixel(48), pixel(96),
                                                  pixel(63), pixel(111), pixel(63), pixel(96) ]
    public static let cyanBlockBlack: [Float] = [ pixel(48), pixel(127), pixel(48), pixel(112),
                                                    pixel(63), pixel(127), pixel(63), pixel(112) ]
    
    public static let yellowBlockNormal: [Float] = [ pixel(64), pixel(15), pixel(64), pixel(0),
                                                     pixel(79), pixel(15), pixel(79), pixel(0) ]
    public static let yellowBlockUp: [Float] = [ pixel(64), pixel(31), pixel(64), pixel(16),
                                                 pixel(79), pixel(31), pixel(79), pixel(16) ]
    public static let yellowBlockTop: [Float] = [ pixel(64), pixel(47), pixel(64), pixel(32),
                                                  pixel(79), pixel(47), pixel(79), pixel(32) ]
    public static let yellowBlockSquish: [Float] = [ pixel(64), pixel(63), pixel(64), pixel(48),
                                                     pixel(79), pixel(63), pixel(79), pixel(48) ]
    public static let yellowBlockDark: [Float] = [ pixel(64), pixel(79), pixel(64), pixel(64),
                                                   pixel(79), pixel(79), pixel(79), pixel(64) ]
    public static let yellowBlockFace: [Float] = [ pixel(64), pixel(95), pixel(64), pixel(80),
                                                   pixel(79), pixel(95), pixel(79), pixel(80) ]
    public static let yellowBlockWhite: [Float] = [ pixel(64), pixel(111), pixel(64), pixel(96),
                                                    pixel(79), pixel(111), pixel(79), pixel(96) ]
    public static let yellowBlockBlack: [Float] = [ pixel(64), pixel(127), pixel(64), pixel(112),
                                                    pixel(79), pixel(127), pixel(79), pixel(112) ]
    
    public static let greenBlockNormal: [Float] = [ pixel(80), pixel(15), pixel(80), pixel(0),
                                                    pixel(95), pixel(15), pixel(95), pixel(0) ]
    public static let greenBlockUp: [Float] = [ pixel(80), pixel(31), pixel(80), pixel(16),
                                                pixel(95), pixel(31), pixel(95), pixel(16) ]
    public static let greenBlockTop: [Float] = [ pixel(80), pixel(47), pixel(80), pixel(32),
                                                 pixel(95), pixel(47), pixel(95), pixel(32) ]
    public static let greenBlockSquish: [Float] = [ pixel(80), pixel(63), pixel(80), pixel(48),
                                                    pixel(95), pixel(63), pixel(95), pixel(48) ]
    public static let greenBlockDark: [Float] = [ pixel(80), pixel(79), pixel(80), pixel(64),
                                                  pixel(95), pixel(79), pixel(95), pixel(64) ]
    public static let greenBlockFace: [Float] = [ pixel(80), pixel(95), pixel(80), pixel(80),
                                                  pixel(95), pixel(95), pixel(95), pixel(80) ]
    public static let greenBlockWhite: [Float] = [ pixel(80), pixel(111), pixel(80), pixel(96),
                                                   pixel(95), pixel(111), pixel(95), pixel(96) ]
    public static let greenBlockBlack: [Float] = [ pixel(80), pixel(127), pixel(80), pixel(112),
                                                   pixel(95), pixel(127), pixel(95), pixel(112) ]
    
    public static let clearFlag: [Float] = [ pixel(0), pixel(340), pixel(0), pixel(329),
                                             pixel(39), pixel(340), pixel(39), pixel(329) ]
    public static let stopFlag: [Float] = [ pixel(0), pixel(356), pixel(0), pixel(341),
                                            pixel(28), pixel(356), pixel(28), pixel(341) ]
    public static let smallBorder: [Float] = [ pixel(0), pixel(376), pixel(0), pixel(357),
                                               pixel(19), pixel(376), pixel(19), pixel(357) ]
    public static let notClearedBlock: [Float] = [ pixel(20), pixel(376), pixel(20), pixel(357),
                                                   pixel(39), pixel(376), pixel(39), pixel(357) ]
    public static let clearedBlock: [Float] = [ pixel(40), pixel(376), pixel(40), pixel(357),
                                                pixel(59), pixel(376), pixel(59), pixel(357) ]
    public static let cursor: [Float] = [ pixel(0), pixel(396), pixel(0), pixel(377),
                                          pixel(19), pixel(396), pixel(19), pixel(377) ]
    
    public static let combo4: [Float] = [ pixel(0), pixel(411), pixel(0), pixel(397),
                                          pixel(15), pixel(411), pixel(15), pixel(397) ]
    public static let combo5: [Float] = [ pixel(16), pixel(411), pixel(16), pixel(397),
                                          pixel(31), pixel(411), pixel(31), pixel(397) ]
    public static let combo6: [Float] = [ pixel(32), pixel(411), pixel(32), pixel(397),
                                          pixel(47), pixel(411), pixel(47), pixel(397) ]
    public static let combo9: [Float] = [ pixel(48), pixel(411), pixel(48), pixel(397),
                                          pixel(63), pixel(411), pixel(63), pixel(397) ]
    public static let combo10: [Float] = [ pixel(64), pixel(411), pixel(64), pixel(397),
                                           pixel(79), pixel(411), pixel(79), pixel(397) ]
    public static let combo12: [Float] = [ pixel(80), pixel(411), pixel(80), pixel(397),
                                           pixel(95), pixel(411), pixel(95), pixel(397) ]
    public static let combo14: [Float] = [ pixel(96), pixel(411), pixel(96), pixel(397),
                                           pixel(111), pixel(411), pixel(111), pixel(397) ]
    public static let combo18: [Float] = [ pixel(112), pixel(411), pixel(112), pixel(397),
                                           pixel(127), pixel(411), pixel(127), pixel(397) ]
    
    public static let chain2: [Float] = [ pixel(0), pixel(426), pixel(0), pixel(412),
                                          pixel(15), pixel(426), pixel(15), pixel(412) ]
    public static let chain3: [Float] = [ pixel(16), pixel(426), pixel(16), pixel(412),
                                          pixel(31), pixel(426), pixel(31), pixel(412) ]
    public static let chain4: [Float] = [ pixel(32), pixel(426), pixel(32), pixel(412),
                                          pixel(47), pixel(426), pixel(47), pixel(412) ]
    public static let chain5: [Float] = [ pixel(48), pixel(426), pixel(48), pixel(412),
                                          pixel(63), pixel(426), pixel(63), pixel(412) ]
    public static let chain6: [Float] = [ pixel(64), pixel(426), pixel(64), pixel(412),
                                          pixel(79), pixel(426), pixel(79), pixel(412) ]
    public static let chain7: [Float] = [ pixel(80), pixel(426), pixel(80), pixel(412),
                                          pixel(95), pixel(426), pixel(95), pixel(412) ]
    public static let chain8: [Float] = [ pixel(96), pixel(426), pixel(96), pixel(412),
                                          pixel(111), pixel(426), pixel(111), pixel(412) ]
    public static let chain9: [Float] = [ pixel(112), pixel(426), pixel(112), pixel(412),
                                          pixel(127), pixel(426), pixel(127), pixel(412) ]

    public static let popFrame1: [Float] = [ pixel(0), pixel(442), pixel(0), pixel(427),
                                             pixel(13), pixel(442), pixel(13), pixel(427) ]
    public static let popFrame2: [Float] = [ pixel(15), pixel(442), pixel(15), pixel(427),
                                             pixel(21), pixel(442), pixel(21), pixel(427) ]
    public static let popFrame3: [Float] = [ pixel(23), pixel(442), pixel(23), pixel(427),
                                             pixel(29), pixel(442), pixel(29), pixel(427) ]
    public static let popFrame4: [Float] = [ pixel(31), pixel(442), pixel(31), pixel(427),
                                             pixel(37), pixel(442), pixel(37), pixel(427) ]
    public static let popFrame5: [Float] = [ pixel(39), pixel(442), pixel(39), pixel(427),
                                             pixel(45), pixel(442), pixel(45), pixel(427) ]
}
