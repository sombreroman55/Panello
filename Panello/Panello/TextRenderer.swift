//
//  TextRenderer.swift
//  Panello
//
//  Created by Andrew Roberts on 4/19/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

final class TextRenderer: NSObject {
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    
    /* Fragment shader coordinates */
    /* Array order is -X +Y -X +Y +X +Y +X -Y */
    // Upper case letters
    private static let text_A: [Float] = [ (100/255), (58/255), (100/255), (29/255),
                                           (125/255), (58/255), (125/255), (29/255) ]
    private static let text_B: [Float] = [ (125/255), (58/255), (125/255), (29/255),
                                           (150/255), (58/255), (150/255), (29/255) ]
    private static let text_C: [Float] = [ (150/255), (58/255), (150/255), (29/255),
                                           (175/255), (58/255), (175/255), (29/255) ]
    private static let text_D: [Float] = [ (175/255), (58/255), (175/255), (29/255),
                                           (200/255), (58/255), (200/255), (29/255) ]
    private static let text_E: [Float] = [ (200/255), (58/255), (200/255), (29/255),
                                           (225/255), (58/255), (225/255), (29/255) ]
    private static let text_F: [Float] = [ (225/255), (58/255), (225/255), (29/255),
                                           (250/255), (58/255), (250/255), (29/255) ]
    private static let text_G: [Float] = [ (0/255), (87/255), (0/255), (58/255),
                                           (25/255), (87/255), (25/255), (58/255) ]
    private static let text_H: [Float] = [ (25/255), (87/255), (25/255), (58/255),
                                           (50/255), (87/255), (50/255), (58/255) ]
    private static let text_I: [Float] = [ (50/255), (87/255), (50/255), (58/255),
                                           (75/255), (87/255), (75/255), (58/255) ]
    private static let text_J: [Float] = [ (75/255), (87/255), (75/255), (58/255),
                                           (100/255), (87/255), (105/255), (58/255) ]
    private static let text_K: [Float] = [ (100/255), (87/255), (100/255), (58/255),
                                           (125/255), (87/255), (125/255), (58/255) ]
    private static let text_L: [Float] = [ (125/255), (87/255), (125/255), (58/255),
                                           (150/255), (87/255), (150/255), (58/255) ]
    private static let text_M: [Float] = [ (150/255), (87/255), (150/255), (58/255),
                                           (175/255), (87/255), (175/255), (58/255) ]
    private static let text_N: [Float] = [ (175/255), (87/255), (175/255), (58/255),
                                           (200/255), (87/255), (200/255), (58/255) ]
    private static let text_O: [Float] = [ (200/255), (87/255), (200/255), (58/255),
                                           (225/255), (87/255), (225/255), (58/255) ]
    private static let text_P: [Float] = [ (225/255), (87/255), (225/255), (58/255),
                                           (250/255), (87/255), (250/255), (58/255) ]
    private static let text_Q: [Float] = [ (0/255), (116/255), (0/255), (87/255),
                                           (25/255), (116/255), (25/255), (87/255) ]
    private static let text_R: [Float] = [ (25/255), (116/255), (25/255), (87/255),
                                           (50/255), (116/255), (50/255), (87/255) ]
    private static let text_S: [Float] = [ (50/255), (116/255), (50/255), (87/255),
                                           (75/255), (116/255), (75/255), (87/255) ]
    private static let text_T: [Float] = [ (75/255), (116/255), (75/255), (87/255),
                                           (100/255), (116/255), (100/255), (87/255) ]
    private static let text_U: [Float] = [ (100/255), (116/255), (100/255), (87/255),
                                           (125/255), (116/255), (125/255), (87/255) ]
    private static let text_V: [Float] = [ (125/255), (116/255), (125/255), (87/255),
                                           (150/255), (116/255), (150/255), (87/255) ]
    private static let text_W: [Float] = [ (150/255), (116/255), (150/255), (87/255),
                                           (175/255), (116/255), (175/255), (87/255) ]
    private static let text_X: [Float] = [ (175/255), (116/255), (175/255), (87/255),
                                           (200/255), (116/255), (200/255), (87/255) ]
    private static let text_Y: [Float] = [ (200/255), (116/255), (200/255), (87/255),
                                           (225/255), (116/255), (225/255), (87/255) ]
    private static let text_Z: [Float] = [ (225/255), (116/255), (225/255), (87/255),
                                           (250/255), (116/255), (250/255), (87/255) ]
    
