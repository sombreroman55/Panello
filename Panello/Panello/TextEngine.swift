//
//  TextEngine.swift
//  Panello
//
//  Created by Andrew Roberts on 4/29/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

final class TextEngine {
    
    public static var program: GLuint = 0
    // Text bitmap spritesheet
    public static let image: UIImage = UIImage(named: "assets.png")!
    // Vertex coordinates
    public static let quad: [Float] = [ -0.1, -0.1, -0.1, 0.1, 0.1, -0.1, 0.1, 0.1 ]

    /* Setup the OpenGL program if necessary. Compiles and links vertex and fragment shaders. */
    public static func setup() {
        
        if (program != 0) {
            return
        }
        
        // Vertex Shader
        let borderVertexShaderPath: String = Bundle.main.path(forResource: "TextVertex", ofType: "glsl", inDirectory: nil)!
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
        let borderFragmentShaderPath: String = Bundle.main.path(forResource: "TextFragment", ofType: "glsl", inDirectory: nil)!
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
    
    /* Fragment shader coordinates */
    /* Array order is -X +Y -X -Y +X +Y +X -Y */
    // Upper case letters
    public static let text_A: [Float] = [ pixel(0), pixel(470), pixel(0), pixel(443),
                                          pixel(23), pixel(470), pixel(23), pixel(443) ]
    public static let text_B: [Float] = [ pixel(25), pixel(470), pixel(25), pixel(443),
                                          pixel(48), pixel(470), pixel(48), pixel(443) ]
    public static let text_C: [Float] = [ pixel(50), pixel(470), pixel(50), pixel(443),
                                          pixel(73), pixel(470), pixel(73), pixel(443) ]
    public static let text_D: [Float] = [ pixel(75), pixel(470), pixel(75), pixel(443),
                                          pixel(98), pixel(470), pixel(98), pixel(443) ]
    public static let text_E: [Float] = [ pixel(100), pixel(470), pixel(100), pixel(443),
                                          pixel(123), pixel(470), pixel(123), pixel(443) ]
    public static let text_F: [Float] = [ pixel(125), pixel(470), pixel(125), pixel(443),
                                          pixel(148), pixel(470), pixel(148), pixel(443) ]
    public static let text_G: [Float] = [ pixel(150), pixel(470), pixel(150), pixel(443),
                                          pixel(173), pixel(470), pixel(173), pixel(443) ]
    public static let text_H: [Float] = [ pixel(175), pixel(470), pixel(175), pixel(443),
                                          pixel(198), pixel(470), pixel(198), pixel(443) ]
    public static let text_I: [Float] = [ pixel(200), pixel(470), pixel(200), pixel(443),
                                          pixel(215), pixel(470), pixel(215), pixel(443) ]
    public static let text_J: [Float] = [ pixel(217), pixel(470), pixel(217), pixel(443),
                                          pixel(240), pixel(470), pixel(240), pixel(443) ]
    public static let text_K: [Float] = [ pixel(242), pixel(470), pixel(242), pixel(443),
                                          pixel(265), pixel(470), pixel(265), pixel(443) ]
    public static let text_L: [Float] = [ pixel(267), pixel(470), pixel(267), pixel(443),
                                          pixel(290), pixel(470), pixel(290), pixel(443) ]
    public static let text_M: [Float] = [ pixel(292), pixel(470), pixel(292), pixel(443),
                                          pixel(315), pixel(470), pixel(315), pixel(443) ]
    public static let text_N: [Float] = [ pixel(317), pixel(470), pixel(317), pixel(443),
                                          pixel(340), pixel(470), pixel(340), pixel(443) ]
    public static let text_O: [Float] = [ pixel(342), pixel(470), pixel(342), pixel(443),
                                          pixel(365), pixel(470), pixel(365), pixel(443) ]
    public static let text_P: [Float] = [ pixel(367), pixel(470), pixel(367), pixel(443),
                                          pixel(390), pixel(470), pixel(390), pixel(443) ]
    public static let text_Q: [Float] = [ pixel(392), pixel(470), pixel(392), pixel(443),
                                          pixel(415), pixel(470), pixel(415), pixel(443) ]
    public static let text_R: [Float] = [ pixel(417), pixel(470), pixel(417), pixel(443),
                                          pixel(440), pixel(470), pixel(440), pixel(443) ]
    public static let text_S: [Float] = [ pixel(442), pixel(470), pixel(442), pixel(443),
                                          pixel(465), pixel(470), pixel(465), pixel(443) ]
    public static let text_T: [Float] = [ pixel(467), pixel(470), pixel(467), pixel(443),
                                          pixel(490), pixel(470), pixel(490), pixel(443) ]
    public static let text_U: [Float] = [ pixel(492), pixel(470), pixel(492), pixel(443),
                                          pixel(515), pixel(470), pixel(515), pixel(443) ]
    public static let text_V: [Float] = [ pixel(517), pixel(470), pixel(517), pixel(443),
                                          pixel(540), pixel(470), pixel(540), pixel(443) ]
    public static let text_W: [Float] = [ pixel(542), pixel(470), pixel(542), pixel(443),
                                          pixel(565), pixel(470), pixel(565), pixel(443) ]
    public static let text_X: [Float] = [ pixel(567), pixel(470), pixel(567), pixel(443),
                                          pixel(590), pixel(470), pixel(590), pixel(443) ]
    public static let text_Y: [Float] = [ pixel(592), pixel(470), pixel(592), pixel(443),
                                          pixel(615), pixel(470), pixel(615), pixel(443) ]
    public static let text_Z: [Float] = [ pixel(617), pixel(470), pixel(617), pixel(443),
                                          pixel(640), pixel(470), pixel(640), pixel(443) ]
    
    // Numbers
    public static let text_0: [Float] = [ pixel(0), pixel(524), pixel(0), pixel(505),
                                          pixel(23), pixel(524), pixel(23), pixel(505) ]
    public static let text_1: [Float] = [ pixel(25), pixel(524), pixel(25), pixel(505),
                                          pixel(36), pixel(524), pixel(36), pixel(505) ]
    public static let text_2: [Float] = [ pixel(38), pixel(524), pixel(38), pixel(505),
                                          pixel(61), pixel(524), pixel(61), pixel(505) ]
    public static let text_3: [Float] = [ pixel(63), pixel(524), pixel(63), pixel(505),
                                          pixel(86), pixel(524), pixel(86), pixel(505) ]
    public static let text_4: [Float] = [ pixel(88), pixel(524), pixel(88), pixel(505),
                                          pixel(111), pixel(524), pixel(111), pixel(505) ]
    public static let text_5: [Float] = [ pixel(113), pixel(524), pixel(113), pixel(505),
                                          pixel(136), pixel(524), pixel(136), pixel(505) ]
    public static let text_6: [Float] = [ pixel(138), pixel(524), pixel(138), pixel(505),
                                          pixel(161), pixel(524), pixel(161), pixel(505) ]
    public static let text_7: [Float] = [ pixel(163), pixel(524), pixel(163), pixel(505),
                                          pixel(186), pixel(524), pixel(186), pixel(505) ]
    public static let text_8: [Float] = [ pixel(188), pixel(524), pixel(188), pixel(505),
                                          pixel(211), pixel(524), pixel(211), pixel(505) ]
    public static let text_9: [Float] = [ pixel(213), pixel(524), pixel(213), pixel(505),
                                          pixel(236), pixel(524), pixel(236), pixel(505) ]
    
    public static let text_period: [Float] = [ pixel(100), pixel(553), pixel(100), pixel(526),
                                               pixel(107), pixel(553), pixel(107), pixel(526) ]
    public static let text_alpha: [Float] = [ pixel(240), pixel(240), pixel(240), pixel(240),
                                              pixel(240), pixel(240), pixel(240), pixel(240) ]
}
