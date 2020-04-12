//
//  SceneDelegate.swift
//  AppleDev-MC1
//
//  Created by Rahmat Zulfikri on 07/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }

//            window = UIWindow()
//            window?.windowScene = windowScene
//            let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = .horizontal
//            let swipingController = OnboardSwipingController(collectionViewLayout: layout)
//
//            window?.rootViewController = swipingController
//            window?.makeKeyAndVisible()
        
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            let mainstoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            let navigationController = UINavigationController(rootViewController: newViewcontroller)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

