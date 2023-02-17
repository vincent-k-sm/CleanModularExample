//
//  SplashInteractor.swift
//  
//

import UIKit

protocol SplashBusinessLogic {
    func viewDidLoad()
    func prepareNextScene()
}

protocol SplashDataStore {
    
}

class SplashInteractor: SplashDataStore {
    var presenter: SplashPresentationLogic?
    var worker: SplashWorkerProtocol?

    deinit {
        //
    }
   
}

// MARK: Do something (and send response to SplashPresenter)
extension SplashInteractor: SplashBusinessLogic {
    func viewDidLoad() {
        self.presenter?.presentView(response: .init(prepare: false))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.presenter?.presentView(response: .init(prepare: true))
        }
        
    }
    
    func prepareNextScene() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.presenter?.presentNextScene(response: .init(scene: .main))
        }
    }
}
