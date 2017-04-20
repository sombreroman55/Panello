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
    enum PanelColor {
        case RED
        case YELLOW
        case GREEN
        case CYAN
        case BLUE
        case PURPLE
    }
    
    enum PanelState {
        case NORMAL
        case FLOATING
        case MATCHED
        case POPPING
        case SWAP_RIGHT
        case SWAP_LEFT
    }

    private static var program: GLuint = 0
    private static let quad: [Float] =
        [
            0.0, 0.0,           // Vertex Coordinate
            1.0, 0.0, 0.0, 1.0, // Color data (RGBA)
            0.0, 1.0,           // Texture data (x, y); invert the y values to be right side up
            
            1.0, 0.0,
            0.0, 1.0, 0.0, 1.0,
            1.0, 1.0,
            
            0.0, 1.0,
            0.0, 0.0, 1.0, 1.0,
            0.0, 0.0,
            
            1.0, 1.0,
            1.0, 0.5, 0.0, 1.0,
            1.0, 0.0
        ]
    
    // -------------------------------------------------------------------
    // MARK: - Instance data
    // -------------------------------------------------------------------
    var positionX: Float = 0.0
    var positionY: Float = 0.0
    var scaleX: Float = 1.0
    var scaleY: Float = 1.0
    var rotation: Float = 0.0 // radians
    let image: UIImage
    
    private var _falling: Bool // Is this block falling? Cannot match during falling?
    private var _chain: Bool // Is this block part of a chain?
    private var _color: PanelColor
    private var _state: PanelState
    private var texture: GLKTextureInfo?
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    init(image: UIImage) {
        self.image = image
        _color = .RED // TODO: dynamically assign PanelColor
        texture = try? GLKTextureLoader.texture(with: self.image.cgImage!, options: nil)
        _state = .NORMAL
        Panel.setup()
    }
        
    // -------------------------------------------------------------------
    // MARK: - Static functions
    // -------------------------------------------------------------------
    private static func setup() {
        
        if (program != 0) {
            return
        }
        
        // Vertex Shader
        let panelVertexShaderPath: String = Bundle.main.path(forResource: "SpriteVertex", ofType: "glsl", inDirectory: nil)!
        let panelVertexShaderSource: NSString = try! NSString(contentsOfFile: panelVertexShaderPath, encoding: String.Encoding.utf8.rawValue)
        var panelVertexShaderData = panelVertexShaderSource.cString(using: String.Encoding.utf8.rawValue)
        
        let panelVertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
        
        // why is nil allowed??
        glShaderSource(panelVertexShader, 1, &panelVertexShaderData, nil)
        glCompileShader(panelVertexShader)
        
        // check if compilation succeeded
        var panelVertexShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(panelVertexShader, GLenum(GL_COMPILE_STATUS), &panelVertexShaderCompileStatus)
        if (panelVertexShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(panelVertexShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(panelVertexShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Sprite vertex shader compilation successful.")
        }
        
        
        // Fragment Shader
        let panelFragmentShaderPath: String = Bundle.main.path(forResource: "SpriteFragment", ofType: "glsl", inDirectory: nil)!
        let panelFragmentShaderSource: NSString = try! NSString(contentsOfFile: panelFragmentShaderPath, encoding: String.Encoding.utf8.rawValue)
        var panelFragmentShaderData = panelFragmentShaderSource.cString(using: String.Encoding.utf8.rawValue)
        
        let panelFragmentShader: GLuint = glCreateShader(GLenum(GL_FRAGMENT_SHADER))
        
        // why is nil allowed??
        glShaderSource(panelFragmentShader, 1, &panelFragmentShaderData, nil)
        glCompileShader(panelFragmentShader)
        
        // check if compilation succeeded
        var panelFragmentShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(panelFragmentShader, GLenum(GL_COMPILE_STATUS), &panelFragmentShaderCompileStatus)
        if (panelFragmentShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(panelFragmentShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(panelFragmentShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Sprite fragment shader compilation successful.")
        }
        
        
        // Compile Program
        program = glCreateProgram()
        glAttachShader(program, panelVertexShader)
        glAttachShader(program, panelFragmentShader)
        glBindAttribLocation(program, 0, "position")
        glBindAttribLocation(program, 1, "color")
        glBindAttribLocation(program, 2, "texture")
        glLinkProgram(program)
        
        
        var panelProgramLinkStatus: GLint = GL_FALSE
        glGetProgramiv(program, GLenum(GL_LINK_STATUS), &panelProgramLinkStatus)
        if (panelProgramLinkStatus == GL_FALSE) {
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetProgramiv(program, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetProgramInfoLog(program, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Linking failed.")
        }
        
        glUseProgram(program)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        glEnableVertexAttribArray(2)
        
    }
    
    func draw() {
        // Send Geometry (attributes)
        // Send any other info (uniforms)
        // Draw
        
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 32, Panel.quad)
        glVertexAttribPointer(1, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 32, UnsafePointer(Panel.quad) + 2)
        glVertexAttribPointer(2, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 32, UnsafePointer(Panel.quad) + 6)
        glUniform2f(glGetUniformLocation(Panel.program, "translation"), positionX, positionY)
        if let tex = texture {
            print("Binding texture...")
            glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
        }
        print("X: \(positionX), Y: \(positionY)")
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func getRandomColor() -> PanelColor {
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
}
