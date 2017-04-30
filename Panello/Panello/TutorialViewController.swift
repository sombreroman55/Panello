//
//  TutorialViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/8/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class TutorialViewController: GLKViewController {
    
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
    private var line8: TextRenderer!
    private var line9: TextRenderer!
    private var line10: TextRenderer!
    private var line11: TextRenderer!
    private var line12: TextRenderer!
    private var line13: TextRenderer!
    private var line14: TextRenderer!
    private var line15: TextRenderer!
    private var line16: TextRenderer!
    private var line17: TextRenderer!
    private var line18: TextRenderer!
    
    // Background
    private var tutorialBackground: BackgroundRenderer!
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;
        self.preferredFramesPerSecond = 1
        
        let context = AppDelegate.context
        tutorialView.context = context
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        back = TextRenderer(startCoordinateX: -0.5, startCoordinateY: 0.85, scale: 0.22)
        topTitle = TextRenderer(startCoordinateX: -0.2, startCoordinateY: 0.7, scale: 0.3)
        
        line1 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: 0.5, scale: 0.195)
        line2 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: 0.45, scale: 0.195)
        
        line3 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: 0.35, scale: 0.195)
        line4 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: 0.30, scale: 0.195)
        line5 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: 0.25, scale: 0.195)
        
        line6 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: 0.10, scale: 0.195)
        line7 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: 0.05, scale: 0.195)
        line8 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: 0.00, scale: 0.195)
        line9 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: -0.05, scale: 0.195)
        
        line10 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: -0.20, scale: 0.195)
        line11 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: -0.25, scale: 0.195)
        line12 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: -0.30, scale: 0.195)
        
        line13 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: -0.45, scale: 0.195)
        line14 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: -0.50, scale: 0.195)
        line15 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: -0.55, scale: 0.195)
        
        line16 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: -0.70, scale: 0.195)
        line17 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: -0.75, scale: 0.195)
        line18 = TextRenderer(startCoordinateX: -0.49, startCoordinateY: -0.80, scale: 0.195)
        
        tutorialBackground = BackgroundRenderer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var tutorialView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - TutorialViewController methods
    // --------------------------------------------------------------------
    
    /* Draw the view */
    // This is the display loop?
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        let height: GLsizei = GLsizei(tutorialView.bounds.height * tutorialView.contentScaleFactor)
        let offset: GLsizei = GLsizei((tutorialView.bounds.height - tutorialView.bounds.width) * -0.5 * tutorialView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        tutorialBackground.renderMenuBackground(menuBackground: 8)
        back.renderLine(text: "Back")
        topTitle.renderLine(text: "Tutorial")
        
        line1.renderLine(text: "Match 3 or more blocks")
        line2.renderLine(text: "together to clear them.")
        
        line3.renderLine(text: "More than 3 is a combo")
        line4.renderLine(text: "Cause another match")
        line5.renderLine(text: "for a chain.")
        
        line6.renderLine(text: "Endless")
        line7.renderLine(text: "Get the highest score")
        line8.renderLine(text: "before the blocks")
        line9.renderLine(text: "touch the top.")
        
        line10.renderLine(text: "Time Trial")
        line11.renderLine(text: "Get the highest score")
        line12.renderLine(text: "before time expires.")
        
        line13.renderLine(text: "Stage")
        line14.renderLine(text: "Get all the blocks")
        line15.renderLine(text: "under the clear line.")
        
        line16.renderLine(text: "Puzzle")
        line17.renderLine(text: "Clear the board in")
        line18.renderLine(text: "the number of moves.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: tutorialView)
        let glPointX: Float = Float((touchPoint.x/tutorialView.bounds.width) * 2 - 1) * Float(tutorialView.bounds.width/tutorialView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/tutorialView.bounds.height) * 2 - 1) * -1
        
        if (back.touchedInside(x: glPointX, y: glPointY)) {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        print("\(glPointX), \(glPointY)")
    }
}
