//
//  BackgroundEngine.swift
//  Panello
//
//  Created by Andrew Roberts on 4/29/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

final class BackgroundEngine {
    
    public static var program: GLuint = 0

    /* Set up the OpenGL program if necessary */
    public static func setup() {
    
        if (program != 0) {
            return
        }
    
        // Vertex Shader
        let backgroundVertexShaderPath: String = Bundle.main.path(forResource: "BackgroundVertex", ofType: "glsl", inDirectory: nil)!
        let backgroundVertexShaderSource: NSString = try! NSString(contentsOfFile: backgroundVertexShaderPath, encoding: String.Encoding.utf8.rawValue)
        var backgroundVertexShaderData = backgroundVertexShaderSource.cString(using: String.Encoding.utf8.rawValue)
    
        let backgroundVertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
    
        // why is nil allowed??
        glShaderSource(backgroundVertexShader, 1, &backgroundVertexShaderData, nil)
        glCompileShader(backgroundVertexShader)
    
        // check if compilation succeeded
        var backgroundVertexShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(backgroundVertexShader, GLenum(GL_COMPILE_STATUS), &backgroundVertexShaderCompileStatus)
        if (backgroundVertexShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(backgroundVertexShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(backgroundVertexShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Background vertex shader compilation successful.")
        }
    
    
        // Fragment Shader
        let backgroundFragmentShaderPath: String = Bundle.main.path(forResource: "BackgroundFragment", ofType: "glsl", inDirectory: nil)!
        let backgroundFragmentShaderSource: NSString = try! NSString(contentsOfFile: backgroundFragmentShaderPath, encoding: String.Encoding.utf8.rawValue)
        var backgroundFragmentShaderData = backgroundFragmentShaderSource.cString(using: String.Encoding.utf8.rawValue)
    
        let backgroundFragmentShader: GLuint = glCreateShader(GLenum(GL_FRAGMENT_SHADER))
    
        // why is nil allowed??
        glShaderSource(backgroundFragmentShader, 1, &backgroundFragmentShaderData, nil)
        glCompileShader(backgroundFragmentShader)
    
        // check if compilation succeeded
        var backgroundFragmentShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(backgroundFragmentShader, GLenum(GL_COMPILE_STATUS), &backgroundFragmentShaderCompileStatus)
        if (backgroundFragmentShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(backgroundFragmentShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(backgroundFragmentShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Background fragment shader compilation successful.")
        }
    
    
        // Compile Program
        program = glCreateProgram()
        glAttachShader(program, backgroundVertexShader)
        glAttachShader(program, backgroundFragmentShader)
        glBindAttribLocation(program, 0, "position")
        glBindAttribLocation(program, 1, "color")
        glLinkProgram(program)
    
    
        var backgroundProgramLinkStatus: GLint = GL_FALSE
        glGetProgramiv(program, GLenum(GL_LINK_STATUS), &backgroundProgramLinkStatus)
        if (backgroundProgramLinkStatus == GL_FALSE) {
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetProgramiv(program, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetProgramInfoLog(program, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Linking failed.")
        }
    }
    
    public static let previewQuad1: [Float] = [ -0.38, 0.28,
                                                -0.14, 0.28,
                                                -0.38, 0.52,
                                                -0.14, 0.52 ]
    public static let previewQuad2: [Float] = [ 0.24, 0.28,
                                                0.48, 0.28,
                                                0.24, 0.52,
                                                0.48, 0.52 ]
    public static let previewQuad3: [Float] = [ -0.38, -0.22,
                                                -0.14, -0.22,
                                                -0.38, 0.02,
                                                -0.14, 0.02 ]
    public static let previewQuad4: [Float] = [ 0.24, -0.22,
                                                0.48, -0.22,
                                                0.24, 0.02,
                                                0.48, 0.02 ]
    public static let previewQuad5: [Float] = [ -0.38, -0.72,
                                                -0.14, -0.72,
                                                -0.38, -0.48,
                                                -0.14, -0.48 ]
    public static let previewQuad6: [Float] = [ 0.24, -0.72,
                                                0.48, -0.72,
                                                0.24, -0.48,
                                                0.48, -0.48 ]

    public static let menuQuad: [Float] = [ -1.0, -1.0,
                                            1.0, -1.0,
                                            -1.0, 1.0,
                                            1.0, 1.0 ]
    public static let gameQuad: [Float] = [ -1.0, -1.0,
                                            1.0, -1.0,
                                            -1.0, 0.7,
                                            1.0, 0.7 ]
    
    /* Menu Background designs */
    
    // Title Menu - reddish
    public static let menuBackground1: [Float] = [ (226/255), (86/255), (68/255), 1.0,
                                                    (226/255), (86/255), (68/255), 1.0,
                                                    (226/255), (86/255), (68/255), 1.0,
                                                    (226/255), (86/255), (68/255), 1.0 ]
    
    // Main Menu Menu - red
    public static let menuBackground2: [Float] = [ (244/255), (66/255), (66/255), 1.0,
                                                    (244/255), (66/255), (66/255), 1.0,
                                                    (244/255), (66/255), (66/255), 1.0,
                                                    (244/255), (66/255), (66/255), 1.0 ]
    
    // Background Select - pinkish
    public static let menuBackground3: [Float] = [ (226/255), (68/255), (136/255), 1.0,
                                                    (226/255), (68/255), (136/255), 1.0,
                                                    (226/255), (68/255), (136/255), 1.0,
                                                    (226/255), (68/255), (136/255), 1.0 ]
    // Time Select - orangeish
    public static let menuBackground4: [Float] = [ (226/255), (152/255), (68/255), 1.0,
                                                    (226/255), (152/255), (68/255), 1.0,
                                                    (226/255), (152/255), (68/255), 1.0,
                                                    (226/255), (152/255), (68/255), 1.0 ]
    
    // Stage Select - green
    public static let menuBackground5: [Float] = [ (68/255), (226/255), (70/255), 1.0,
                                                    (68/255), (226/255), (70/255), 1.0,
                                                    (68/255), (226/255), (70/255), 1.0,
                                                    (68/255), (226/255), (70/255), 1.0, ]
    
    // Puzzle Select - turquoise
    public static let menuBackground6: [Float] = [ (68/255), (226/255), (192/255), 1.0,
                                                    (68/255), (226/255), (192/255), 1.0,
                                                    (68/255), (226/255), (192/255), 1.0,
                                                    (68/255), (226/255), (192/255), 1.0, ]
    
    // High Score - light blue
    public static let menuBackground7: [Float] = [ (68/255), (160/255), (226/255), 1.0,
                                                   (68/255), (160/255), (226/255), 1.0,
                                                   (68/255), (160/255), (226/255), 1.0,
                                                   (68/255), (160/255), (226/255), 1.0, ]
    
    // Tutorial - dark blue
    public static let menuBackground8: [Float] = [ (66/255), (69/255), (244/255), 1.0,
                                                    (66/255), (69/255), (244/255), 1.0,
                                                    (66/255), (69/255), (244/255), 1.0,
                                                    (66/255), (69/255), (244/255), 1.0, ]
    
    // Credits - purple
    public static let menuBackground9: [Float] = [ (139/255), (68/255), (226/255), 1.0,
                                                    (139/255), (68/255), (226/255), 1.0,
                                                    (139/255), (68/255), (226/255), 1.0,
                                                    (139/255), (68/255), (226/255), 1.0 ]
    
    /* Game Background designs */
    
    // Background 1 - displayed with Border 1          R          G          B       A
    public static let gameBackground1: [Float] = [ (242/255), (175/255), (113/255), 1.0,
                                                   (242/255), (175/255), (113/255), 1.0,
                                                   (242/255), (118/255), (145/255), 1.0,
                                                   (242/255), (118/255), (145/255), 1.0 ]
    
    // Background 2 - displayed with Border 2
    public static let gameBackground2: [Float] = [ (186/255), (52/255), (119/255), 1.0,
                                                   (186/255), (52/255), (119/255), 1.0,
                                                   (96/255), (52/255), (186/255), 1.0,
                                                   (96/255), (52/255), (186/255), 1.0 ]
    
    // Background 3 - displayed with Border 3
    public static let gameBackground3: [Float] = [ (132/255), (92/255), (27/255), 1.0,
                                                   (132/255), (92/255), (27/255), 1.0,
                                                   (88/255), (206/255), (84/255), 1.0,
                                                   (88/255), (206/255), (84/255), 1.0 ]
    
    // Background 4 - displayed with Border 4
    public static let gameBackground4: [Float] = [ (42/255), (211/255), (163/255), 1.0,
                                                   (42/255), (211/255), (163/255), 1.0,
                                                   (224/255), (80/255), (186/255), 1.0,
                                                   (224/255), (80/255), (186/255), 1.0 ]
    
    // Background 5 - displayed with Border 5
    public static let gameBackground5: [Float] = [ (234/255), (124/255), (28/255), 1.0,
                                                   (234/255), (124/255), (28/255), 1.0,
                                                   (183/255), (36/255), (36/255), 1.0,
                                                   (183/255), (36/255), (36/255), 1.0 ]
    
    // Background 6 - displayed with Border 6
    public static let gameBackground6: [Float] = [ (0/255), (1/255), (56/255), 1.0,
                                                   (0/255), (1/255), (56/255), 1.0,
                                                   (0/255), (4/255), (122/255), 1.0,
                                                   (0/255), (4/255), (122/255), 1.0 ]
    
}
