//
//  IYActiveInvitesViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit
import Firebase

class IYActiveInvitesViewController: UITableViewController {

    //MARK: - Variables

    private var invites: [IYIvent] = IYSharedData.sh.collectionInvites.sorted { $0.date.toDate() < $1.date.toDate() }.filter { (filter) -> Bool in
        if filter.id == IYSharedData.sh.idUser || filter.subscribe == true { return true } else { return false } } {
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
    private lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = mainСolorBlue?.withAlphaComponent(0.5)
        label.font = fontFamilyLittle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var notificationText = "The search has not given any results"

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My invites"
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"),
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(filterButtonTapped))
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
        let indexcell = self.invites[indexPath.row].nameOfEvent
        let alertController = UIAlertController(title: "Do action",
                                                message: "",
                                                preferredStyle: .alert)
        let subscribe = UIAlertAction(title: "Subscribe", style: .default) { _ in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            Firestore.firestore().collection("invites").document(indexcell).updateData(["subscribe": true])
            self.navigationController?.pushViewController(IYLoadingViewController(), animated: true)
        }
        alertController.addAction(subscribe)
        let unsubscribe = UIAlertAction(title: "Unsubscribe", style: .destructive) { _ in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            Firestore.firestore().collection("invites").document(indexcell).updateData(["subscribe": false])
            self.navigationController?.pushViewController(IYLoadingViewController(), animated: true)
        }
        alertController.addAction(unsubscribe)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }

    private func deleteCell(index: Int) {
        invites.remove(at: index)
        let deletedData = invites[index].nameOfEvent
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!\(deletedData)")
        Firestore.firestore().collection("invites").document(deletedData).updateData(["subscribe": false, "id": ""])
//        }
//        let deletedData = invites[index].nameOfEvent
//        let deletedData =
//        print("!!!!!!!!!!!!!!!!!!!!!!!!!\(deletedData)")
//        Firestore.firestore().collection("invites").document(deletedData).delete() { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.indexPathForSelectedRow
            print("!!!!!!!!!!!!!!!!!!!\(String(describing: tableView.deq))")
            guard let deletedDataCellRow = tableView.indexPathForSelectedRow else { return }
//            indexPathForSelectedRow?.row

            //            deleteCell(index: q111)
//                        deleteCell(index: deletedDataCellRow)
        }
    }

    //MARK: - ButtonTapped

    @objc private func createButtonTapped() {
        navigationController?.pushViewController(IYCreateInviteViewController(), animated: true)
    }

    @objc private func filterButtonTapped() {
        let alertController = UIAlertController(title: "Filter",
                                                message: "",
                                                preferredStyle: .actionSheet)
        let allAction = UIAlertAction(title: "All Ivents", style: .cancel) { _ in
            self.filteredInvites = self.invites
            self.title = "My invites"
        }
        alertController.addAction(allAction)
        let myInvitationsAction = UIAlertAction(title: "I'm organizer", style: .default) { _ in
            self.filteredInvites = self.invites.filter { $0.id == IYSharedData.sh.idUser }
            self.title = "I'm organizer"
        }
        alertController.addAction(myInvitationsAction)
        let subscribeAction = UIAlertAction(title: "Subscribe", style: .default) { _ in
            self.filteredInvites = self.invites.filter { $0.subscribe == true }
            self.title = "Subscribe"
        }
        alertController.addAction(subscribeAction)
        self.present(alertController, animated: true)
    }
}

//MARK: - Extensions

extension IYActiveInvitesViewController: UISearchResultsUpdating {
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
        if filteredInvites.count == 0, !searchText.isEmpty {
            self.tableView.addSubview(notificationLabel)
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
