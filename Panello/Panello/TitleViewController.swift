//
//  TitleViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/8/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class TitleViewController: GLKViewController {
    
    private var time: Float = 0.0
    private var translateX: Float = 0.0
    private var translateY: Float = 0.0
    private var program: GLuint = 0
    private var texture: GLKTextureInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let context = EAGLContext(api: .openGLES2)
        glkView.context = context!
        EAGLContext.setCurrent(context)
        
        
        // Vertex Shader
        let titleVertexShaderPath: String = Bundle.main.path(forResource: "TitleVertex", ofType: "glsl", inDirectory: nil)!
        let titleVertexShaderSource: NSString = try! NSString(contentsOfFile: titleVertexShaderPath, encoding: String.Encoding.utf8.rawValue)
        var titleVertexShaderData = titleVertexShaderSource.cString(using: String.Encoding.utf8.rawValue)
        
        NSLog("Title Vertex Source:\n\(titleVertexShaderSource)")
        
        let titleVertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
        
        // why is nil allowed??
        glShaderSource(titleVertexShader, 1, &titleVertexShaderData, nil)
        glCompileShader(titleVertexShader)
        
        // check if compilation succeeded
        var titleVertexShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(titleVertexShader, GLenum(GL_COMPILE_STATUS), &titleVertexShaderCompileStatus)
        if (titleVertexShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(titleVertexShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(titleVertexShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Shader compilation successful.")
        }
        
        
        // Fragment Shader
        let titleFragmentShaderPath: String = Bundle.main.path(forResource: "TitleFragment", ofType: "glsl", inDirectory: nil)!
        let titleFragmentShaderSource: NSString = try! NSString(contentsOfFile: titleFragmentShaderPath, encoding: String.Encoding.utf8.rawValue)
        var titleFragmentShaderData = titleFragmentShaderSource.cString(using: String.Encoding.utf8.rawValue)
        
        NSLog("Title Fragment Source:\n\(titleFragmentShaderSource)")
        
        let titleFragmentShader: GLuint = glCreateShader(GLenum(GL_FRAGMENT_SHADER))
        
        // why is nil allowed??
        glShaderSource(titleFragmentShader, 1, &titleFragmentShaderData, nil)
        glCompileShader(titleFragmentShader)
        
        // check if compilation succeeded
        var titleFragmentShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(titleFragmentShader, GLenum(GL_COMPILE_STATUS), &titleFragmentShaderCompileStatus)
        if (titleFragmentShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(titleFragmentShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(titleFragmentShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Shader compilation successful.")
        }
        
        
        // Compile Program
        program = glCreateProgram()
        glAttachShader(program, titleVertexShader)
        glAttachShader(program, titleFragmentShader)
        glBindAttribLocation(program, 0, "position")
        glBindAttribLocation(program, 1, "color")
        glBindAttribLocation(program, 2, "texture")
        glLinkProgram(program)
        
        
        var titleProgramLinkStatus: GLint = GL_FALSE
        glGetProgramiv(program, GLenum(GL_LINK_STATUS), &titleProgramLinkStatus)
        if (titleProgramLinkStatus == GL_FALSE) {
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
        
        // Load textures
        let image: UIImage = UIImage(named: "ayy.jpg")!
        texture = try? GLKTextureLoader.texture(with: image.cgImage!, options: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private var glkView: GLKView {
        return view as! GLKView
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        time += 0.005
        translateX -= 0.001
        translateY -= 0.001
        
        // Send Geometry (attributes)
        // Send any other info (uniforms)
        // Draw
        
        let quad: [Float] =
        [
            0.0, 0.0,           // Vertex Coordinate
            1.0, 0.0, 0.0, 1.0, // Color data (RGBA)
            0.0, 1.0,           // Texture data (x, y)
            
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
        
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 32, quad)
        glVertexAttribPointer(1, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 32, UnsafePointer(quad) + 2)
        glVertexAttribPointer(2, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 32, UnsafePointer(quad) + 6)
        glUniform2f(glGetUniformLocation(program, "translation"), translateX, translateY)
        if let texture = texture {
            glBindTexture(GLenum(GL_TEXTURE_2D), texture.name)
        }
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
}
