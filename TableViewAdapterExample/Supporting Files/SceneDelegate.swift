//
//  SceneDelegate.swift
//  TableViewAdapterExample
//
//  Created by seokho on 2021/06/28.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
    }

}

