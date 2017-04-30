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
    
    private var time: Double = 0.0
    private var endless: EndlessGame!
    private var border: BorderRenderer!
    private var topBar: TopBarRenderer!
    private var background: BackgroundRenderer!
    
    private var endlessGame: Game?
    private var timeTrialGame: Game?
    private var stageGame: Game?
    private var puzzleGame: Game?
    private var score: Int = 0
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
    init (game: EndlessGame) {
        puzzleGame = game
        super.init(nibName: nil, bundle: nil)
    }
    
    init (game: TimeTrialGame) {
        timeTrialGame = game
        super.init(nibName: nil, bundle: nil)
    }
    
    init (game: StageGame) {
        stageGame = game
        super.init(nibName: nil, bundle: nil)
    }
    
    init (game: PuzzleGame) {
        puzzleGame = game
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(nib:,bundle:) has not been implemented. Use init(game:) instead.")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(game:) instead.")
    }
    
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pause))
        tap.numberOfTapsRequired = 1
        gameView.addGestureRecognizer(tap)
        
        time = CACurrentMediaTime()
        endless = EndlessGame()
        background = BackgroundRenderer()
        topBar = TopBarRenderer()
        border = BorderRenderer(startCoordinateX: -1.0, startCoordinateY: 0.7)
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
        self.score += 1
    }
    
    /* Draw the view */
    // This is the display loop?
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        let height: GLsizei = GLsizei(gameView.bounds.height * gameView.contentScaleFactor)
        let offset: GLsizei = GLsizei((gameView.bounds.height - gameView.bounds.width) * -0.5 * gameView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        //        if (endless.state == .RUNNING) {
        //            score += 1
        //        }
        
        topBar.renderTopBar(type: 4)
        background.renderGameBackground(gameBackground: 6)
        border.renderBorder(border: 6)
        //print("\(endless.millisecondsRun)\t\(CACurrentMediaTime() - time)")
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
        let touchPoint: CGPoint = touch.location(in: gameView)
        let glPointX: Float = Float((touchPoint.x/gameView.bounds.width) * 2 - 1) * Float(gameView.bounds.width/gameView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/gameView.bounds.height) * 2 - 1) * -1
        print("\(glPointX), \(glPointY)")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: gameView)
        print("\(touchPoint.x), \(touchPoint.y)")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: gameView)
        print("\(touchPoint.x), \(touchPoint.y)")
    }
}
