//
//  SpriteEngine.swift
//  Panello
//
//  Created by Andrew Roberts on 4/28/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class SpriteEngine {
    
    public static var program: GLuint = 0
    
    /* Setup the OpenGL program if necessary. Compiles and links vertex and fragment shaders. */
    public static func setup() {
        
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
}
