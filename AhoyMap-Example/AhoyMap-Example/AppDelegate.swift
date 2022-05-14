//
//  AppDelegate.swift
//  AhoyMap-Example
//
//  Created by Syed Ismail Ahamed on 14/05/2022.
//

import UIKit
import AhoyMap

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initialiseAhoyMapSDK()
        return true
    }

    func initialiseAhoyMapSDK() {

        AhoySDKManager.shared()
            .ahoySDKKey("oqwib0r5Z18qgSh6R/msPAzowMF15qIjkUa03rIXN99PnUFcXcmldw==")
            .headerBackgroundColor(UIColor(red: 66/255.0, green: 80/255, blue: 144/255, alpha: 1))
            .footerBackgroundColor(.white)
            .footerAccentColor(.black)
            .headerAccentColor(.white)
            .setAhoyMapKitDelegate(self)
            .build()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate : AhoySDKManagerDelegate {

    func didFailtoInitialiseAhoyMapKitSDK(error: Error) {
        print("AHOY MAPKIT SDK initialisation failed \(error)")

    }

    func didInitialiseAhoyMapKitSDK() {
        NotificationCenter.default.post(Notification(name: Notification.Name("SDKInitialised"), object: nil, userInfo: [:]))

        print("AHOY MAPKIT SDK initialisation successfull")
    }

}
