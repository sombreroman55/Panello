//
//  AppDelegate.swift
//  Panello
//
//  Created by Andrew Roberts on 4/5/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    public static let title: TitleViewController = TitleViewController()
    public static let main: MainMenuViewController = MainMenuViewController()
    public static let endless: BackgroundSelectViewController = BackgroundSelectViewController()
    public static let time: TimeSelectViewController = TimeSelectViewController()
    public static let stage: StageSelectViewController = StageSelectViewController()
    public static let puzzle: PuzzleSelectViewController = PuzzleSelectViewController()
    public static let high: HighScoreViewController = HighScoreViewController()
    public static let tutorial: TutorialViewController = TutorialViewController()
    public static let credits: CreditsViewController = CreditsViewController()

    public static let context: EAGLContext = EAGLContext(api: .openGLES2)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: TitleViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        HighScoreLibrary.Instance.save()
        PuzzleLibrary.Instance.save()
        StageLibrary.Instance.save()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        HighScoreLibrary.Instance.load()
        PuzzleLibrary.Instance.load()
        StageLibrary.Instance.load()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

