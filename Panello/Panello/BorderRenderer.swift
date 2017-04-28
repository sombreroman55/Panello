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
    // OpenGL program
    private static var program: GLuint = 0
    // Vertex coordinates
    private static let quad: [Float] = [ 0.0, -1.7, 0.0, 0.0, 2.0, -1.7, 2.0, 0.0 ]
    
    
    // -------------------------------------------------------------------
    // MARK: - Static functions
    // -------------------------------------------------------------------
    
    /* Setup the OpenGL program if necessary. Compiles and links vertex and fragment shaders. */
    private static func setup() {
        
        if (program != 0) {
            return
        }
        
        // Vertex Shader
        let borderVertexShaderPath: String = Bundle.main.path(forResource: "RendererVertex", ofType: "glsl", inDirectory: nil)!
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
        let borderFragmentShaderPath: String = Bundle.main.path(forResource: "RendererFragment", ofType: "glsl", inDirectory: nil)!
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
        BorderRenderer.setup()
    }
    
    func renderBorder(border: Int) {
        textureCoordinates = getTexture(forBorder: border)
        glUseProgram(BorderRenderer.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, BorderRenderer.quad)
        glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, textureCoordinates)
        glUniform2f(glGetUniformLocation(BorderRenderer.program, "translation"), startPositionX, startPositionY)
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
