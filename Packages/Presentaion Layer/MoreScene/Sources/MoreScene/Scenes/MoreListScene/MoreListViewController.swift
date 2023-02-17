//
//  MoreListViewController.swift
//  
//

import UIKit

protocol MoreListDisplayLogic: AnyObject {
    func displayView(viewModel: MoreList.Views.ViewModel)
    func displayMoreList(viewModel: MoreList.Contents.ViewModel)
}

public class MoreListViewController: UIViewController {
    var interactor: MoreListBusinessLogic?
    public var router: (MoreListRoutingLogic & MoreListDataPassing)?

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
        //
    }
    
    // MARK: - Setup Clean Code Design Pattern 

    private func setup() {
        let viewController = self
        let interactor = MoreListInteractor()
        let presenter = MoreListPresenter()
        let router = MoreListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View lifecycle
    var datasource: [MoreList.MoreListViewModel] = []
    lazy var tableView: UITableView = {
        let v = UITableView(frame: .zero, style: .plain)
        v.dataSource = self
        v.rowHeight = UITableView.automaticDimension
        v.backgroundColor = .white
        v.contentInset = .zero
        v.sectionFooterHeight = 20
        return v
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupNavigationBar()
        self.interactor?.viewDidLoad()
    }
}

extension MoreListViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.datasource.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.datasource[section]
        switch section {
            
            case let .help(v):
                return v.count
                
            case let .share(v):
                return v.count
                
            case let .info(v):
                return v.count
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionItem = self.datasource[section]
        return sectionItem.titleString

    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionItem = self.datasource[indexPath.section]
        let cell: UITableViewCell = .init(style: .default, reuseIdentifier: nil)
        var contentTitle: String = ""

        switch sectionItem {
                
            case let .help(v):
                let cellItem = v[indexPath.row]
                contentTitle = cellItem.title
                
            case let .share(v):
                let cellItem = v[indexPath.row]
                contentTitle = cellItem.title
                
            case let .info(v):
                let cellItem = v[indexPath.row]
                contentTitle = cellItem.title
                
        }
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = contentTitle
            cell.contentConfiguration = content
        }
        else {
            cell.textLabel?.text = contentTitle
        }
        
        return cell
    }
    
}

// MARK: - UI
extension MoreListViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        let guide = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
            self.tableView.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 0),
            self.tableView.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: 0)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 19)
        ]

        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        
    }
}

// MARK: - display view model from MoreListPresenter
extension MoreListViewController: MoreListDisplayLogic {
    func displayMoreList(viewModel: MoreList.Contents.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.datasource = viewModel.datasource
            self?.tableView.reloadData()
        }
    }
    
    func displayView(viewModel: MoreList.Views.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.title = viewModel.sceneTitle
        }
    }
}
