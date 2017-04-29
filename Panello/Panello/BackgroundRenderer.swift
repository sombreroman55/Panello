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
    // MARK: - Static members
    // -------------------------------------------------------------------
    public static var program: GLuint = 0
    private static let menuQuad: [Float] = [ -1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0 ]
    private static let gameQuad: [Float] = [ -1.0, -1.0, 1.0, -1.0, -1.0, 0.7, 1.0, 0.7 ]
    
    /* Menu Background designs */
    
    // Title Menu
    private static let menuBackground1: [Float] = [ (226/255), (86/255), (68/255), 1.0,
                                                    (226/255), (86/255), (68/255), 1.0,
                                                    (226/255), (86/255), (68/255), 1.0,
                                                    (226/255), (86/255), (68/255), 1.0 ]
    
    // Main Menu Menu
    private static let menuBackground2: [Float] = [ (244/255), (66/255), (66/255), 1.0,
                                                    (244/255), (66/255), (66/255), 1.0,
                                                    (244/255), (66/255), (66/255), 1.0,
                                                    (244/255), (66/255), (66/255), 1.0 ]
    
    // Background Select
    private static let menuBackground3: [Float] = [ (226/255), (68/255), (136/255), 1.0,
                                                    (226/255), (68/255), (136/255), 1.0,
                                                    (226/255), (68/255), (136/255), 1.0,
                                                    (226/255), (68/255), (136/255), 1.0 ]
    // Time Select
    private static let menuBackground4: [Float] = [ (226/255), (152/255), (68/255), 1.0,
                                                    (226/255), (152/255), (68/255), 1.0,
                                                    (226/255), (152/255), (68/255), 1.0,
                                                    (226/255), (152/255), (68/255), 1.0 ]
    
    // Stage Select
    private static let menuBackground5: [Float] = [ (68/255), (226/255), (70/255), 1.0,
                                                    (68/255), (226/255), (70/255), 1.0,
                                                    (68/255), (226/255), (70/255), 1.0,
                                                    (68/255), (226/255), (70/255), 1.0, ]
    
    // Puzzle Select
    private static let menuBackground6: [Float] = [ (68/255), (226/255), (192/255), 1.0,
                                                    (68/255), (226/255), (192/255), 1.0,
                                                    (68/255), (226/255), (192/255), 1.0,
                                                    (68/255), (226/255), (192/255), 1.0, ]
    
    // Tutorial
    private static let menuBackground7: [Float] = [ (68/255), (160/255), (226/255), 1.0,
                                                    (68/255), (160/255), (226/255), 1.0,
                                                    (68/255), (160/255), (226/255), 1.0,
                                                    (68/255), (160/255), (226/255), 1.0, ]
    
    // Credits
    private static let menuBackground8: [Float] = [ (139/255), (68/255), (226/255), 1.0,
                                                    (139/255), (68/255), (226/255), 1.0,
                                                    (139/255), (68/255), (226/255), 1.0,
                                                    (139/255), (68/255), (226/255), 1.0, ]
    
    /* Game Background designs */
    
    // Background 1 - Blue to red
    private static let gameBackground1: [Float] = [ 0.7, 0.0, 0.0, 1.0,
                                                    0.7, 0.0, 0.0, 1.0,
                                                    0.0, 0.0, 0.7, 1.0,
                                                    0.0, 0.0, 0.7, 1.0 ]
    
    // Background 2 - Blue to red
    private static let gameBackground2: [Float] = [ 1.0, 0.0, 0.0, 1.0,
                                                    1.0, 0.0, 0.0, 1.0,
                                                    0.0, 0.0, 1.0, 1.0,
                                                    0.0, 0.0, 1.0, 1.0 ]
    
    // Background 3 - Blue to red
    private static let gameBackground3: [Float] = [ 1.0, 0.0, 0.0, 1.0,
                                                    1.0, 0.0, 0.0, 1.0,
                                                    0.0, 0.0, 1.0, 1.0,
                                                    0.0, 0.0, 1.0, 1.0 ]
    
    // Background 4 - Blue to red
    private static let gameBackground4: [Float] = [ 1.0, 0.0, 0.0, 1.0,
                                                    1.0, 0.0, 0.0, 1.0,
                                                    0.0, 0.0, 1.0, 1.0,
                                                    0.0, 0.0, 1.0, 1.0 ]
    
    // Background 5 - Blue to red
    private static let gameBackground5: [Float] = [ 1.0, 0.0, 0.0, 1.0,
                                                    1.0, 0.0, 0.0, 1.0,
                                                    0.0, 0.0, 1.0, 1.0,
                                                    0.0, 0.0, 1.0, 1.0 ]
    
    // Background 6 - Blue to red
    private static let gameBackground6: [Float] = [ 1.0, 0.0, 0.0, 1.0,
                                                    1.0, 0.0, 0.0, 1.0,
                                                    0.0, 0.0, 1.0, 1.0,
                                                    0.0, 0.0, 1.0, 1.0 ]
    
    // -------------------------------------------------------------------
    // MARK: - Static functions
    // -------------------------------------------------------------------
    
    /* Set up the OpenGL program if necessary */
    public static func setup() {
        
        if (BackgroundRenderer.program != 0) {
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

    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    private var _backgroundFragmentCoordinates: [Float]
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init() {
        _backgroundFragmentCoordinates = []
        BackgroundRenderer.setup()
    }
    
    // --------------------------------------------------------------------
    // MARK: - BackgroundRenderer methods
    // --------------------------------------------------------------------
    
    /* Draw the background for a game */
    func renderMenuBackground(menuBackground: Int) {
        _backgroundFragmentCoordinates = getTexture(forMenuBackground: menuBackground)
        glUseProgram(BackgroundRenderer.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, BackgroundRenderer.menuQuad)
        glVertexAttribPointer(1, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _backgroundFragmentCoordinates)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func getTexture(forMenuBackground menuBackground: Int) -> [Float] {
        switch (menuBackground) {
        case 1: // Title
            return BackgroundRenderer.menuBackground1
        case 2: // Main
            return BackgroundRenderer.menuBackground2
        case 3: // BG Select
            return BackgroundRenderer.menuBackground3
        case 4: // Time Select
            return BackgroundRenderer.menuBackground4
        case 5: // Stage Select
            return BackgroundRenderer.menuBackground5
        case 6: // Puzzle Select
            return BackgroundRenderer.menuBackground6
        case 7: // Tutorial
            return BackgroundRenderer.menuBackground7
        case 8: // Credits
            return BackgroundRenderer.menuBackground8
        default: // Should not get called
            return BackgroundRenderer.menuBackground1
        }
    }
    
    /* Draw the background for a game */
    func renderGameBackground(gameBackground: Int) {
        _backgroundFragmentCoordinates = getTexture(forGameBackground: gameBackground)
        glUseProgram(BackgroundRenderer.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, BackgroundRenderer.gameQuad)
        glVertexAttribPointer(1, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _backgroundFragmentCoordinates)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func getTexture(forGameBackground gameBackground: Int) -> [Float] {
        switch (gameBackground) {
        case 1:
            return BackgroundRenderer.gameBackground1
        case 2:
            return BackgroundRenderer.gameBackground2
        case 3:
            return BackgroundRenderer.gameBackground3
        case 4:
            return BackgroundRenderer.gameBackground4
        case 5:
            return BackgroundRenderer.gameBackground5
        case 6:
            return BackgroundRenderer.gameBackground6
        default:
            return BackgroundRenderer.gameBackground1
        }
    }
}
