//
//  SplashPresenter.swift
//  
//

import UIKit

protocol SplashPresentationLogic {
    func presentView(response: Splash.Views.Response)
    func presentNextScene(response: Splash.RouteScene.Response)
}

class SplashPresenter {
    weak var viewController: SplashDisplayLogic?

    // MARK: Parse and calc respnse from SplashInteractor and send simple view model to SplashViewController to be displayed

    deinit {
        //
    }
    
}

extension SplashPresenter: SplashPresentationLogic {
    func presentNextScene(response: Splash.RouteScene.Response) {
        let viewModel: Splash.RouteScene.ViewModel = .init(
            scene: response.scene
        )
        self.viewController?.displayNextScene(viewModel: viewModel)
    }
    
    func presentView(response: Splash.Views.Response) {
        let viewModel: Splash.Views.ViewModel = .init(
            prepare: response.prepare,
            sceneTitle: Constnats.sceneTitle
        )
        self.viewController?.displayView(viewModel: viewModel)
    }

}

extension SplashPresenter {
    struct Constnats {
        static let sceneTitle: String = "Clean Modular Example"
    }
}
