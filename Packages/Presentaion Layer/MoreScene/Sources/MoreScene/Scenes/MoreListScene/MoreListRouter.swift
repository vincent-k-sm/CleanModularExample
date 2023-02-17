//
//  MoreListRouter.swift
//  
//

import UIKit

@objc public protocol MoreListRoutingLogic {
    
}

public protocol MoreListDataPassing {
    var dataStore: MoreListDataStore? { get }
}

public class MoreListRouter: MoreListDataPassing {
    weak var viewController: MoreListViewController?
    public var dataStore: MoreListDataStore?

    deinit {
        //
    }
}

extension MoreListRouter: MoreListRoutingLogic {
    // MARK: Routing (navigating to other screens)
    
}
