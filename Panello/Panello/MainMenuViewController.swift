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
        
        let btt = UITapGestureRecognizer(target: self, action: #selector(backToTitle))
        btt.numberOfTapsRequired = 1
        mainMenuView.addGestureRecognizer(btt)
        
        topTitle = TextRenderer(startCoordinateX: -0.32, startCoordinateY: 0.8, scale: 0.3)
        endlessOption = TextRenderer(startCoordinateX: -0.32, startCoordinateY: 0.4, scale: 0.3)
        timeTrialOption = TextRenderer(startCoordinateX: -0.32, startCoordinateY: 0.2, scale: 0.3)
        stageOption = TextRenderer(startCoordinateX: -0.32, startCoordinateY: 0.0, scale: 0.3)
        puzzleOption = TextRenderer(startCoordinateX: -0.32, startCoordinateY: -0.2, scale: 0.3)
        tutorialOption = TextRenderer(startCoordinateX: -0.32, startCoordinateY: -0.4, scale: 0.3)
        creditsOption = TextRenderer(startCoordinateX: -0.32, startCoordinateY: -0.6, scale: 0.3)
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
        tutorialOption.renderLine(text: "Tutorial")
        creditsOption.renderLine(text: "Credits")
    }
    
    func backToTitle() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}
