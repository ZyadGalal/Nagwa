//
//  AppDelegate.swift
//  NagwaTask
//
//  Created by Zyad Galal on 27/03/2022.
//

import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let listFilesViewController = ListFilesRouter.createListFilesViewController(directory: "")
        let navigationController = UINavigationController(rootViewController: listFilesViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
        return true
    }

}

