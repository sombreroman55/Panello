//
//  GameViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/20/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class GameViewController: GLKViewController {
    
    // --------------------------------------------------------------------
    // MARK: - Instance data
    // --------------------------------------------------------------------
    private var translateX: Float = 0.0
    private var translateY: Float = 0.0
    private var program: GLuint = 0
    private var ayy: Panel!
    private var background: Background!
    //private var game: Game
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let context = EAGLContext(api: .openGLES2)
        glkView.context = context!
        EAGLContext.setCurrent(context)
        
        ayy = Panel(image: UIImage(named: "ayy.jpg")!)
        background = Background()
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
        //game.tick()
    }
    
    /* Draw the view */
    // This is the display loop?
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        translateX -= 0.001
        translateY -= 0.001
        
        ayy.positionX = translateX
        ayy.positionY = translateY
        
        background.draw()
        ayy.draw()
    }
    
    /* Pause the game */
    func pauseGame() {
        translateX = 0.0
        translateY = 0.0
    }
}
