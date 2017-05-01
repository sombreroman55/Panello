//
//  TimeSelectViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/29/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class TimeSelectViewController: GLKViewController {
    
    // --------------------------------------------------------------------
    // MARK: - Instance data
    // --------------------------------------------------------------------
    
    /* Graphics */
    // Menu options
    private var back: TextRenderer!
    private var topTitle: TextRenderer!
    private var minuteTitle: TextRenderer!
    private var time1Block: SmallRenderer!
    private var time2Block: SmallRenderer!
    private var time3Block: SmallRenderer!
    private var time4Block: SmallRenderer!
    private var time5Block: SmallRenderer!
    private var time6Block: SmallRenderer!
    
    private var time1: TextRenderer!
    private var time2: TextRenderer!
    private var time3: TextRenderer!
    private var time4: TextRenderer!
    private var time5: TextRenderer!
    private var time6: TextRenderer!
    
    // Background
    private var timeSelectBackground: BackgroundRenderer!
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;
        self.preferredFramesPerSecond = 1
        
        let context = AppDelegate.context
        timeSelectView.context = context
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        timeSelectBackground = BackgroundRenderer()
        back = TextRenderer(startCoordinateX: -0.5, startCoordinateY: 0.85, scale: 0.22)
        topTitle = TextRenderer(startCoordinateX: -0.46, startCoordinateY: 0.7, scale: 0.25)
        minuteTitle = TextRenderer(startCoordinateX: -0.32, startCoordinateY: 0.6, scale: 0.25)
        
        time1Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: 0.35)
        time2Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: 0.35)
        time3Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: -0.15)
        time4Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: -0.15)
        time5Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: -0.65)
        time6Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: -0.65)
        
        time1 = TextRenderer(startCoordinateX: -0.265, startCoordinateY: 0.35, scale: 0.7)
        time2 = TextRenderer(startCoordinateX: 0.30, startCoordinateY: 0.35, scale: 0.7)
        time3 = TextRenderer(startCoordinateX: -0.30, startCoordinateY: -0.15, scale: 0.7)
        time4 = TextRenderer(startCoordinateX: 0.30, startCoordinateY: -0.15, scale: 0.7)
        time5 = TextRenderer(startCoordinateX: -0.30, startCoordinateY: -0.65, scale: 0.7)
        time6 = TextRenderer(startCoordinateX: 0.265, startCoordinateY: -0.65, scale: 0.55)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var timeSelectView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - BackgroundSelectViewController methods
    // --------------------------------------------------------------------
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        let height: GLsizei = GLsizei(timeSelectView.bounds.height * timeSelectView.contentScaleFactor)
        let offset: GLsizei = GLsizei((timeSelectView.bounds.height - timeSelectView.bounds.width) * -0.5 * timeSelectView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        timeSelectBackground.renderMenuBackground(menuBackground: 4)
        back.renderLine(text: "Back")
        topTitle.renderLine(text: "Select Time Limit")
        minuteTitle.renderLine(text: "In minutes")
        
        time1Block.renderSmallBorder()
        time2Block.renderSmallBorder()
        time3Block.renderSmallBorder()
        time4Block.renderSmallBorder()
        time5Block.renderSmallBorder()
        time6Block.renderSmallBorder()
        
        time1.renderLine(text: "1")
        time2.renderLine(text: "2")
        time3.renderLine(text: "3")
        time4.renderLine(text: "4")
        time5.renderLine(text: "5")
        time6.renderLine(text: "10")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: timeSelectView)
        let glPointX: Float = Float((touchPoint.x/timeSelectView.bounds.width) * 2 - 1) * Float(timeSelectView.bounds.width/timeSelectView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/timeSelectView.bounds.height) * 2 - 1) * -1
        
        if (back.touchedInside(x: glPointX, y: glPointY)) {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        if (time1Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            timeSelected(time: 60)
        }
        if (time2Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            timeSelected(time: 120)
        }
        if (time3Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            timeSelected(time: 180)
        }
        if (time4Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            timeSelected(time: 240)
        }
        if (time5Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            timeSelected(time: 300)
        }
        if (time6Block.touchedInsideBig(x: glPointX, y: glPointY)) {
            timeSelected(time: 600)
        }
    }
    
    func timeSelected(time: Int) {
        AppDelegate.endless.time = time
        self.navigationController?.pushViewController(AppDelegate.endless, animated: true)
    }
}
