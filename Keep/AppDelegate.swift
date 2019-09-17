//
//  AppDelegate.swift
//  Keep
//
//  Created by Damon on 17/3/8.
//  Copyright © 2017年 Damon. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
                
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playback)
        try! session.setActive(true)
        
        let tabbarController = KPTabBarController()
        tabbarController.delegate = self
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        // 加载Shortcuts
        configureDynamicShortcuts()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        if let window = window {
            tryQuickActionWithShortcutItem(shortcutItem, inWindow: window)
        }
        
        completionHandler(true)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        tryQuickActionWithTodayWidget(url, inWindow: window!)
                
        return true
    }

//    override func buildMenu(with builder: UIMenuBuilder) {
//        super.buildMenu(with: builder)
//
//        builder.remove(menu: .services)
//        builder.remove(menu: .format)
//        builder.remove(menu: .toolbar)
//
//        let discoveryCommand = UIKeyCommand(input: "D", modifierFlags: [.command], action: #selector(reloadData))
//        discoveryCommand.title = "发现"
//        let discoveryMenu = UIMenu(title: "发现", image: nil, identifier: UIMenu.Identifier("KPDiscoveryController"), options: .displayInline, children: [discoveryCommand])
//        builder.insertChild(discoveryMenu, atStartOfMenu: .view)
//
//        let preferencesCommand = UIKeyCommand(input: ",", modifierFlags: [.command], action: #selector(openPreferences))
//        preferencesCommand.title = "Preferences..."
//        let openPreferences = UIMenu(title: "Preferences...", image: nil, identifier: UIMenu.Identifier("openPreferences"), options: .displayInline, children: [preferencesCommand])
//        builder.insertSibling(openPreferences, afterMenu: .about)
//    }
//
//    @objc func reloadData() {
//
//    }
//
//    @objc func openPreferences() {
//
//    }
}

