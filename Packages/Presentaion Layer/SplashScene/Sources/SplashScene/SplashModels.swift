//
//  SplashModels.swift
//  
//

import UIKit

enum Splash {
    // MARK: Use cases
    enum RouteScene {
        enum SceneTypes {
            case main
        }
        
        struct Response {
            var scene: SceneTypes
        }
        
        struct ViewModel {
            var scene: SceneTypes
        }
    }
    
    enum Views {
        struct Response {
            var prepare: Bool
        }
        
        struct ViewModel {
            var prepare: Bool
            var sceneTitle: String
        }
    }
}
