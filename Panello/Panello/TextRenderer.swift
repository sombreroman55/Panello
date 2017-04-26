//
//  TextRenderer.swift
//  Panello
//
//  Created by Andrew Roberts on 4/19/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class TextRenderer {
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    
    /* Fragment shader coordinates */
    /* Array order is -X +Y -X +Y +X +Y +X -Y */
    // Upper case letters
    private static let text_A: [Float] = [ (100/256), (58/256), (100/256), (29/256),
                                           (125/256), (58/256), (125/256), (29/256) ]
    private static let text_B: [Float] = [ (125/256), (58/256), (125/256), (29/256),
                                           (150/256), (58/256), (150/256), (29/256) ]
    private static let text_C: [Float] = [ (150/256), (58/256), (150/256), (29/256),
                                           (175/256), (58/256), (175/256), (29/256) ]
    private static let text_D: [Float] = [ (175/256), (58/256), (175/256), (29/256),
                                           (200/256), (58/256), (200/256), (29/256) ]
    private static let text_E: [Float] = [ (200/256), (58/256), (200/256), (29/256),
                                           (225/256), (58/256), (225/256), (29/256) ]
    private static let text_F: [Float] = [ (225/256), (58/256), (225/256), (29/256),
                                           (250/256), (58/256), (250/256), (29/256) ]
    private static let text_G: [Float] = [ (0/256), (87/256), (0/256), (58/256),
                                           (25/256), (87/256), (25/256), (58/256) ]
    private static let text_H: [Float] = [ (25/256), (87/256), (25/256), (58/256),
                                           (50/256), (87/256), (50/256), (58/256) ]
    private static let text_I: [Float] = [ (50/256), (87/256), (50/256), (58/256),
                                           (75/256), (87/256), (75/256), (58/256) ]
    private static let text_J: [Float] = [ (75/256), (87/256), (75/256), (58/256),
                                           (100/256), (87/256), (105/256), (58/256) ]
    private static let text_K: [Float] = [ (100/256), (87/256), (100/256), (58/256),
                                           (125/256), (87/256), (125/256), (58/256) ]
    private static let text_L: [Float] = [ (125/256), (87/256), (125/256), (58/256),
                                           (150/256), (87/256), (150/256), (58/256) ]
    private static let text_M: [Float] = [ (150/256), (87/256), (150/256), (58/256),
                                           (175/256), (87/256), (175/256), (58/256) ]
    private static let text_N: [Float] = [ (175/256), (87/256), (175/256), (58/256),
                                           (200/256), (87/256), (200/256), (58/256) ]
    private static let text_O: [Float] = [ (200/256), (87/256), (200/256), (58/256),
                                           (225/256), (87/256), (225/256), (58/256) ]
    private static let text_P: [Float] = [ (225/256), (87/256), (225/256), (58/256),
                                           (250/256), (87/256), (250/256), (58/256) ]
    private static let text_Q: [Float] = [ (0/256), (116/256), (0/256), (87/256),
                                           (25/256), (116/256), (25/256), (87/256) ]
    private static let text_R: [Float] = [ (25/256), (116/256), (25/256), (87/256),
                                           (50/256), (116/256), (50/256), (87/256) ]
    private static let text_S: [Float] = [ (50/256), (116/256), (50/256), (87/256),
                                           (75/256), (116/256), (75/256), (87/256) ]
    private static let text_T: [Float] = [ (75/256), (116/256), (75/256), (87/256),
                                           (100/256), (116/256), (100/256), (87/256) ]
    private static let text_U: [Float] = [ (100/256), (116/256), (100/256), (87/256),
                                           (125/256), (116/256), (125/256), (87/256) ]
    private static let text_V: [Float] = [ (125/256), (116/256), (125/256), (87/256),
                                           (150/256), (116/256), (150/256), (87/256) ]
    private static let text_W: [Float] = [ (150/256), (116/256), (150/256), (87/256),
                                           (175/256), (116/256), (175/256), (87/256) ]
    private static let text_X: [Float] = [ (175/256), (116/256), (175/256), (87/256),
                                           (200/256), (116/256), (200/256), (87/256) ]
    private static let text_Y: [Float] = [ (200/256), (116/256), (200/256), (87/256),
                                           (225/256), (116/256), (225/256), (87/256) ]
    private static let text_Z: [Float] = [ (225/256), (116/256), (225/256), (87/256),
                                           (250/256), (116/256), (250/256), (87/256) ]
    
    // Lower case letters
    private static let text_a: [Float] = [ (0/256), (145/256), (0/256), (116/256),
                                           (29/256), (145/256), (29/256), (116/256) ]
    private static let text_b: [Float] = [ (29/256), (145/256), (29/256), (116/256),
                                           (54/256), (145/256), (54/256), (116/256) ]
    private static let text_c: [Float] = [ (54/256), (145/256), (54/256), (116/256),
                                           (79/256), (145/256), (79/256), (116/256) ]
    private static let text_d: [Float] = [ (79/256), (145/256), (79/256), (116/256),
                                           (104/256), (145/256), (104/256), (116/256) ]
    private static let text_e: [Float] = [ (104/256), (145/256), (104/256), (116/256),
                                           (129/256), (145/256), (129/256), (116/256) ]
    private static let text_f: [Float] = [ (129/256), (145/256), (129/256), (116/256),
                                           (154/256), (145/256), (154/256), (116/256) ]
    private static let text_g: [Float] = [ (154/256), (145/256), (154/256), (116/256),
                                           (179/256), (145/256), (179/256), (116/256) ]
    private static let text_h: [Float] = [ (179/256), (145/256), (179/256), (116/256),
                                           (204/256), (145/256), (204/256), (116/256) ]
    private static let text_i: [Float] = [ (204/256), (145/256), (204/256), (116/256),
                                           (213/256), (145/256), (213/256), (116/256) ]
    private static let text_j: [Float] = [ (213/256), (149/256), (213/256), (116/256),
                                           (226/256), (149/256), (226/256), (116/256) ]
    private static let text_k: [Float] = [ (226/256), (145/256), (226/256), (116/256),
                                           (251/256), (145/256), (251/256), (116/256),]
    private static let text_l: [Float] = [ (0/256), (174/256), (0/256), (145/256),
                                           (9/256), (174/256), (9/256), (145/256) ]
    private static let text_m: [Float] = [ (9/256), (174/256), (9/256), (145/256),
                                           (34/256), (174/256), (34/256), (145/256) ]
    private static let text_n: [Float] = [ (34/256), (174/256), (34/256), (145/256),
                                           (55/256), (174/256), (55/256), (145/256) ]
    private static let text_o: [Float] = [ (55/256), (174/256), (55/256), (145/256),
                                           (80/256), (174/256), (80/256), (145/256) ]
    private static let text_p: [Float] = [ (80/256), (174/256), (80/256), (145/256),
                                           (105/256), (174/256), (105/256), (145/256) ]
    private static let text_q: [Float] = [ (105/256), (174/256), (105/256), (145/256),
                                           (130/256), (174/256), (130/256), (145/256) ]
    private static let text_r: [Float] = [ (130/256), (174/256), (130/256), (145/256),
                                           (151/256), (174/256), (151/256), (145/256) ]
    private static let text_s: [Float] = [ (151/256), (174/256), (151/256), (145/256),
                                           (176/256), (174/256), (176/256), (145/256) ]
    private static let text_t: [Float] = [ (176/256), (174/256), (176/256), (145/256),
                                           (201/256), (174/256), (201/256), (145/256) ]
    private static let text_u: [Float] = [ (201/256), (174/256), (201/256), (149/256),
                                           (226/256), (174/256), (226/256), (149/256) ]
    private static let text_v: [Float] = [ (226/256), (174/256), (226/256), (145/256),
                                           (251/256), (174/256), (251/256), (145/256) ]
    private static let text_w: [Float] = [ (0/256), (203/256), (0/256), (174/256),
                                           (25/256), (203/256), (25/256), (174/256) ]
    private static let text_x: [Float] = [ (25/256), (203/256), (25/256), (174/256),
                                           (50/256), (203/256), (50/256), (174/256) ]
    private static let text_y: [Float] = [ (50/256), (203/256), (50/256), (174/256),
                                           (75/256), (203/256), (75/256), (174/256) ]
    private static let text_z: [Float] = [ (75/256), (203/256), (75/256), (174/256),
                                           (100/256), (203/256), (100/256), (174/256) ]
    
    // Numbers
    private static let text_0: [Float] = [ (82/256), (29/256), (82/256), (0/256),
                                           (107/256), (29/256), (107/256), (0/256) ]
    private static let text_1: [Float] = [ (107/256), (29/256), (107/256), (0/256),
                                           (120/256), (29/256), (120/256), (0/256) ]
    private static let text_2: [Float] = [ (120/256), (29/256), (120/256), (0/256),
                                           (145/256), (29/256), (145/256), (0/256) ]
    private static let text_3: [Float] = [ (145/256), (29/256), (145/256), (0/256),
                                           (170/256), (29/256), (170/256), (0/256) ]
    private static let text_4: [Float] = [ (170/256), (29/256), (170/256), (0/256),
                                           (195/256), (29/256), (195/256), (0/256) ]
    private static let text_5: [Float] = [ (195/256), (29/256), (195/256), (0/256),
                                           (220/256), (29/256), (220/256), (0/256) ]
    private static let text_6: [Float] = [ (220/256), (29/256), (220/256), (0/256),
                                           (245/256), (29/256), (245/256), (0/256) ]
    private static let text_7: [Float] = [ (0/256), (58/256), (0/256), (29/256),
                                           (25/256), (58/256), (25/256), (29/256) ]
    private static let text_8: [Float] = [ (25/256), (58/256), (25/256), (29/256),
                                           (50/256), (58/256), (50/256), (29/256) ]
    private static let text_9: [Float] = [ (50/256), (58/256), (50/256), (29/256),
                                           (75/256), (58/256), (75/256), (29/256) ]
    
    // Miscellaneous characters
    private static let text_lparen: [Float] = [ (39/256), (29/256), (39/256), (0/256),
                                                (56/256), (29/256), (56/256), (0/256) ]
    private static let text_rparen: [Float] = [ (56/256), (29/256), (56/256), (0/256),
                                                (73/256), (29/256), (73/256), (0/256) ]
    private static let text_period: [Float] = [ (73/256), (29/256), (73/256), (0/256),
                                                (82/256), (29/256), (82/256), (0/256) ]
    private static let text_quest: [Float] = [ (75/256), (58/256), (75/256), (29/256),
                                               (100/256), (58/256), (100/256), (29/256) ]
    private static let text_exclam: [Float] = [ (0/256), (29/256), (0/256), (0/256),
                                                (18/256), (29/256), (18/256), (0/256) ]
    private static let text_octo: [Float] = [ (18/256), (29/256), (18/256), (0/256),
                                              (39/256), (29/256), (39/256), (0/256) ]
    
    // Text bitmap spritesheet
    private static let image: UIImage = UIImage(named: "font.png")!
    // OpenGL program
    private static var program: GLuint = 0
    // Vertex coordinates
    private static let quad: [Float] = [ -0.1, -0.1, -0.1, 0.1, 0.1, -0.1, 0.1, 0.1 ]
    
    
    // -------------------------------------------------------------------
    // MARK: - Static functions
    // -------------------------------------------------------------------
    
    /* Setup the OpenGL program if necessary. Compiles and links vertex and fragment shaders. */
    private static func setup() {
        
        if (program != 0) {
            return
        }
        
        // Vertex Shader
        let textVertexShaderPath: String = Bundle.main.path(forResource: "TextVertex", ofType: "glsl", inDirectory: nil)!
        let textVertexShaderSource: NSString = try! NSString(contentsOfFile: textVertexShaderPath, encoding: String.Encoding.utf8.rawValue)
        var textVertexShaderData = textVertexShaderSource.cString(using: String.Encoding.utf8.rawValue)
        
        let textVertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
        
        glShaderSource(textVertexShader, 1, &textVertexShaderData, nil)
        glCompileShader(textVertexShader)
        
        // check if compilation succeeded
        var textVertexShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(textVertexShader, GLenum(GL_COMPILE_STATUS), &textVertexShaderCompileStatus)
        if (textVertexShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(textVertexShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(textVertexShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Text vertex shader compilation successful.")
        }
        
        
        // Fragment Shader
        let textFragmentShaderPath: String = Bundle.main.path(forResource: "TextFragment", ofType: "glsl", inDirectory: nil)!
        let textFragmentShaderSource: NSString = try! NSString(contentsOfFile: textFragmentShaderPath, encoding: String.Encoding.utf8.rawValue)
        var textFragmentShaderData = textFragmentShaderSource.cString(using: String.Encoding.utf8.rawValue)
        
        let textFragmentShader: GLuint = glCreateShader(GLenum(GL_FRAGMENT_SHADER))
        
        // why is nil allowed??
        glShaderSource(textFragmentShader, 1, &textFragmentShaderData, nil)
        glCompileShader(textFragmentShader)
        
        // check if compilation succeeded
        var textFragmentShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(textFragmentShader, GLenum(GL_COMPILE_STATUS), &textFragmentShaderCompileStatus)
        if (textFragmentShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(textFragmentShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(textFragmentShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Text fragment shader compilation successful.")
        }
        
        
        // Compile Program
        program = glCreateProgram()
        glAttachShader(program, textVertexShader)
        glAttachShader(program, textFragmentShader)
        glBindAttribLocation(program, 0, "position")
        glBindAttribLocation(program, 1, "texture")
        glLinkProgram(program)
        
        
        var textProgramLinkStatus: GLint = GL_FALSE
        glGetProgramiv(program, GLenum(GL_LINK_STATUS), &textProgramLinkStatus)
        if (textProgramLinkStatus == GL_FALSE) {
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
    public var startPositionX: Float
    public var startPositionY: Float
    public var currentPositionX: Float
    public var currentPositionY: Float
    
    // -------------------------------------------------------------------
    // MARK: - Private instance data
    // -------------------------------------------------------------------
    
    private var texture: GLKTextureInfo? // The texture of the character
    private var textureCoordinates: [Float] // The coordinates of the texture in the bitmap

    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init(startCoordinateX: Float, startCoordinateY: Float) {
        texture = try? GLKTextureLoader.texture(with: TextRenderer.image.cgImage!, options: nil)
        textureCoordinates = []
        startPositionX = startCoordinateX
        startPositionY = startCoordinateY
        currentPositionX = startPositionX
        currentPositionY = startPositionY
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
            glEnableVertexAttribArray(0)
            glEnableVertexAttribArray(1)
            if let tex = texture {
                glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
            }
            glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
            //charOffset = getWidth(forCharacter: char)
            currentPositionX += 0.2
        }
        currentPositionX = startPositionX
    }
    
    private func getWidth(forCharacter character: Character) -> Float {
        switch(character) {
        case "A":
            return 26/256
        case "B":
            return 26/256
        case "C":
            return 26/256
        case "D":
            return 26/256
        case "E":
            return 26/256
        case "F":
            return 26/256
        case "G":
            return 26/256
        case "H":
            return 26/256
        case "I":
            return 18/256
        case "J":
            return 26/256
        case "K":
            return 26/256
        case "L":
            return 26/256
        case "M":
            return 26/256
        case "N":
            return 26/256
        case "O":
            return 26/256
        case "P":
            return 26/256
        case "Q":
            return 26/256
        case "R":
            return 26/256
        case "S":
            return 26/256
        case "T":
            return 26/256
        case "U":
            return 26/256
        case "V":
            return 26/256
        case "W":
            return 26/256
        case "X":
            return 26/256
        case "Y":
            return 26/256
        case "Z":
            return 26/256
        case "a":
            return 30/256
        case "b":
            return 26/256
        case "c":
            return 26/256
        case "d":
            return 26/256
        case "e":
            return 26/256
        case "f":
            return 26/256
        case "g":
            return 26/256
        case "h":
            return 26/256
        case "i":
            return 10/256
        case "j":
            return 14/256
        case "k":
            return 26/256
        case "l":
            return 10/256
        case "m":
            return 26/256
        case "n":
            return 22/256
        case "o":
            return 26/256
        case "p":
            return 26/256
        case "q":
            return 26/256
        case "r":
            return 22/256
        case "s":
            return 26/256
        case "t":
            return 26/256
        case "u":
            return 26/256
        case "v":
            return 26/256
        case "w":
            return 26/256
        case "x":
            return 26/256
        case "y":
            return 26/256
        case "z":
            return 26/256
        case "0":
            return 26/256
        case "1":
            return 14/256
        case "2":
            return 26/256
        case "3":
            return 26/256
        case "4":
            return 26/256
        case "5":
            return 26/256
        case "6":
            return 26/256
        case "7":
            return 26/256
        case "8":
            return 26/256
        case "9":
            return 26/256
        case "(":
            return 18/256
        case ")":
            return 18/256
        case ".":
            return 10/256
        case "?":
            return 26/256
        case "!":
            return 19/256
        case "#":
            return 22/256
        default:
            return 26/256
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
            glEnableVertexAttribArray(0)
            glEnableVertexAttribArray(1)
            if let tex = texture {
                glBindTexture(GLenum(GL_TEXTURE_2D), tex.name)
            }
            glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
            //charOffset = getWidth(forNumber: digit)
            currentPositionX -= 0.2
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
