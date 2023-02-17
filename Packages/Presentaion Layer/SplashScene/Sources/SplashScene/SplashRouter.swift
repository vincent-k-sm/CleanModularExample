//
//  SplashRouter.swift
//  
//

import MKUtils
import MoreScene
import UIKit

@objc protocol SplashRoutingLogic {
    func routeToMainScene()
}

protocol SplashDataPassing {
    var dataStore: SplashDataStore? { get }
}

class SplashRouter: SplashDataPassing {
    weak var viewController: SplashViewController?
    var dataStore: SplashDataStore?

    deinit {
        //
    }
}

extension SplashRouter: SplashRoutingLogic {
    // MARK: Routing (navigating to other screens)
    func routeToMainScene() {
        let destinationVC = MoreListViewController()
        var destinationDS = destinationVC.router!.dataStore!
        self.passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        self.navigateToMainScene(source: viewController!, destination: destinationVC)
    }
    
    func passDataToSomewhere(source: SplashDataStore, destination: inout MoreListDataStore) {
        //
    }
    
    func navigateToMainScene(source: SplashViewController, destination: MoreListViewController) {
        let nav = UINavigationController(rootViewController: destination)
        UIWindow.key?.rootViewController = nav
        guard let window = UIWindow.key else { return }
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }}
