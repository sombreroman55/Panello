//
//  MainMenuViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class MainMenuViewController: GLKViewController {
    
    // --------------------------------------------------------------------
    // MARK: - Instance data
    // --------------------------------------------------------------------
        
    /* Graphics */
    // Menu options
    private var topTitle: TextRenderer!
    private var endlessOption: TextRenderer!
    private var timeTrialOption: TextRenderer!
    private var stageOption: TextRenderer!
    private var puzzleOption: TextRenderer!
    private var highScoreOption: TextRenderer!
    private var tutorialOption: TextRenderer!
    private var creditsOption: TextRenderer!
    
    // Background
    private var mainMenuBackground: BackgroundRenderer!
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;
        self.preferredFramesPerSecond = 1
        
        let context = AppDelegate.context
        mainMenuView.context = context
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        topTitle = TextRenderer(startCoordinateX: -0.27, startCoordinateY: 0.8, scale: 0.3)
        endlessOption = TextRenderer(startCoordinateX: -0.38, startCoordinateY: 0.5, scale: 0.3)
        timeTrialOption = TextRenderer(startCoordinateX: -0.38, startCoordinateY: 0.3, scale: 0.3)
        stageOption = TextRenderer(startCoordinateX: -0.38, startCoordinateY: 0.1, scale: 0.3)
        puzzleOption = TextRenderer(startCoordinateX: -0.38, startCoordinateY: -0.1, scale: 0.3)
        highScoreOption = TextRenderer(startCoordinateX: -0.38, startCoordinateY: -0.3, scale: 0.3)
        tutorialOption = TextRenderer(startCoordinateX: -0.38, startCoordinateY: -0.5, scale: 0.3)
        creditsOption = TextRenderer(startCoordinateX: -0.38, startCoordinateY: -0.7, scale: 0.3)
        mainMenuBackground = BackgroundRenderer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var mainMenuView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - MainMenuViewController methods
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
        
        let height: GLsizei = GLsizei(mainMenuView.bounds.height * mainMenuView.contentScaleFactor)
        let offset: GLsizei = GLsizei((mainMenuView.bounds.height - mainMenuView.bounds.width) * -0.5 * mainMenuView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        mainMenuBackground.renderMenuBackground(menuBackground: 2)
        topTitle.renderLine(text: "Panello")
        endlessOption.renderLine(text: "Endless")
        timeTrialOption.renderLine(text: "Time Trial")
        stageOption.renderLine(text: "Stage")
        puzzleOption.renderLine(text: "Puzzle")
        highScoreOption.renderLine(text: "High Scores")
        tutorialOption.renderLine(text: "Tutorial")
        creditsOption.renderLine(text: "Credits")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: mainMenuView)
        let glPointX: Float = Float((touchPoint.x/mainMenuView.bounds.width) * 2 - 1) * Float(mainMenuView.bounds.width/mainMenuView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/mainMenuView.bounds.height) * 2 - 1) * -1
        
        if (endlessOption.touchedInside(x: glPointX, y: glPointY)) {
            endlessSelected()
        }
        else if (timeTrialOption.touchedInside(x: glPointX, y: glPointY)) {
            timeTrialSelected()
        }
        else if (stageOption.touchedInside(x: glPointX, y: glPointY)) {
            stageSelected()
        }
        else if (puzzleOption.touchedInside(x: glPointX, y: glPointY)) {
            puzzleSelected()
        }
        else if (highScoreOption.touchedInside(x: glPointX, y: glPointY)) {
            highScoreSelected()
        }
        else if (tutorialOption.touchedInside(x: glPointX, y: glPointY)) {
            tutorialSelected()
        }
        else if (creditsOption.touchedInside(x: glPointX, y: glPointY)) {
            creditsSelected()
        }        
    }
    
    func endlessSelected() {
        self.navigationController?.pushViewController(AppDelegate.endless, animated: true)
    }
    
    func timeTrialSelected() {
        self.navigationController?.pushViewController(AppDelegate.time, animated: true)
    }
    
    func stageSelected() {
        self.navigationController?.pushViewController(AppDelegate.stage, animated: true)
    }
    
    func puzzleSelected() {
        self.navigationController?.pushViewController(AppDelegate.puzzle, animated: true)
    }
    
    func highScoreSelected() {
        self.navigationController?.pushViewController(AppDelegate.high, animated: true)
    }
    
    func tutorialSelected() {
        self.navigationController?.pushViewController(AppDelegate.tutorial, animated: true)
    }
    
    func creditsSelected() {
        self.navigationController?.pushViewController(AppDelegate.credits, animated: true)
    }
}
