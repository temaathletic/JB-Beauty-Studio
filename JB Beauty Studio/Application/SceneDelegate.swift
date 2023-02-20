//
//  SceneDelegate.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 02.01.2023.
//

import UIKit
import Firebase
import FirebaseDynamicLinks
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }


        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let link = URL(string: "https://mygame.example.com/?invitedby=\(uid)")
//        let referralLink = DynamicLinkComponents(link: link!, domainURIPrefix: "https://jbbeautystudio.page.link")
//
//        referralLink?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.example.ios")
//        referralLink?.iOSParameters?.minimumAppVersion = "1.0.1"
//        referralLink?.iOSParameters?.appStoreID = "123456789"
//
//        referralLink?.shorten { (shortURL, warnings, error) in
//          if let error = error {
//            print(error.localizedDescription)
//            return
//          }
////          self.invitationUrl = shortURL
//        }
        
        Auth.auth().addStateDidChangeListener { auth, user in
        let adminID = "mhewVm2L0sVqvqfaboXzBYYM8893"
            if user == nil {
                self.showUnAuthUser()
            } else if user != nil && user?.uid != adminID {
                self.showAuthUser()
            } else if user?.uid == adminID {
                self.showAuthAdminUser()
            }
        }
    }
    
    func showUnAuthUser() {
        let scene = WelcomeViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: scene)
    }
    
    func showAuthUser() {
        let scene = MainViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: scene)
    }
    
    func showAuthAdminUser() {
        let scene = AdminViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

