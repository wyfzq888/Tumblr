//
//  AppDelegate.swift
//  Tumblr
//
//  Created by caikaixuan on 2018/5/9.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if !CCAuthorizedManager.isAuthorized(){
            self.window?.rootViewController=CCAuthorizedController()
            self.window?.makeKeyAndVisible()
        }
        else{
            checkUserPasswd()
        }
        
        WXApi.registerApp(kWeChatAppID)
        
        return true
    }
    
    func changeRootTabBar(){
        
        let mainSB = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = mainSB.instantiateInitialViewController()
        self.window?.rootViewController=vc
        self.window?.makeKeyAndVisible()
        
    }

    func checkUserPasswd() {
        
        let vc = CCScrrenBlockViewController()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        self.checkUserPasswd()
        
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        var result = WXApi.handleOpen(url, delegate: self)
        
        if !result {
            result = CCAuthorizedManager.shared.handleOpenURL(url: url)
        }
        return result
    }
}

extension AppDelegate : WXApiDelegate{
    func onReq(_ req: BaseReq!) {
        print("req-----",req)
    }
    
    func onResp(_ resp: BaseResp!) {
        print("resp---",resp)
    }
}

