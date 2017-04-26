//
//  TitleViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/8/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class TitleViewController: GLKViewController {
    
    // --------------------------------------------------------------------
    // MARK: - Instance data
    // --------------------------------------------------------------------
    // private var translateX: Float = 0.0
    // private var translateY: Float = 0.0
    private var program: GLuint = 0
    private var ayy: Panel!
    private var background: Background!
    private var text: TextRenderer!
    private var score: Int = 0

    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = EAGLContext(api: .openGLES2)
        glkView.context = context!
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        ayy = Panel()
        background = Background()
        text = TextRenderer(startCoordinateX: 0.0, startCoordinateY: 0.5)
        let pause: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pauseGame))
        pause.numberOfTapsRequired = 2
        glkView.addGestureRecognizer(pause)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private var glkView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - TitleViewController methods
    // --------------------------------------------------------------------
    
    /* Display loop */
    // Update is the game loop?
    func update() {
        //self.timeSinceLastUpdate // get time since last display update
        //time += 0.005
    }
    
    /* Draw the view */
    // This is the display loop?
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        //let aspectRatio: Float = Float(glkView.drawableWidth) / Float(glkView.drawableHeight)
        
        //glViewport(0, 0, GLsizei(glkView.drawableWidth), GLsizei(glkView.drawableHeight * aspectRatio))
        score += 1
        
        background.draw()
        ayy.draw()
        text.renderScore(score: score)
    }
    
    /* Pause the game */
    func pauseGame() {
        //translateX = 0.0
        //translateY = 0.0
    }
}
