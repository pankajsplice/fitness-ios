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
        
        if(UserDefaults.standard.value(forKey: UserDefaultConstants.loginToken.value) as? String != "")
        {
            AppDelegate.shared.navigate(to: .home)
        }
        else
        {
            AppDelegate.shared.navigate(to: .login)
        }
    }
    
    // MARK: - Private Methods
    func navigate(to destination: Destination) {
        var controller: UIViewController!
        
        switch destination {
        case .login:
            controller = LoginVC.instantiateFrom(storyboard: .onboarding)
            
        case .home:
            controller = DashboardVC.instantiateFrom(storyboard: .home)
        break
        }
        
        let navController = UINavigationController(rootViewController: controller)
        navController.isNavigationBarHidden = true
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

