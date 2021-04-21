//
//  IYSubscriptionsViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 19.03.21.
//

import UIKit

class IYSearchViewController: UITableViewController {
    //MARK: - Variables
    private var invites: [IYIvent] = IYSharedData.sh.collectionInvites.sorted { $0.date.toDate() < $1.date.toDate()}.filter { $0.closedOrOpen == 0 } {
        didSet {
            IYSharedData.sh.collectionInvites = self.invites
            self.filteredInvites = self.invites
        }
    }
    private lazy var filteredInvites: [IYIvent] = self.invites {
        didSet {
            self.tableView.reloadData()
        }
    }
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        searchController.automaticallyShowsCancelButton = false
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    private var notificationText = "The search has not given any results"
    private lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = mainСolorBlue?.withAlphaComponent(0.5)
        label.font = fontFamilyLittle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Open invites"
            self.tableViewSetting()
            self.navigationItemSetting()
            self.searchControllerSetting()
        }
    private func tableViewSetting() {
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = backgroundСolorWhite
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(IYInvitationCell.self, forCellReuseIdentifier: IYInvitationCell.reuseIdentifier)
    }
    private func searchControllerSetting() {
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.barStyle = .black
        self.searchController.searchBar.searchTextField.textColor = mainСolorBlue
        self.searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        self.searchController.searchBar.searchTextField.font = fontFamilyLittle
    }
    private func navigationItemSetting() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(createButtonTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"),
//                                                            style: .done,
//                                                            target: self,
//                                                            action: #selector(filterButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationItem.searchController = self.searchController
    }
    //MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredInvites.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IYInvitationCell.reuseIdentifier,
                                                 for: indexPath) as? IYInvitationCell ?? IYInvitationCell()
        cell.setCell(model: self.filteredInvites[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.navigationController?.pushViewController(IYDetailsViewController(), animated: true)
    }
    func deleteCell(index: Int) {
        invites.remove(at: index)
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteCell(index: indexPath.row)
        }
    }
    //MARK: - ButtonTapped
    @objc private func createButtonTapped() {
        navigationController?.pushViewController(IYCreateInviteViewController(), animated: true)
    }
    //MARK: - Allert
//    @objc private func filterButtonTapped() {
//        let alertController = UIAlertController(title: "Filter",
//                                                message: "",
//                                                preferredStyle: .actionSheet)
//        let allAction = UIAlertAction(title: "All Ivents", style: .default) { _ in
//            self.filteredInvites = self.invites
//        }
//        alertController.addAction(allAction)
//        let myInvitationsAction = UIAlertAction(title: "I'm", style: .default) { _ in
//            self.filteredInvites = self.invites.filter { $0.id == IYSharedData.sh.idUser }
//        }
//        alertController.addAction(myInvitationsAction)
//        let otherInvitesAction = UIAlertAction(title: "Other invites", style: .destructive) { _ in
//            self.filteredInvites = self.invites.filter { $0.closedOrOpen == 1 }
//        }
//        alertController.addAction(otherInvitesAction)
//        self.present(alertController, animated: true)
//    }
}
//MARK: - Extensions
extension IYSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.isEmpty {
            self.filteredInvites = self.invites
        } else {
            self.filteredInvites = self.invites.filter {
                let result = $0.nameOfEvent.lowercased().contains(searchText.lowercased())
                if !result {
                    return $0.organizerName.lowercased().contains(searchText.lowercased())
                }
                return result
            }
        }
        if filteredInvites.count == 0 {
            self.view.addSubview(notificationLabel)
            self.notificationLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-100)
                make.left.right.equalToSuperview().inset(40)
            }
            notificationLabel.text = notificationText
        } else {
            notificationLabel.text = ""
        }
        self.tableView.reloadData()
    }

}
