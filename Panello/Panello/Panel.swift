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

    // Panel spritesheet
    private static let image: UIImage = UIImage(named: "blocks.png")!
    // OpenGL program
    private static var program: GLuint = 0
    // Vertex coordinates
    private static let quad: [Float] = [ -0.07, -0.07, -0.07, 0.07, 0.07, -0.07, 0.07, 0.07 ]
    
    // -------------------------------------------------------------------
    // MARK: - Static functions
    // -------------------------------------------------------------------
    
    /* Setup the OpenGL program if necessary. Compiles and links vertex and fragment shaders. */
    private static func setup() {
        
        if (program != 0) {
            return
        }
        
        // Vertex Shader
        let panelVertexShaderPath: String = Bundle.main.path(forResource: "SpriteVertex", ofType: "glsl", inDirectory: nil)!
        let panelVertexShaderSource: NSString = try! NSString(contentsOfFile: panelVertexShaderPath, encoding: String.Encoding.utf8.rawValue)
        var panelVertexShaderData = panelVertexShaderSource.cString(using: String.Encoding.utf8.rawValue)
        
        let panelVertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
        
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
        glBindAttribLocation(program, 1, "texture")
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
    }
    
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
            return [ (3/116), (19/154), (3/116), (3/154),
                     (19/116), (19/154), (19/116), (3/154),]
        case .BLUE:
            return [ (22/116), (19/154), (22/116), (3/154),
                     (38/116), (19/154), (38/116), (3/154),]
        case .RED:
            return [ (41/116), (19/154), (41/116), (3/154),
                     (57/116), (19/154), (57/116), (3/154),]
        case .CYAN:
            return [ (60/116), (19/154), (60/116), (3/154),
                     (76/116), (19/154), (76/116), (3/154),]
        case .YELLOW:
            return [ (79/116), (19/154), (79/116), (3/154),
                     (95/116), (19/154), (95/116), (3/154),]
        case .GREEN:
            return [ (98/116), (19/154), (98/116), (3/154),
                     (114/116), (19/154), (114/116), (3/154),]
        }
    }
    
    // -------------------------------------------------------------------
    // MARK: - Instance data
    // -------------------------------------------------------------------
    public var positionX: Float = 0.0
    public var positionY: Float = 0.0
    public var color: PanelColor // The color of the block
    public var state: PanelState // The state of the block
    public var falling: Bool // Is this block falling? Cannot match during falling?
    public var chain: Bool // Can this block be chained
    public var floatTimer: Int = 0 // Blocks float for a while when swapped
    public var swapTimer: Int = 0 // Swap animation info
    public var explosionOrder: Int = 0 // TODO: -if time, do this for sound effects
    public var explosionMilliseconds: Int = 0 // number of milliseconds block needs to
    public var explosionAnimationMilliseconds: Int = 0 // number of milliseconds need for animation to complete
    public var explosionTimer: Int = 0 // increased each millisecond while block is exploding
    
    private var texture: GLKTextureInfo? // The texture of the block
    private var textureCoordinates: [Float] // The coordinates of the texture in the sprite sheet
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    init() {
        color = Panel.getRandomColor()
        state = .NORMAL
        falling = false
        chain = false
        floatTimer = 0
        swapTimer = 0
        explosionOrder = 0
        explosionMilliseconds = 0
        explosionAnimationMilliseconds = 0
        explosionTimer = 0
        
        texture = try? GLKTextureLoader.texture(with: Panel.image.cgImage!, options: nil)
        textureCoordinates = Panel.getNormalTexture(forColor: color)
        Panel.setup()
    }
    
    // --------------------------------------------------------------------
    // MARK: - Panel methods
    // --------------------------------------------------------------------
    
    /* Draw the panel */
    func draw() {
        // Send Geometry (attributes)
        // Send any other info (uniforms)
        // Draw
        glUseProgram(Panel.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, Panel.quad)
        glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, textureCoordinates)
        glUniform2f(glGetUniformLocation(Panel.program, "translation"), positionX, positionY)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        if let tex = texture {
            glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
        }
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
}
