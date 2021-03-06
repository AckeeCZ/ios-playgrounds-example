//
//  LanguagesTableViewController.swift
//  ProjectSkeleton
//
//  Created by Dominik Vesely on 04/06/15.
//  Copyright (c) 2015 Ackee s.r.o. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

public class LanguagesTableViewController: BaseViewController {

    let viewModel: LanguagesTableViewModeling!
    let detailControllerFactory: LanguageDetailTableViewControllerFactory!

    weak var activityIndicator: UIActivityIndicatorView!
    weak var tableView: UITableView!
    weak var emptyView: UIView!
    weak var retryButton: UIButton!
    
    required public init(viewModel: LanguagesTableViewModeling, detailControllerFactory: @escaping LanguageDetailTableViewControllerFactory) {
        self.viewModel = viewModel
        self.detailControllerFactory = detailControllerFactory
        super.init(nibName: nil, bundle: nil)
    }

    func setupBindings() {
        tableView.reactive.reloadData <~ viewModel.cellModels.map { _ in }

        activityIndicator.reactive.isAnimating <~ viewModel.loadLanguages.isExecuting
        tableView.reactive.isHidden <~ viewModel.loadLanguages.isExecuting.or(viewModel.cellModels.map { $0.count == 0 })
        
        emptyView.reactive.isHidden <~ viewModel.cellModels.map { $0.count > 0}.or(viewModel.loadLanguages.isExecuting)
        
        retryButton.reactive.pressed = CocoaAction(viewModel.loadLanguages)
        retryButton.reactive.isEnabled <~ viewModel.loadLanguages.isExecuting.negated
    }

    override public func loadView() {
        super.loadView()

        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "languageCell")
        view.addSubview(tableView)

        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(tableView.superview!)
        }
        self.tableView = tableView

        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }

        self.activityIndicator = activityIndicator
        
        let emptyView = UIView()
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        self.emptyView = emptyView
        
        let emptyImageView = UIImageView(image: Asset.sad.image)
        emptyImageView.contentMode = .scaleAspectFit
        emptyView.addSubview(emptyImageView)
        emptyImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        let emptyTitleLabel = UILabel()
        emptyTitleLabel.font = UIFont.boldSystemFont(ofSize: 27)
        emptyTitleLabel.text = L10n.Languages.emptyTitle
        emptyView.addSubview(emptyTitleLabel)
        emptyTitleLabel.textAlignment = .center
        emptyTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emptyImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }

        let emptyDescriptionLabel = UILabel()
        emptyDescriptionLabel.text = L10n.Languages.emptyDescrption
        emptyDescriptionLabel.textAlignment = .center
        emptyDescriptionLabel.numberOfLines = 0
        
        emptyView.addSubview(emptyDescriptionLabel)
        emptyDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emptyTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        let retryButton = UIButton()
        retryButton.setBackgroundImage(UIColor.unicornBlue.image(), for: .normal)
        retryButton.clipsToBounds = true
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.setTitle(L10n.Languages.retryButton, for: .normal)
        retryButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        retryButton.layer.cornerRadius = 10
        emptyView.addSubview(retryButton)
        retryButton.snp.makeConstraints { (make) in
            make.top.equalTo(emptyDescriptionLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(0)
        }
        self.retryButton = retryButton

    }

    var previewingContext: UIViewControllerPreviewing!

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindings()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0

        viewModel.loadLanguages.apply().start()

        if #available(iOS 9.0, *) {
            previewingContext = registerForPreviewing(with: self, sourceView: tableView)
        }
    }

    override public func viewWillAppear(_ animated: Bool) {
        if let selected = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selected, animated: false)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func detailViewControllerForIndexPath(_ indexPath: IndexPath) -> UIViewController {
        let detailModel = viewModel.cellModels.value[indexPath.row]
        let controller = self.detailControllerFactory(detailModel)
        return controller
    }
}

// MARK: UITableViewDataSource
extension LanguagesTableViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModels.value.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LanguageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageTableViewCell
        cell.viewModel.value = viewModel.cellModels.value[indexPath.row]

        return cell
    }
}

// MARK: UITableViewDelegate
extension LanguagesTableViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = detailViewControllerForIndexPath(indexPath)
        navigationController?.pushViewController(controller, animated: true)
    }
}
//MARK : UIViewControllerPreviewingDelegate
extension LanguagesTableViewController: UIViewControllerPreviewingDelegate {

    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }

        return detailViewControllerForIndexPath(indexPath)
    }

    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}
