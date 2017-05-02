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
    
    public var gt: Int = 0 // game type; 1-endless, 2-timetrial, 3-stage, 4-puzzle
    public var bg: Int = 0 // background
    private var border: BorderRenderer!
    private var topBar: TopBarRenderer!
    private var background: BackgroundRenderer!
    private var topTitle: TextRenderer!
    private var leftHUD1: TextRenderer!
    private var leftHUD2: TextRenderer!
    private var rightHUD1: TextRenderer!
    private var rightHUD2: TextRenderer!
    
    private var menu: PopupRenderer!
    private var resume: TextRenderer!
    private var over: TextRenderer!
    private var quit: TextRenderer!
    private var gamePaused: Bool = false
    
    public var endless: EndlessGame?
    public var timeTrial: TimeTrialGame?
    public var stage: StageGame?
    public var puzzle: PuzzleGame?
    
    public var board: Board!
    
    private var gridMinX: Float = -0.53
    private var gridMinY: Float = -0.971
    private var gridHeight: Float = 1.629
    private var gridWidth: Float = 1.06
    
    // --------------------------------------------------------------------
    // MARK: - Constructors
    // --------------------------------------------------------------------
    
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
        
        let right: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        let left: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        let down: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        let pause: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pauseGame))
        right.direction = UISwipeGestureRecognizerDirection.right
        left.direction = UISwipeGestureRecognizerDirection.left
        down.direction = UISwipeGestureRecognizerDirection.down
        pause.numberOfTapsRequired = 3
        gameView.addGestureRecognizer(right)
        gameView.addGestureRecognizer(left)
        gameView.addGestureRecognizer(down)
        gameView.addGestureRecognizer(pause)
        
        switch(gt) {
        case 1:
            board = endless!.board
        case 2:
            board = timeTrial!.board
        case 3:
            board = stage!.board
        case 4:
            board = puzzle!.board
        default:
            break
        }
        
        background = BackgroundRenderer()
        topBar = TopBarRenderer()
        border = BorderRenderer(startCoordinateX: -1.0, startCoordinateY: 0.7)
        topTitle = TextRenderer(startCoordinateX: -0.10, startCoordinateY: 0.86, scale: 0.15)
        leftHUD1 = TextRenderer(startCoordinateX: -0.53, startCoordinateY: 0.76, scale: 0.15)
        leftHUD2 = TextRenderer(startCoordinateX: -0.10, startCoordinateY: 0.76, scale: 0.15)
        rightHUD1 = TextRenderer(startCoordinateX: 0.10, startCoordinateY: 0.76, scale: 0.15)
        rightHUD2 = TextRenderer(startCoordinateX: 0.53, startCoordinateY: 0.76, scale: 0.15)
        
        menu = PopupRenderer(startCoordinateX: -1.0, startCoordinateY: 0.7)
        over = TextRenderer(startCoordinateX: -0.25, startCoordinateY: 0.20, scale: 0.3)
        resume = TextRenderer(startCoordinateX: -0.25, startCoordinateY: 0.20, scale: 0.5)
        quit = TextRenderer(startCoordinateX: -0.25, startCoordinateY: -0.40, scale: 0.5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private var gameView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - GameViewController methods
    // --------------------------------------------------------------------
    
    /* Display loop */
    // Update is the game loop?
    func update() {
        endless?.update()
        timeTrial?.update()
        stage?.update()
        puzzle?.update()
    }
    
    /* Draw the view */
    // This is the display loop?
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        let height: GLsizei = GLsizei(gameView.bounds.height * gameView.contentScaleFactor)
        let offset: GLsizei = GLsizei((gameView.bounds.height - gameView.bounds.width) * -0.5 * gameView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        topBar.renderTopBar(type: gt)
        background.renderGameBackground(gameBackground: bg)
        border.renderBorder(border: bg)
        board.draw()
        
        switch(gt){
        case 1: // endless
            topTitle.renderLine(text: "Endless")
            leftHUD1.renderLine(text: "Score")
            leftHUD2.renderNumber(number: endless!.score)
            rightHUD1.renderLine(text: "High")
            rightHUD2.renderNumber(number: endless!.highScore)
        case 2: // time trial
            topTitle.renderLine(text: "Time Trial")
            leftHUD1.renderLine(text: "Score")
            leftHUD2.renderNumber(number: timeTrial!.score)
            rightHUD1.renderLine(text: "Time")
            rightHUD2.renderNumber(number: timeTrial!.timeRemaining)
        case 3: // stage
            topTitle.renderLine(text: "Stage")
            leftHUD1.renderLine(text: "Stage")
            leftHUD2.renderNumber(number: stage!.stageNumber)
            rightHUD1.renderLine(text: "Lines")
            rightHUD2.renderNumber(number: stage!.linesRemaining)
        case 4: // puzzle
            topTitle.renderLine(text: "Puzzle")
            leftHUD1.renderLine(text: "Puzzle")
            leftHUD2.renderNumber(number: puzzle!.puzzleNumber)
            rightHUD1.renderLine(text: "Moves")
            rightHUD2.renderNumber(number: puzzle!.movesLeft)
        default:
            topTitle.renderLine(text: "This")
            leftHUD1.renderLine(text: "should not")
            leftHUD2.renderNumber(number: 0)
            rightHUD1.renderLine(text: "be here")
            rightHUD2.renderNumber(number: 100)
        }
        
        if (gamePaused) {
            menu.renderPauseMenu()
            resume.renderLine(text: "Resume")
            quit.renderLine(text: "Quit")
        }
        
        if (board.state == .GAME_OVER) {
            menu.renderPauseMenu()
            over.renderLine(text: "Game Over")
            quit.renderLine(text: "Quit")
        }
        
        if (board.state == .WIN) {
            menu.renderPauseMenu()
            over.renderLine(text: "Clear")
            quit.renderLine(text: "Quit")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: gameView)
        let glPointX: Float = Float((touchPoint.x/gameView.bounds.width) * 2 - 1) * Float(gameView.bounds.width/gameView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/gameView.bounds.height) * 2 - 1) * -1
        if (resume.touchedInside(x: glPointX, y: glPointY)) {
            gamePaused = false
        }
        if (quit.touchedInside(x: glPointX, y: glPointY)) {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

    
    func getGridColumnForTouch(x: Float) -> Int {
        if (x >= gridMinX && x < gridMinX + gridWidth) {
            return Int(floor(Double(x - gridMinX) / Double(gridWidth * 0.1666)))
        }
        return -1
    }
    
    func getGridRowForTouch(y: Float) -> Int {
        if (y >= gridMinY && y < gridMinY + gridHeight) {
            return Int(floor(Double(y - gridMinY) / Double(gridHeight * 0.0833)))
        }
        return -1
    }
    
    func pauseGame() {
        endless?.pauseGame()
        timeTrial?.pauseGame()
        stage?.pauseGame()
        puzzle?.pauseGame()
        gamePaused = true
    }
    
    func handleSwipe(gesture: UIGestureRecognizer) {
        if let swipe = gesture as? UISwipeGestureRecognizer {
            let touchPoint: CGPoint = swipe.location(in: gameView)
            let glPointX: Float = Float((touchPoint.x/gameView.bounds.width) * 2 - 1) * Float(gameView.bounds.width/gameView.bounds.height)
            let glPointY: Float = Float((touchPoint.y/gameView.bounds.height) * 2 - 1) * -1
        
            let r: Int = getGridRowForTouch(y: glPointY)
            let c: Int = getGridColumnForTouch(x: glPointX)
        
            switch(swipe.direction) {
            case UISwipeGestureRecognizerDirection.right:
                if (board!.blockCanSwapRight(row: r, column: c)) {
                    board!.swapRight(row: r, column: c)
                    puzzle?.moveTaken()
                }
            case UISwipeGestureRecognizerDirection.left:
                if (board!.blockCanSwapLeft(row: r, column: c)) {
                    board!.swapLeft(row: r, column: c)
                    puzzle?.moveTaken()
                }
            case UISwipeGestureRecognizerDirection.down:
                puzzle?.undoMove()
            default:
                break
            }
        }
    }
}
