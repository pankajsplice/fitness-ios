//
//  AppDelegate+Navigation.swift
//  GoFit
//


import UIKit

extension AppDelegate {
    
    enum Destination {
        case login, home
    }
    
    func navigateAsPerLoginStatus() {
        if UserDefaultsManager.loginToken == nil {
            AppDelegate.shared.navigate(to: .login)
        } else {
            AppDelegate.shared.navigate(to: .home)
        }
    }
    
    // MARK: - Private Methods
    func navigate(to destination: Destination) {
        var controller: UIViewController!
        
        switch destination {
        case .login:
            controller = LoginVC.instantiateFrom(storyboard: .onboarding)
            
        case .home:
            //controller = HomeVC.instantiateFrom(storyboard: .home)
        break
        }
        
        let navController = UINavigationController(rootViewController: controller)
        navController.isNavigationBarHidden = true
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