    // Lower case letters
    private static let text_a: [Float] = [ (0/255), (145/255), (0/255), (116/255),
                                           (29/255), (145/255), (29/255), (116/255) ]
    private static let text_b: [Float] = [ (29/255), (145/255), (29/255), (116/255),
                                           (54/255), (145/255), (54/255), (116/255) ]
    private static let text_c: [Float] = [ (54/255), (145/255), (54/255), (116/255),
                                           (79/255), (145/255), (79/255), (116/255) ]
    private static let text_d: [Float] = [ (79/255), (145/255), (79/255), (116/255),
                                           (104/255), (145/255), (104/255), (116/255) ]
    private static let text_e: [Float] = [ (104/255), (145/255), (104/255), (116/255),
                                           (129/255), (145/255), (129/255), (116/255) ]
    private static let text_f: [Float] = [ (129/255), (145/255), (129/255), (116/255),
                                           (154/255), (145/255), (154/255), (116/255) ]
    private static let text_g: [Float] = [ (154/255), (145/255), (154/255), (116/255),
                                           (179/255), (145/255), (179/255), (116/255) ]
    private static let text_h: [Float] = [ (179/255), (145/255), (179/255), (116/255),
                                           (204/255), (145/255), (204/255), (116/255) ]
    private static let text_i: [Float] = [ (204/255), (145/255), (204/255), (116/255),
                                           (213/255), (145/255), (213/255), (116/255) ]
    private static let text_j: [Float] = [ (213/255), (149/255), (213/255), (116/255),
                                           (226/255), (149/255), (226/255), (116/255) ]
    private static let text_k: [Float] = [ (226/255), (145/255), (226/255), (116/255),
                                           (251/255), (145/255), (251/255), (116/255),]
    private static let text_l: [Float] = [ (0/255), (174/255), (0/255), (145/255),
                                           (9/255), (174/255), (9/255), (145/255) ]
    private static let text_m: [Float] = [ (9/255), (174/255), (9/255), (145/255),
                                           (34/255), (174/255), (34/255), (145/255) ]
    private static let text_n: [Float] = [ (34/255), (174/255), (34/255), (145/255),
                                           (55/255), (174/255), (55/255), (145/255) ]
    private static let text_o: [Float] = [ (55/255), (174/255), (55/255), (145/255),
                                           (80/255), (174/255), (80/255), (145/255) ]
    private static let text_p: [Float] = [ (80/255), (174/255), (80/255), (145/255),
                                           (105/255), (174/255), (105/255), (145/255) ]
    private static let text_q: [Float] = [ (105/255), (174/255), (105/255), (145/255),
                                           (130/255), (174/255), (130/255), (145/255) ]
    private static let text_r: [Float] = [ (130/255), (174/255), (130/255), (145/255),
                                           (151/255), (174/255), (151/255), (145/255) ]
    private static let text_s: [Float] = [ (151/255), (174/255), (151/255), (145/255),
                                           (176/255), (174/255), (176/255), (145/255) ]
    private static let text_t: [Float] = [ (176/255), (174/255), (176/255), (145/255),
                                           (201/255), (174/255), (201/255), (145/255) ]
    private static let text_u: [Float] = [ (201/255), (174/255), (201/255), (149/255),
                                           (226/255), (174/255), (226/255), (149/255) ]
    private static let text_v: [Float] = [ (226/255), (174/255), (226/255), (145/255),
                                           (251/255), (174/255), (251/255), (145/255) ]
    private static let text_w: [Float] = [ (0/255), (203/255), (0/255), (174/255),
                                           (25/255), (203/255), (25/255), (174/255) ]
    private static let text_x: [Float] = [ (25/255), (203/255), (25/255), (174/255),
                                           (50/255), (203/255), (50/255), (174/255) ]
    private static let text_y: [Float] = [ (50/255), (203/255), (50/255), (174/255),
                                           (75/255), (203/255), (75/255), (174/255) ]
    private static let text_z: [Float] = [ (75/255), (203/255), (75/255), (174/255),
                                           (100/255), (203/255), (100/255), (174/255) ]
    
