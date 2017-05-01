//
//  BackgroundSelectViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class BackgroundSelectViewController: GLKViewController {
    
    // --------------------------------------------------------------------
    // MARK: - Instance data
    // --------------------------------------------------------------------
    
    /* Graphics */
    // Menu options
    private var back: TextRenderer!
    private var topTitle: TextRenderer!
    private var back1Block: SmallRenderer!
    private var back2Block: SmallRenderer!
    private var back3Block: SmallRenderer!
    private var back4Block: SmallRenderer!
    private var back5Block: SmallRenderer!
    private var back6Block: SmallRenderer!
    
    private var block1BG: BackgroundRenderer!
    private var block2BG: BackgroundRenderer!
    private var block3BG: BackgroundRenderer!
    private var block4BG: BackgroundRenderer!
    private var block5BG: BackgroundRenderer!
    private var block6BG: BackgroundRenderer!

    private var back1: TextRenderer!
    private var back2: TextRenderer!
    private var back3: TextRenderer!
    private var back4: TextRenderer!
    private var back5: TextRenderer!
    private var back6: TextRenderer!
    
    // Background
    private var bgSelectBackground: BackgroundRenderer!
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;
        self.preferredFramesPerSecond = 1
        
        let context = AppDelegate.context
        backgroundSelectView.context = context
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        bgSelectBackground = BackgroundRenderer()
        back = TextRenderer(startCoordinateX: -0.5, startCoordinateY: 0.85, scale: 0.22)
        topTitle = TextRenderer(startCoordinateX: -0.46, startCoordinateY: 0.7, scale: 0.25)
        
        block1BG = BackgroundRenderer()
        block2BG = BackgroundRenderer()
        block3BG = BackgroundRenderer()
        block4BG = BackgroundRenderer()
        block5BG = BackgroundRenderer()
        block6BG = BackgroundRenderer()
        
        back1Block = SmallRenderer(startCoordinateX: -0.26, startCoordinateY: 0.4)
        back2Block = SmallRenderer(startCoordinateX: 0.36, startCoordinateY: 0.4)
        back3Block = SmallRenderer(startCoordinateX: -0.26, startCoordinateY: -0.1)
        back4Block = SmallRenderer(startCoordinateX: 0.36, startCoordinateY: -0.1)
        back5Block = SmallRenderer(startCoordinateX: -0.26, startCoordinateY: -0.6)
        back6Block = SmallRenderer(startCoordinateX: 0.36, startCoordinateY: -0.6)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var backgroundSelectView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - BackgroundSelectViewController methods
    // --------------------------------------------------------------------
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        let height: GLsizei = GLsizei(backgroundSelectView.bounds.height * backgroundSelectView.contentScaleFactor)
        let offset: GLsizei = GLsizei((backgroundSelectView.bounds.height - backgroundSelectView.bounds.width) * -0.5 * backgroundSelectView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        bgSelectBackground.renderMenuBackground(menuBackground: 3)
        back.renderLine(text: "Back")
        topTitle.renderLine(text: "Select Background")
        
        block1BG.renderPreviewBackground(background: 1)
        block2BG.renderPreviewBackground(background: 2)
        block3BG.renderPreviewBackground(background: 3)
        block4BG.renderPreviewBackground(background: 4)
        block5BG.renderPreviewBackground(background: 5)
        block6BG.renderPreviewBackground(background: 6)
        
        back1Block.renderSmallBorder()
        back2Block.renderSmallBorder()
        back3Block.renderSmallBorder()
        back4Block.renderSmallBorder()
        back5Block.renderSmallBorder()
        back6Block.renderSmallBorder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: backgroundSelectView)
        let glPointX: Float = Float((touchPoint.x/backgroundSelectView.bounds.width) * 2 - 1) * Float(backgroundSelectView.bounds.width/backgroundSelectView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/backgroundSelectView.bounds.height) * 2 - 1) * -1
        
        if (back.touchedInside(x: glPointX, y: glPointY)) {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        if (back1Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            backgroundSelected(bg: 1)
        }
        if (back2Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            backgroundSelected(bg: 2)
        }
        if (back3Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            backgroundSelected(bg: 3)
        }
        if (back4Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            backgroundSelected(bg: 4)
        }
        if (back5Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            backgroundSelected(bg: 5)
        }
        if (back6Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            backgroundSelected(bg: 6)
        }
    }
    
    func backgroundSelected(bg: Int) {
        let endl = GameViewController()
        endl.bg = bg
        self.navigationController?.pushViewController(endl, animated: true)
    }
}
