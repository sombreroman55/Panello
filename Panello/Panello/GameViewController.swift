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
    private let gameLoop: OperationQueue = OperationQueue()
    
    public var bg: Int = 0
    public var tb: Int = 0
    private var border: BorderRenderer!
    private var topBar: TopBarRenderer!
    private var background: BackgroundRenderer!
    
    private var gridHeight: Float = 1.629
    private var gridWidth: Float = 1.06
    
    private var panel1: Panel!
    private var panel2: Panel!
    private var panel3: Panel!
    private var panel4: Panel!
    private var panel5: Panel!
    private var panel6: Panel!
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
//    init (game: EndlessGame) {
//        puzzleGame = game
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    init (game: TimeTrialGame) {
//        timeTrialGame = game
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    init (game: StageGame) {
//        stageGame = game
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    init (game: PuzzleGame) {
//        puzzleGame = game
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        fatalError("init(nib:,bundle:) has not been implemented. Use init(game:) instead.")
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented. Use init(game:) instead.")
//    }
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    /// Overrides viewDidLoad for TitleViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;
        self.preferredFramesPerSecond = 60
        
        let context = AppDelegate.context
        gameView.context = context
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        
        time = CACurrentMediaTime()
        endless = EndlessGame()
        background = BackgroundRenderer()
        topBar = TopBarRenderer()
        border = BorderRenderer(startCoordinateX: -1.0, startCoordinateY: 0.7)
        panel1 = Panel()
        panel1.positionX = -0.44
        panel1.positionY = -0.903
        panel2 = Panel()
        panel2.positionX = panel1.positionX + 0.176
        panel2.positionY = -0.903
        panel3 = Panel()
        panel3.positionX = panel2.positionX + 0.176
        panel3.positionY = -0.903
        panel4 = Panel()
        panel4.positionX = panel3.positionX + 0.176
        panel4.positionY = -0.903
        panel5 = Panel()
        panel5.positionX = panel4.positionX + 0.176
        panel5.positionY = -0.903
        panel6 = Panel()
        panel6.positionX = panel5.positionX + 0.176
        panel6.positionY = -0.903
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private var gameView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - TitleViewController methods
    // --------------------------------------------------------------------
    
    /* Display loop */
    // Update is the game loop?
    func update() {
    }
    
    /* Draw the view */
    // This is the display loop?
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        let height: GLsizei = GLsizei(gameView.bounds.height * gameView.contentScaleFactor)
        let offset: GLsizei = GLsizei((gameView.bounds.height - gameView.bounds.width) * -0.5 * gameView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        topBar.renderTopBar(type: tb)
        background.renderGameBackground(gameBackground: bg)
        border.renderBorder(border: bg)
        panel1.draw()
        panel2.draw()
        panel3.draw()
        panel4.draw()
        panel5.draw()
        panel6.draw()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: gameView)
        let glPointX: Float = Float((touchPoint.x/gameView.bounds.width) * 2 - 1) * Float(gameView.bounds.width/gameView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/gameView.bounds.height) * 2 - 1) * -1
        if (panel1.touchedInside(x: glPointX, y: glPointY)) {
            print("Touched Panel 1")
        }
        if (panel2.touchedInside(x: glPointX, y: glPointY)) {
            print("Touched Panel 2")
        }
        if (panel3.touchedInside(x: glPointX, y: glPointY)) {
            print("Touched Panel 3")
        }
        if (panel4.touchedInside(x: glPointX, y: glPointY)) {
            print("Touched Panel 4")
        }
        if (panel5.touchedInside(x: glPointX, y: glPointY)) {
            print("Touched Panel 5")
        }
        if (panel6.touchedInside(x: glPointX, y: glPointY)) {
            print("Touched Panel 6")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: gameView)
        let glPointX: Float = Float((touchPoint.x/gameView.bounds.width) * 2 - 1) * Float(gameView.bounds.width/gameView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/gameView.bounds.height) * 2 - 1) * -1
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: gameView)
        let glPointX: Float = Float((touchPoint.x/gameView.bounds.width) * 2 - 1) * Float(gameView.bounds.width/gameView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/gameView.bounds.height) * 2 - 1) * -1
    }
    
    func getGridPositionForTouch(x: Float, y: Float)
}
