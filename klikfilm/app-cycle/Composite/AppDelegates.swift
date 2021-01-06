//
//  AppDelegates.swift
//  klikfilm
//
//  Created by Rangga Leo on 06/01/21.
//

import Firebase
import Siren

enum AppDelegateFactory {
    static func makeDefault(window: UIWindow? = nil) -> AppDelegateType {
        return CompositeAppDelegate(appDelegates: [
            StartupAppDelegate(window: window),
            ThirdPartyAppDelegate()
        ])
    }
}

class StartupAppDelegate: AppDelegateType {
    var window: UIWindow?
    
    init(window: UIWindow? = nil) {
        self.window = window
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let controller = getInitial()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.isHidden = true
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    private func getInitial() -> UIViewController {
        return DiscoverRouter.createDiscoverModule()
    }
}

class ThirdPartyAppDelegate: AppDelegateType {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        checkVersion()
        return true
    }
    
    private func checkVersion() {
        let siren = Siren.shared
        let rules = RulesManager(majorUpdateRules: .critical, minorUpdateRules: .annoying, patchUpdateRules: .default, revisionUpdateRules: .relaxed, showAlertAfterCurrentVersionHasBeenReleasedForDays: 0)
        siren.rulesManager = rules
        siren.wail()
    }
}
