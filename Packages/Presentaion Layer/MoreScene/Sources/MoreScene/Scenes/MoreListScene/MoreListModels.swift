//
//  MoreListModels.swift
//  
//

import UIKit

enum MoreList {
    // MARK: Use cases
    enum Views {
        struct Response {
            
        }
        
        struct ViewModel {
            var sceneTitle: String
        }
    }
    
    enum Contents {
        struct Response {
            
        }
        
        struct ViewModel {
            var datasource: [MoreListViewModel]
        }
    }
    
    enum MoreListViewModel {
        case help(v: [MoreListHelpItems])
        case share(v: [MoreListShareItems])
        case info(v: [MoreListAppInfoItems])
        
        var titleString: String {
            switch self {
                case .help:
                    return "도움말"
                    
                case .share:
                    return "앱 추천"
                    
                case .info:
                    return "앱 정보"
            }
        }
    }
    
    enum MoreListHelpItems: CaseIterable {
        case faq
        case contact
        
        var title: String {
            switch self {
                case .faq:
                    return "자주 묻는 질문"
                case .contact:
                    return "문의 하기"
            }
        }
        
        var landingURL: String {
            switch self {
                case .faq:
                    return "https://TEST"
                    
                case .contact:
                    return "https://TEST"
                
            }
        }
    }
    
    enum MoreListShareItems: CaseIterable {
        case shareApp
        case otherApps
        case review
        
        var title: String {
            switch self {
                    
                case .shareApp:
                    return "앱 공유하기"
                case .otherApps:
                    return "다른 앱"
                case .review:
                    return "리뷰하기"
            }
        }
        
        var landingURL: String {
            switch self {
                case .shareApp:
                    return "https://TEST"
                case .otherApps:
                    return "https://TEST"
                case .review:
                    return "https://TEST"
            }
        }
    }
    
    enum MoreListAppInfoItems: CaseIterable {
        case openSource
        case privacyPolicy
        case servicePolicy
        case appVersion
        
        var title: String {
            switch self {
                case .openSource:
                    return "오픈소스 라이선스"
                case .privacyPolicy:
                    return "개인정보 처리방침"
                case .servicePolicy:
                    return "서비스 이용약관"
                case .appVersion:
                    if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
                        return "앱 버전 : \(appVersion)"
                    }
                    else {
                        return "앱 버전"
                    }
                    
            }
        }
        
        var landingURL: String {
            switch self {
                case .openSource:
                    return ""
                case .privacyPolicy:
                    return "https://TEST"
                case .servicePolicy:
                    return "https://TEST"
                case .appVersion:
                    return "https://TEST"
            }
        }
    }
}
