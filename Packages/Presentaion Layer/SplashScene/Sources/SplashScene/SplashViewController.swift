//
//  SplashViewController.swift
//  
//

import MKUtils
import UIKit

protocol SplashDisplayLogic: AnyObject {
    func displayView(viewModel: Splash.Views.ViewModel)
    func displayNextScene(viewModel: Splash.RouteScene.ViewModel)
}

public class SplashViewController: UIViewController {
    var interactor: SplashBusinessLogic?
    var router: (SplashRoutingLogic & SplashDataPassing)?

    // MARK: Object lifecycle
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    deinit {
        Debug.print("")
    }
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .black
        v.font = UIFont.systemFont(ofSize: 19)
        v.alpha = 0.3
        return v
    }()
    
    // MARK: - Setup Clean Code Design Pattern 

    private func setup() {
        let viewController = self
        let interactor = SplashInteractor()
        let presenter = SplashPresenter()
        let router = SplashRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.interactor?.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor?.prepareNextScene()
    }
}

// MARK: - UI
extension SplashViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.titleLabel)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            
        ])
    }
    
}

// MARK: - display view model from SplashPresenter
extension SplashViewController: SplashDisplayLogic {
    func displayNextScene(viewModel: Splash.RouteScene.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            switch viewModel.scene {
                case .main:
                    self?.router?.routeToMainScene() 
            }
        }
    }
    
    func displayView(viewModel: Splash.Views.ViewModel) {
        self.titleLabel.text = viewModel.sceneTitle
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                self?.titleLabel.alpha = viewModel.prepare
                ? 1.0
                : 0.5
            })
        
    }
}