    // Numbers
    private static let text_0: [Float] = [ (82/255), (29/255), (82/255), (0/255),
                                           (107/255), (29/255), (107/255), (0/255) ]
    private static let text_1: [Float] = [ (107/255), (29/255), (107/255), (0/255),
                                           (120/255), (29/255), (120/255), (0/255) ]
    private static let text_2: [Float] = [ (120/255), (29/255), (120/255), (0/255),
                                           (145/255), (29/255), (145/255), (0/255) ]
    private static let text_3: [Float] = [ (145/255), (29/255), (145/255), (0/255),
                                           (170/255), (29/255), (170/255), (0/255) ]
    private static let text_4: [Float] = [ (170/255), (29/255), (170/255), (0/255),
                                           (195/255), (29/255), (195/255), (0/255) ]
    private static let text_5: [Float] = [ (195/255), (29/255), (195/255), (0/255),
                                           (220/255), (29/255), (220/255), (0/255) ]
    private static let text_6: [Float] = [ (220/255), (29/255), (220/255), (0/255),
                                           (245/255), (29/255), (245/255), (0/255) ]
    private static let text_7: [Float] = [ (0/255), (58/255), (0/255), (29/255),
                                           (25/255), (58/255), (25/255), (29/255) ]
    private static let text_8: [Float] = [ (25/255), (58/255), (25/255), (29/255),
                                           (50/255), (58/255), (50/255), (29/255) ]
    private static let text_9: [Float] = [ (50/255), (58/255), (50/255), (29/255),
                                           (75/255), (58/255), (75/255), (29/255) ]
    
    // Miscellaneous characters
    private static let text_lparen: [Float] = [ (39/255), (29/255), (39/255), (0/255),
                                                (56/255), (29/255), (56/255), (0/255) ]
    private static let text_rparen: [Float] = [ (56/255), (29/255), (56/255), (0/255),
                                                (73/255), (29/255), (73/255), (0/255) ]
    private static let text_period: [Float] = [ (73/255), (29/255), (73/255), (0/255),
                                                (82/255), (29/255), (82/255), (0/255) ]
    private static let text_quest: [Float] = [ (75/255), (58/255), (75/255), (29/255),
                                               (100/255), (58/255), (100/255), (29/255) ]
    private static let text_exclam: [Float] = [ (0/255), (29/255), (0/255), (0/255),
                                                (18/255), (29/255), (18/255), (0/255) ]
    private static let text_octo: [Float] = [ (18/255), (29/255), (18/255), (0/255),
                                              (39/255), (29/255), (39/255), (0/255) ]
    
    private static var program: GLuint = 0
    // Text bitmap spritesheet
    private static let image: UIImage = UIImage(named: "font.png")!
    // Vertex coordinates
    private static let quad: [Float] = [ -0.1, -0.1, -0.1, 0.1, 0.1, -0.1, 0.1, 0.1 ]
    
