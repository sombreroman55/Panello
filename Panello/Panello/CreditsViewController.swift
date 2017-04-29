//
//  CreditsViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/16/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class CreditsViewController: GLKViewController {
    
    // --------------------------------------------------------------------
    // MARK: - Instance data
    // --------------------------------------------------------------------
    
    /* Graphics */
    // Menu options
    private var back: TextRenderer!
    private var topTitle: TextRenderer!
    private var line1: TextRenderer!
    private var line2: TextRenderer!
    private var line3: TextRenderer!
    private var line4: TextRenderer!
    private var line5: TextRenderer!
    private var line6: TextRenderer!
    private var line7: TextRenderer!
    
    // Background
    private var creditsBackground: BackgroundRenderer!
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;
        self.preferredFramesPerSecond = 1
        
        let context = AppDelegate.context
        creditsView.context = context
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        back = TextRenderer(startCoordinateX: -0.5, startCoordinateY: 0.85, scale: 0.22)
        topTitle = TextRenderer(startCoordinateX: -0.2, startCoordinateY: 0.7, scale: 0.3)
        line1 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: 0.5, scale: 0.2)
        line2 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: 0.45, scale: 0.2)
        line3 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: 0.25, scale: 0.2)
        line4 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: 0.20, scale: 0.2)
        line5 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: 0.15, scale: 0.2)
        line6 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: -0.3, scale: 0.2)
        line7 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: -0.35, scale: 0.2)
        creditsBackground = BackgroundRenderer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var creditsView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - CreditsViewController methods
    // --------------------------------------------------------------------
    
    /* Draw the view */
    // This is the display loop?
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        let height: GLsizei = GLsizei(creditsView.bounds.height * creditsView.contentScaleFactor)
        let offset: GLsizei = GLsizei((creditsView.bounds.height - creditsView.bounds.width) * -0.5 * creditsView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        creditsBackground.renderMenuBackground(menuBackground: 9)
        back.renderLine(text: "Back")
        topTitle.renderLine(text: "Credits")
        line1.renderLine(text: "Written by")
        line2.renderLine(text: "Andrew Roberts")
        line3.renderLine(text: "Assets used")
        line4.renderLine(text: "copyright their")
        line5.renderLine(text: "original owners.")
        line6.renderLine(text: "Final Project F")
        line7.renderLine(text: "CS 4530 Spring 2017")
    }
}
