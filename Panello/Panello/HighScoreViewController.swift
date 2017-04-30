//
//  HighScoreViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class HighScoreViewController: GLKViewController {
    
    // --------------------------------------------------------------------
    // MARK: - Instance data
    // --------------------------------------------------------------------
    
    /* Graphics */
    // Menu options
    private var back: TextRenderer!
    private var topTitle: TextRenderer!
    private var rank1: TextRenderer!
    private var rank2: TextRenderer!
    private var rank3: TextRenderer!
    private var rank4: TextRenderer!
    private var rank5: TextRenderer!
    private var rank6: TextRenderer!
    private var rank7: TextRenderer!
    private var rank8: TextRenderer!
    private var rank9: TextRenderer!
    private var rank10: TextRenderer!
    
    private var rank1Score: TextRenderer!
    private var rank2Score: TextRenderer!
    private var rank3Score: TextRenderer!
    private var rank4Score: TextRenderer!
    private var rank5Score: TextRenderer!
    private var rank6Score: TextRenderer!
    private var rank7Score: TextRenderer!
    private var rank8Score: TextRenderer!
    private var rank9Score: TextRenderer!
    private var rank10Score: TextRenderer!
    
    // Background
    private var highScoreBackground: BackgroundRenderer!
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;
        self.preferredFramesPerSecond = 1
        
        let context = AppDelegate.context
        highScoreView.context = context
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        back = TextRenderer(startCoordinateX: -0.5, startCoordinateY: 0.85, scale: 0.22)
        topTitle = TextRenderer(startCoordinateX: -0.33, startCoordinateY: 0.7, scale: 0.3)
        
        rank1 = TextRenderer(startCoordinateX: -0.37, startCoordinateY: 0.5, scale: 0.3)
        rank2 = TextRenderer(startCoordinateX: -0.37, startCoordinateY: 0.35, scale: 0.3)
        rank3 = TextRenderer(startCoordinateX: -0.37, startCoordinateY: 0.20, scale: 0.3)
        rank4 = TextRenderer(startCoordinateX: -0.37, startCoordinateY: 0.05, scale: 0.3)
        rank5 = TextRenderer(startCoordinateX: -0.37, startCoordinateY: -0.10, scale: 0.3)
        rank6 = TextRenderer(startCoordinateX: -0.37, startCoordinateY: -0.25, scale: 0.3)
        rank7 = TextRenderer(startCoordinateX: -0.37, startCoordinateY: -0.40, scale: 0.3)
        rank8 = TextRenderer(startCoordinateX: -0.37, startCoordinateY: -0.55, scale: 0.3)
        rank9 = TextRenderer(startCoordinateX: -0.37, startCoordinateY: -0.70, scale: 0.3)
        rank10 = TextRenderer(startCoordinateX: -0.37, startCoordinateY: -0.85, scale: 0.3)
        
        rank1Score = TextRenderer(startCoordinateX: 0.37, startCoordinateY: 0.5, scale: 0.3)
        rank2Score = TextRenderer(startCoordinateX: 0.37, startCoordinateY: 0.35, scale: 0.3)
        rank3Score = TextRenderer(startCoordinateX: 0.37, startCoordinateY: 0.20, scale: 0.3)
        rank4Score = TextRenderer(startCoordinateX: 0.37, startCoordinateY: 0.05, scale: 0.3)
        rank5Score = TextRenderer(startCoordinateX: 0.37, startCoordinateY: -0.10, scale: 0.3)
        rank6Score = TextRenderer(startCoordinateX: 0.37, startCoordinateY: -0.25, scale: 0.3)
        rank7Score = TextRenderer(startCoordinateX: 0.37, startCoordinateY: -0.40, scale: 0.3)
        rank8Score = TextRenderer(startCoordinateX: 0.37, startCoordinateY: -0.55, scale: 0.3)
        rank9Score = TextRenderer(startCoordinateX: 0.37, startCoordinateY: -0.70, scale: 0.3)
        rank10Score = TextRenderer(startCoordinateX: 0.37, startCoordinateY: -0.85, scale: 0.3)

        highScoreBackground = BackgroundRenderer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var highScoreView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - HighScoreViewController methods
    // --------------------------------------------------------------------
    
    /* Draw the view */
    // This is the display loop?
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        let height: GLsizei = GLsizei(highScoreView.bounds.height * highScoreView.contentScaleFactor)
        let offset: GLsizei = GLsizei((highScoreView.bounds.height - highScoreView.bounds.width) * -0.5 * highScoreView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        highScoreBackground.renderMenuBackground(menuBackground: 7)
        back.renderLine(text: "Back")
        topTitle.renderLine(text: "High Scores")
        
        rank1.renderLine(text: "1")
        rank2.renderLine(text: "2")
        rank3.renderLine(text: "3")
        rank4.renderLine(text: "4")
        rank5.renderLine(text: "5")
        rank6.renderLine(text: "6")
        rank7.renderLine(text: "7")
        rank8.renderLine(text: "8")
        rank9.renderLine(text: "9")
        rank10.renderLine(text: "10")

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: highScoreView)
        let glPointX: Float = Float((touchPoint.x/highScoreView.bounds.width) * 2 - 1) * Float(highScoreView.bounds.width/highScoreView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/highScoreView.bounds.height) * 2 - 1) * -1
        
        if (back.touchedInside(x: glPointX, y: glPointY)) {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        print("\(glPointX), \(glPointY)")
    }
}
