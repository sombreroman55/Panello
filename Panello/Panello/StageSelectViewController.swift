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
        
        if (StageLibrary.Instance.getStageCleared(atIndex: 1)) {
            stage1Block.renderClear()
        }
        else {
            stage1Block.renderUnclear()
        }
        if (StageLibrary.Instance.getStageCleared(atIndex: 2)) {
            stage2Block.renderClear()
        }
        else {
            stage2Block.renderUnclear()
        }
        if (StageLibrary.Instance.getStageCleared(atIndex: 3)) {
            stage3Block.renderClear()
        }
        else {
            stage3Block.renderUnclear()
        }
        if (StageLibrary.Instance.getStageCleared(atIndex: 4)) {
            stage4Block.renderClear()
        }
        else {
            stage4Block.renderUnclear()
        }
        if (StageLibrary.Instance.getStageCleared(atIndex: 5)) {
            stage5Block.renderClear()
        }
        else {
            stage5Block.renderUnclear()
        }
        if (StageLibrary.Instance.getStageCleared(atIndex: 6)) {
            stage6Block.renderClear()
        }
        else {
            stage6Block.renderUnclear()
        }
        if (StageLibrary.Instance.getStageCleared(atIndex: 7)) {
            stage7Block.renderClear()
        }
        else {
            stage7Block.renderUnclear()
        }
        if (StageLibrary.Instance.getStageCleared(atIndex: 8)) {
            stage8Block.renderClear()
        }
        else {
            stage8Block.renderUnclear()
        }
        if (StageLibrary.Instance.getStageCleared(atIndex: 9)) {
            stage9Block.renderClear()
        }
        else {
            stage9Block.renderUnclear()
        }
        if (StageLibrary.Instance.getStageCleared(atIndex: 10)) {
            stage10Block.renderClear()
        }
        else {
            stage10Block.renderUnclear()
        }
        if (StageLibrary.Instance.getStageCleared(atIndex: 11)) {
            stage11Block.renderClear()
        }
        else {
            stage11Block.renderUnclear()
        }
        if (StageLibrary.Instance.getStageCleared(atIndex: 12)) {
            stage12Block.renderClear()
        }
        else {
            stage12Block.renderUnclear()
        }
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
            stageSelected(st: 1)
        }
        if (stage2Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            stageSelected(st: 2)
        }
        if (stage3Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            stageSelected(st: 3)
        }
        if (stage4Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            stageSelected(st: 4)
        }
        if (stage5Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            stageSelected(st: 5)
        }
        if (stage6Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            stageSelected(st: 6)
        }
        if (stage7Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            stageSelected(st: 7)
        }
        if (stage8Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            stageSelected(st: 8)
        }
        if (stage9Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            stageSelected(st: 9)
        }
        if (stage10Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            stageSelected(st: 10)
        }
        if (stage11Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            stageSelected(st: 11)
        }
        if (stage12Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            stageSelected(st: 12)
        }
        
        print("\(glPointX), \(glPointY)")
    }
    
    func stageSelected(st: Int) {
        let sgvc: GameViewController = GameViewController()
        sgvc.gt = 3
        switch (st) {
        case 1:
            sgvc.bg = 1
        case 2:
            sgvc.bg = 1
        case 3:
            sgvc.bg = 2
        case 4:
            sgvc.bg = 2
        case 5:
            sgvc.bg = 3
        case 6:
            sgvc.bg = 3
        case 7:
            sgvc.bg = 4
        case 8:
            sgvc.bg = 4
        case 9:
            sgvc.bg = 5
        case 10:
            sgvc.bg = 5
        case 11:
            sgvc.bg = 6
        case 12:
            sgvc.bg = 6
        default:
            sgvc.bg = 1
        }
        let game: StageGame = StageGame(withStage: st)
        sgvc.stage = game
        self.navigationController?.pushViewController(sgvc, animated: true)
    }
}
