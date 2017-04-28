//
//  TitleViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/8/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

protocol TitleViewControllerDelegate {
    func moveToMainMenu()
}

class TitleViewController: GLKViewController {
    
    // --------------------------------------------------------------------
    // MARK: - Instance data
    // --------------------------------------------------------------------
    // private var translateX: Float = 0.0
    // private var translateY: Float = 0.0
    public var dele: TitleViewControllerDelegate? = nil
    private var game: Game!
    private var ayy: Panel!
    private var border: BorderRenderer!
    private var background: Background!
    private var text: TextRenderer!
    private var text2: TextRenderer!
    private var score: Int = 0

    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    /// Overrides viewDidLoad for TitleViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = EAGLContext(api: .openGLES2)
        glkView.context = context!
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        ayy = Panel()
        game = Game()
        background = Background()
        border = BorderRenderer(startCoordinateX: -1.0, startCoordinateY: 0.7)
        text = TextRenderer(startCoordinateX: 0.0, startCoordinateY: 0.5)
        text2 = TextRenderer(startCoordinateX: 0.0, startCoordinateY: 0.75)
//        let mtmm: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveToMainMenu))
//        mtmm.numberOfTapsRequired = 1
//        glkView.addGestureRecognizer(mtmm)
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
        border.renderBorder(border: 6)
        ayy.draw()
        game.tick()
        text.renderScore(score: score)
        text2.renderLine(text: "Hello")
        //print("\(game.framesRun)")
    }
    
    /* Pause the game */
//    func moveToMainMenu() {
//        dele?.moveToMainMenu()
//    }
}
