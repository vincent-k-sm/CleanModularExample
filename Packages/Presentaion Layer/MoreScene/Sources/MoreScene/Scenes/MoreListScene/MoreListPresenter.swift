//
//  MoreListPresenter.swift
//  
//

import UIKit

protocol MoreListPresentationLogic {
    func presentView(response: MoreList.Views.Response)
    func presentMoreList()
}

class MoreListPresenter {
    weak var viewController: MoreListDisplayLogic?
    
    // MARK: Parse and calc respnse from MoreListInteractor and send simple view model to MoreListViewController to be displayed
    
    deinit {
        //
    }
    
}

extension MoreListPresenter: MoreListPresentationLogic {
    
    func presentView(response: MoreList.Views.Response) {
        let viewModel: MoreList.Views.ViewModel = .init(
            sceneTitle: Constnats.sceneTitle
        )
        self.viewController?.displayView(viewModel: viewModel)
    }
    
    func presentMoreList() {
        let datasource: [MoreList.MoreListViewModel] = [
            .help(v: MoreList.MoreListHelpItems.allCases),
            .share(v: MoreList.MoreListShareItems.allCases),
            .info(v: MoreList.MoreListAppInfoItems.allCases)
        ]
        let viewModel: MoreList.Contents.ViewModel = .init(datasource: datasource)
        self.viewController?.displayMoreList(viewModel: viewModel)
    }
}

extension MoreListPresenter {
    struct Constnats {
        static let sceneTitle: String = "더 보기"
    }
}
