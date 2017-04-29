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
    // private var translateX: Float = 0.0
    // private var translateY: Float = 0.0
    private let gameLoop: OperationQueue = OperationQueue()
    
    public var dele: TitleViewControllerDelegate? = nil
    private var time: Double = 0.0
    private var endless: EndlessGame!
    private var panel1: Panel!
    private var panel2: Panel!
    private var panel3: Panel!
    private var panel4: Panel!
    private var panel5: Panel!
    private var panel6: Panel!
    private var border: BorderRenderer!
    private var topBar: TopBarRenderer!
    private var background: BackgroundRenderer!
    private var text: TextRenderer!
    private var text2: TextRenderer!
    private var score: Int = 0
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    /// Overrides viewDidLoad for TitleViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;
        self.preferredFramesPerSecond = 60
        
        let context = EAGLContext(api: .openGLES2)
        titleView.context = context!
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pause))
        tap.numberOfTapsRequired = 1
        titleView.addGestureRecognizer(tap)
        
        time = CACurrentMediaTime()
        panel1 = Panel()
        panel2 = Panel()
        panel3 = Panel()
        panel4 = Panel()
        panel5 = Panel()
        panel6 = Panel()
        panel1.positionX = -0.42
        panel1.positionY = -0.865
        panel2.positionX = panel1.positionX + 0.14
        panel2.positionY = panel1.positionY
        panel3.positionX = panel2.positionX + 0.14
        panel3.positionY = panel1.positionY
        panel4.positionX = panel3.positionX + 0.14
        panel4.positionY = panel1.positionY
        panel5.positionX = panel4.positionX + 0.14
        panel5.positionY = panel1.positionY
        panel6.positionX = panel5.positionX + 0.14
        panel6.positionY = panel1.positionY
        endless = EndlessGame()
        background = BackgroundRenderer()
        topBar = TopBarRenderer()
        border = BorderRenderer(startCoordinateX: -1.0, startCoordinateY: 0.7)
        text = TextRenderer(startCoordinateX: 0.0, startCoordinateY: 0.5, sc: 0.5)
        text2 = TextRenderer(startCoordinateX: 0.0, startCoordinateY: 0.75, sc: 0.5)
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
        gameLoop.addOperation({
            self.score += 1
        })
    }
    
    /* Draw the view */
    // This is the display loop?
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        let height: GLsizei = GLsizei(titleView.bounds.height * titleView.contentScaleFactor)
        let offset: GLsizei = GLsizei((titleView.bounds.height - titleView.bounds.width) * -0.5 * titleView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        //        if (endless.state == .RUNNING) {
        //            score += 1
        //        }
        
        topBar.renderTopBar(type: 4)
        background.renderGameBackground(gameBackground: 1)
        border.renderBorder(border: 1)
        panel1.draw()
        panel2.draw()
        panel3.draw()
        panel4.draw()
        panel5.draw()
        panel6.draw()
        text.renderScore(score: score)
        text2.renderLine(text: "Hello")
        print("\(endless.millisecondsRun)\t\(CACurrentMediaTime() - time)")
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
        print("\(touchPoint.x/CGFloat(titleView.bounds.width)), \(touchPoint.y/CGFloat(titleView.bounds.height))")
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
