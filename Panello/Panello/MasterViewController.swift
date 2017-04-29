//
//  MasterViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/27/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class MasterViewController: GLKViewController {
    
    private let context = EAGLContext(api: .openGLES2)
    
    // --------------------------------------------------------------------
    // MARK: - Child view controllers
    // --------------------------------------------------------------------
    private var titleViewController: TitleViewController? = nil
    private var mainMenuViewController: MainMenuViewController? = nil
    private var bgSelectViewController: BackgroundSelectViewController? = nil
    private var stageSelectViewController: StageSelectViewController? = nil
    private var puzzleSelectViewController: PuzzleSelectViewController? = nil
    private var gameViewController: GameViewController? = nil
    private var highScoreViewController: HighScoreViewController? = nil
    private var tutorialViewController: TutorialViewController? = nil
    private var creditsViewController: CreditsViewController? = nil
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    /// Overrides viewDidLoad for TitleViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleViewController = TitleViewController()
        addChildViewController(titleViewController!)
        view = titleViewController!.view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private var masterView: GLKView {
        return view as! GLKView
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }
    
    func moveToMainMenu() {
        // Change screen to main menu
        mainMenuViewController = MainMenuViewController()
//        let mainMenuView: GLKView = GLKView()
//        mainMenuView.context = context!
//        mainMenuViewController?.view = mainMenuView
        self.addChildViewController(mainMenuViewController!)
        mainMenuViewController?.didMove(toParentViewController: self)
//        masterView.addSubview(mainMenuView)
    }
}
