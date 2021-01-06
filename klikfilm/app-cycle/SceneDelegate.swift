//
//  SceneDelegate.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var sceneDelegate: SceneDelegateType? = nil

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {        
        sceneDelegate = SceneDelegateFactory.makeDefault(window: window)
        sceneDelegate?.scene?(scene, willConnectTo: session, options: connectionOptions)
    }
}

