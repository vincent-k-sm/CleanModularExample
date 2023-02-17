//
//  MoreListInteractor.swift
//  
//

import UIKit

protocol MoreListBusinessLogic {
    func viewDidLoad()
}

public protocol MoreListDataStore {
    
}

class MoreListInteractor: MoreListDataStore {
    var presenter: MoreListPresentationLogic?
    var worker: MoreListWorkerProtocol?

    deinit {
        //
    }
   
}

// MARK: Do something (and send response to MoreListPresenter)
extension MoreListInteractor: MoreListBusinessLogic {
    func viewDidLoad() {
        self.presenter?.presentView(response: .init())
        self.presenter?.presentMoreList()
    }
}