    /* Setup the OpenGL program if necessary. Compiles and links vertex and fragment shaders. */
    private static func setup() {
        
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
    
    // -------------------------------------------------------------------
    // MARK: - Public instance data
    // -------------------------------------------------------------------
    public var startPositionX: Float // Anchor X coordinate
    public var startPositionY: Float // Anchor Y coordinate
    public var currentPositionX: Float // Offset X coordinate based on last character
    public var currentPositionY: Float // Offset Y coordinate based on last character
    public var scale: Float // Scale the letter quad
    
    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    private var texture: GLKTextureInfo? // The texture of the character
    private var textureCoordinates: [Float] // The coordinates of the texture in the bitmap

    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init(startCoordinateX: Float, startCoordinateY: Float, sc: Float) {
        texture = try? GLKTextureLoader.texture(with: TextRenderer.image.cgImage!, options: nil)
        textureCoordinates = []
        startPositionX = startCoordinateX
        startPositionY = startCoordinateY
        currentPositionX = startPositionX
        currentPositionY = startPositionY
        scale = sc
        TextRenderer.setup()
    }
    
    // --------------------------------------------------------------------
    // MARK: - TextRenderer methods
    // --------------------------------------------------------------------
    
    func renderLine(text: String) {
        //var charOffset: Float = 0.0
        for char in text.characters {
            textureCoordinates = getTexture(forCharacter: char)
            glUseProgram(TextRenderer.program)
            glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, TextRenderer.quad)
            glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, textureCoordinates)
            glUniform2f(glGetUniformLocation(TextRenderer.program, "translation"), currentPositionX, currentPositionY)
            glUniform2f(glGetUniformLocation(TextRenderer.program, "scale"), scale, scale)
            glEnableVertexAttribArray(0)
            glEnableVertexAttribArray(1)
            if let tex = texture {
                glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
            }
            glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
            //charOffset = getWidth(forCharacter: char)
            currentPositionX += (0.2 * scale)
        }
        currentPositionX = startPositionX
    }
    
    private func getWidth(forCharacter character: Character) -> Float {
        switch(character) {
        case "A":
            return 26/255
        case "B":
            return 26/255
        case "C":
            return 26/255
        case "D":
            return 26/255
        case "E":
            return 26/255
        case "F":
            return 26/255
        case "G":
            return 26/255
        case "H":
            return 26/255
        case "I":
            return 18/255
        case "J":
            return 26/255
        case "K":
            return 26/255
        case "L":
            return 26/255
        case "M":
            return 26/255
        case "N":
            return 26/255
        case "O":
            return 26/255
        case "P":
            return 26/255
        case "Q":
            return 26/255
        case "R":
            return 26/255
        case "S":
            return 26/255
        case "T":
            return 26/255
        case "U":
            return 26/255
        case "V":
            return 26/255
        case "W":
            return 26/255
        case "X":
            return 26/255
        case "Y":
            return 26/255
        case "Z":
            return 26/255
        case "a":
            return 30/255
        case "b":
            return 26/255
        case "c":
            return 26/255
        case "d":
            return 26/255
        case "e":
            return 26/255
        case "f":
            return 26/255
        case "g":
            return 26/255
        case "h":
            return 26/255
        case "i":
            return 10/255
        case "j":
            return 14/255
        case "k":
            return 26/255
        case "l":
            return 10/255
        case "m":
            return 26/255
        case "n":
            return 22/255
        case "o":
            return 26/255
        case "p":
            return 26/255
        case "q":
            return 26/255
        case "r":
            return 22/255
        case "s":
            return 26/255
        case "t":
            return 26/255
        case "u":
            return 26/255
        case "v":
            return 26/255
        case "w":
            return 26/255
        case "x":
            return 26/255
        case "y":
            return 26/255
        case "z":
            return 26/255
        case "0":
            return 26/255
        case "1":
            return 14/255
        case "2":
            return 26/255
        case "3":
            return 26/255
        case "4":
            return 26/255
        case "5":
            return 26/255
        case "6":
            return 26/255
        case "7":
            return 26/255
        case "8":
            return 26/255
        case "9":
            return 26/255
        case "(":
            return 18/255
        case ")":
            return 18/255
        case ".":
            return 10/255
        case "?":
            return 26/255
        case "!":
            return 19/255
        case "#":
            return 22/255
        default:
            return 26/255
        }
    }
    
    private func getTexture(forCharacter character: Character) -> [Float] {
        switch(character) {
        case "A":
            return TextRenderer.text_A
        case "B":
            return TextRenderer.text_B
        case "C":
            return TextRenderer.text_C
        case "D":
            return TextRenderer.text_D
        case "E":
            return TextRenderer.text_E
        case "F":
            return TextRenderer.text_F
        case "G":
            return TextRenderer.text_G
        case "H":
            return TextRenderer.text_H
        case "I":
            return TextRenderer.text_I
        case "J":
            return TextRenderer.text_J
        case "K":
            return TextRenderer.text_K
        case "L":
            return TextRenderer.text_L
        case "M":
            return TextRenderer.text_M
        case "N":
            return TextRenderer.text_N
        case "O":
            return TextRenderer.text_O
        case "P":
            return TextRenderer.text_P
        case "Q":
            return TextRenderer.text_Q
        case "R":
            return TextRenderer.text_R
        case "S":
            return TextRenderer.text_S
        case "T":
            return TextRenderer.text_T
        case "U":
            return TextRenderer.text_U
        case "V":
            return TextRenderer.text_V
        case "W":
            return TextRenderer.text_W
        case "X":
            return TextRenderer.text_X
        case "Y":
            return TextRenderer.text_Y
        case "Z":
            return TextRenderer.text_Z
        case "a":
            return TextRenderer.text_a
        case "b":
            return TextRenderer.text_b
        case "c":
            return TextRenderer.text_c
        case "d":
            return TextRenderer.text_d
        case "e":
            return TextRenderer.text_e
        case "f":
            return TextRenderer.text_f
        case "g":
            return TextRenderer.text_g
        case "h":
            return TextRenderer.text_h
        case "i":
            return TextRenderer.text_i
        case "j":
            return TextRenderer.text_j
        case "k":
            return TextRenderer.text_k
        case "l":
            return TextRenderer.text_l
        case "m":
            return TextRenderer.text_m
        case "n":
            return TextRenderer.text_n
        case "o":
            return TextRenderer.text_o
        case "p":
            return TextRenderer.text_p
        case "q":
            return TextRenderer.text_q
        case "r":
            return TextRenderer.text_r
        case "s":
            return TextRenderer.text_s
        case "t":
            return TextRenderer.text_t
        case "u":
            return TextRenderer.text_u
        case "v":
            return TextRenderer.text_v
        case "w":
            return TextRenderer.text_w
        case "x":
            return TextRenderer.text_x
        case "y":
            return TextRenderer.text_y
        case "z":
            return TextRenderer.text_z
        case "0":
            return TextRenderer.text_0
        case "1":
            return TextRenderer.text_1
        case "2":
            return TextRenderer.text_2
        case "3":
            return TextRenderer.text_3
        case "4":
            return TextRenderer.text_4
        case "5":
            return TextRenderer.text_5
        case "6":
            return TextRenderer.text_6
        case "7":
            return TextRenderer.text_7
        case "8":
            return TextRenderer.text_8
        case "9":
            return TextRenderer.text_9
        case "(":
            return TextRenderer.text_lparen
        case ")":
            return TextRenderer.text_rparen
        case ".":
            return TextRenderer.text_period
        case "?":
            return TextRenderer.text_quest
        case "!":
            return TextRenderer.text_exclam
        case "#":
            return TextRenderer.text_octo
        case " ":
            return []
        default:
            return TextRenderer.text_A
        }
    }
    
    func renderScore(score: Int) {
        //var charOffset: Float = 0.0
        var copy: Int = score
        var digit: Int = 0
        while (copy > 0) {
            digit = copy % 10
            textureCoordinates = getTexture(forNumber: digit)
            glUseProgram(TextRenderer.program)
            glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, TextRenderer.quad)
            glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, textureCoordinates)
            glUniform2f(glGetUniformLocation(TextRenderer.program, "translation"), currentPositionX, currentPositionY)
            glUniform2f(glGetUniformLocation(TextRenderer.program, "scale"), scale, scale)
            glEnableVertexAttribArray(0)
            glEnableVertexAttribArray(1)
            if let tex = texture {
                glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
            }
            glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
            //charOffset = getWidth(forNumber: digit)
            currentPositionX -= (0.2 * scale)
            copy /= 10
        }
        currentPositionX = startPositionX
    }
    
    private func getWidth(forNumber digit: Int) -> Float {
        switch (digit) {
        case 0:
            return 26
        case 1:
            return 14
        case 2:
            return 26
        case 3:
            return 26
        case 4:
            return 26
        case 5:
            return 26
        case 6:
            return 26
        case 7:
            return 26
        case 8:
            return 26
        case 9:
            return 26
        default:
            return 26
        }
    }
    
    private func getTexture(forNumber digit: Int) -> [Float] {
        switch (digit) {
        case 0:
            return TextRenderer.text_0
        case 1:
            return TextRenderer.text_1
        case 2:
            return TextRenderer.text_2
        case 3:
            return TextRenderer.text_3
        case 4:
            return TextRenderer.text_4
        case 5:
            return TextRenderer.text_5
        case 6:
            return TextRenderer.text_6
        case 7:
            return TextRenderer.text_7
        case 8:
            return TextRenderer.text_8
        case 9:
            return TextRenderer.text_9
        default:
            return TextRenderer.text_0
        }
    }
}
