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
    private var endless: EndlessGame!
    private var panel1: Panel!
    private var panel2: Panel!
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
        self.preferredFramesPerSecond = 60
        
        let context = EAGLContext(api: .openGLES2)
        titleView.context = context!
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pause))
        tap.numberOfTapsRequired = 2
        titleView.addGestureRecognizer(tap)
        
        panel1 = Panel()
        panel2 = Panel()
        panel2.positionX = panel1.positionX + 0.2
        endless = EndlessGame()
        background = Background()
        border = BorderRenderer(startCoordinateX: -1.0, startCoordinateY: 0.7)
        text = TextRenderer(startCoordinateX: 0.0, startCoordinateY: 0.5)
        text2 = TextRenderer(startCoordinateX: 0.0, startCoordinateY: 0.75)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private var titleView: GLKView {
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
        if (endless.state == .RUNNING) {
            score += 1
        }
        
        endless.update()
        background.draw()
        border.renderBorder(border: 1)
        panel1.draw()
        panel2.draw()
        text.renderScore(score: score)
        text2.renderLine(text: "Hello")
        //print("\(endless.millisecondsRun)")
    }
    
    func pause() {
        if (endless.state == .RUNNING) {
            endless.state = .PAUSED
        }
        else if (endless.state == .PAUSED) {
            endless.state = .RUNNING
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: titleView)
        print("\(touchPoint.x), \(touchPoint.y)")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: titleView)
        print("\(touchPoint.x), \(touchPoint.y)")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: titleView)
        print("\(touchPoint.x), \(touchPoint.y)")
    }
}
