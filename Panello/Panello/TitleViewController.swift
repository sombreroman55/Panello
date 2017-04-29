//
//  TitleViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/8/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

protocol TitleViewControllerDelegate {
    func moveToMainMenu()
}

class TitleViewController: GLKViewController {
    
    // --------------------------------------------------------------------
    // MARK: - Instance data
    // --------------------------------------------------------------------

    private var panelloTitle: TextRenderer!
    private var pressToStart: TextRenderer!
    private var titleBackground: BackgroundRenderer!
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    /// Overrides viewDidLoad for TitleViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;
        self.preferredFramesPerSecond = 1
        
        let context = AppDelegate.context
        titleView.context = context
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        let mtmm = UITapGestureRecognizer(target: self, action: #selector(moveToMainMenu))
        mtmm.numberOfTapsRequired = 1
        titleView.addGestureRecognizer(mtmm)
        
        panelloTitle = TextRenderer(startCoordinateX: -0.35, startCoordinateY: 0.4, scale: 0.5)
        pressToStart = TextRenderer(startCoordinateX: -0.42, startCoordinateY: -0.6, scale: 0.3)
        titleBackground = BackgroundRenderer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private var titleView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - TitleViewController methods
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
        
        let height: GLsizei = GLsizei(titleView.bounds.height * titleView.contentScaleFactor)
        let offset: GLsizei = GLsizei((titleView.bounds.height - titleView.bounds.width) * -0.5 * titleView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        titleBackground.renderMenuBackground(menuBackground: 1)
        panelloTitle.renderLine(text: "Panello")
        pressToStart.renderLine(text: "Touch anywhere")
    }
    
    func moveToMainMenu() {
        let mmvc: MainMenuViewController = MainMenuViewController()
        self.navigationController?.pushViewController(mmvc, animated: true)
    }
}
