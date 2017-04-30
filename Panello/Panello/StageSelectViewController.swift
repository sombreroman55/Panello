//
//  StageSelectViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class StageSelectViewController: GLKViewController {
    
    // --------------------------------------------------------------------
    // MARK: - Instance data
    // --------------------------------------------------------------------
    
    /* Graphics */
    // Menu options
    private var back: TextRenderer!
    private var topTitle: TextRenderer!
    private var stage1Block: SmallRenderer!
    private var stage2Block: SmallRenderer!
    private var stage3Block: SmallRenderer!
    private var stage4Block: SmallRenderer!
    private var stage5Block: SmallRenderer!
    private var stage6Block: SmallRenderer!
    private var stage7Block: SmallRenderer!
    private var stage8Block: SmallRenderer!
    private var stage9Block: SmallRenderer!
    private var stage10Block: SmallRenderer!
    private var stage11Block: SmallRenderer!
    private var stage12Block: SmallRenderer!
    
    private var stage1: TextRenderer!
    private var stage2: TextRenderer!
    private var stage3: TextRenderer!
    private var stage4: TextRenderer!
    private var stage5: TextRenderer!
    private var stage6: TextRenderer!
    private var stage7: TextRenderer!
    private var stage8: TextRenderer!
    private var stage9: TextRenderer!
    private var stage10: TextRenderer!
    private var stage11: TextRenderer!
    private var stage12: TextRenderer!
    
    // Background
    private var stageBackground: BackgroundRenderer!
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;
        self.preferredFramesPerSecond = 1
        
        let context = AppDelegate.context
        stageView.context = context
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        back = TextRenderer(startCoordinateX: -0.5, startCoordinateY: 0.85, scale: 0.22)
        topTitle = TextRenderer(startCoordinateX: -0.40, startCoordinateY: 0.7, scale: 0.3)
        
        stage1 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: 0.5, scale: 0.33)
        stage2 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: 0.5, scale: 0.33)
        stage3 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: 0.25, scale: 0.33)
        stage4 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: 0.25, scale: 0.33)
        stage5 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: 0.0, scale: 0.33)
        stage6 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: 0.0, scale: 0.33)
        stage7 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: -0.25, scale: 0.33)
        stage8 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: -0.25, scale: 0.33)
        stage9 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: -0.50, scale: 0.33)
        stage10 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: -0.50, scale: 0.33)
        stage11 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: -0.75, scale: 0.33)
        stage12 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: -0.75, scale: 0.33)
        
        stage1Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: 0.5)
        stage2Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: 0.5)
        stage3Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: 0.25)
        stage4Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: 0.25)
        stage5Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: 0.0)
        stage6Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: 0.0)
        stage7Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: -0.25)
        stage8Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: -0.25)
        stage9Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: -0.50)
        stage10Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: -0.50)
        stage11Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: -0.75)
        stage12Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: -0.75)
        
        stageBackground = BackgroundRenderer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var stageView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - StageSelectViewController methods
    // --------------------------------------------------------------------
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        let height: GLsizei = GLsizei(stageView.bounds.height * stageView.contentScaleFactor)
        let offset: GLsizei = GLsizei((stageView.bounds.height - stageView.bounds.width) * -0.5 * stageView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        stageBackground.renderMenuBackground(menuBackground: 5)
        back.renderLine(text: "Back")
        topTitle.renderLine(text: "Select Stage")
        
        stage1.renderLine(text: "1")
        stage2.renderLine(text: "2")
        stage3.renderLine(text: "3")
        stage4.renderLine(text: "4")
        stage5.renderLine(text: "5")
        stage6.renderLine(text: "6")
        stage7.renderLine(text: "7")
        stage8.renderLine(text: "8")
        stage9.renderLine(text: "9")
        stage10.renderLine(text: "10")
        stage11.renderLine(text: "11")
        stage12.renderLine(text: "12")
        
        stage1Block.renderUnclear()
        stage2Block.renderUnclear()
        stage3Block.renderUnclear()
        stage4Block.renderUnclear()
        stage5Block.renderUnclear()
        stage6Block.renderUnclear()
        stage7Block.renderUnclear()
        stage8Block.renderUnclear()
        stage9Block.renderUnclear()
        stage10Block.renderUnclear()
        stage11Block.renderUnclear()
        stage12Block.renderUnclear()
    }
    
    private static func pixel(_ pixel: Int) -> Float {
        return Float(2*pixel + 1)/Float(2048)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: stageView)
        let glPointX: Float = Float((touchPoint.x/stageView.bounds.width) * 2 - 1) * Float(stageView.bounds.width/stageView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/stageView.bounds.height) * 2 - 1) * -1
        
        if (back.touchedInside(x: glPointX, y: glPointY)) {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        if (stage1Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 1 Selected")
        }
        if (stage2Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 2 Selected")
        }
        if (stage3Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 3 Selected")
        }
        if (stage4Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 4 Selected")
        }
        if (stage5Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 5 Selected")
        }
        if (stage6Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 6 Selected")
        }
        if (stage7Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 7 Selected")
        }
        if (stage8Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 8 Selected")
        }
        if (stage9Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 9 Selected")
        }
        if (stage10Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 10 Selected")
        }
        if (stage11Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 11 Selected")
        }
        if (stage12Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("stage 12 Selected")
        }
        
        print("\(glPointX), \(glPointY)")
    }
}
