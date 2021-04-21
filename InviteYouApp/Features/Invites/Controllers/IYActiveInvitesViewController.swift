//
//  IYActiveInvitesViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit
import Firebase

//protocol IYActiveInvitesViewControllerDelegate: class {
//    func editContactsChanged(I: Int)
//}
class IYActiveInvitesViewController: UITableViewController {
    //MARK: - Variables
//    weak var delegate: IYActiveInvitesViewControllerDelegate?
//    var cellIndexModel: CellIndexModel?
    private var invites: [IYIvent] = IYSharedData.sh.collectionInvites.sorted { $0.date.toDate() < $1.date.toDate() } .filter { (filtr) -> Bool in
        if filtr.id == IYSharedData.sh.idUser || filtr.subscribe == true { return true } else { return false } } {
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
//        setViewData()
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
//    var oneCellIvent: IYIvent = IYIvent(id: "", logo: "",
//                                        organizerName: "", infoAboutOrganizer: "",
//                                        nameOfEvent: "", typeOfIvent: "",
//                                        person: "", address: "",
//                                        date: "", time: "",
//                                        infoAboutEvent: "", closedOrOpen: 0,
//                                        subscribe: true, unsubscribe: false)
//    var indexxxx = 12345
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Do action",
                                                message: "",
                                                preferredStyle: .alert)
        let subscribe = UIAlertAction(title: "Subscribe", style: .default) { _ in
            UIImpactFeedbackGenerator(style: .light).impactOccurred() // вибрация при нажатии
            //прописать логику!!!!!!!!!!!!!! установить в true
        }
        alertController.addAction(subscribe)
        let unsubscribe = UIAlertAction(title: "Unsubscribe", style: .destructive) { _ in
            UIImpactFeedbackGenerator(style: .light).impactOccurred() // вибрация при нажатии
            //прописать логику!!!!!!!!!!!!!! установить в false
        }
        alertController.addAction(unsubscribe)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            UIImpactFeedbackGenerator(style: .light).impactOccurred() // вибрация при нажатии
        }
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil) // показать
//        indexxxx = indexPath.row
//        cellData()
//        self.navigationController?.pushViewController(IYDetailsViewController(), animated: true)
    }
//    private func setViewData() {
//        indexxxx = self.cellIndexModel?.cellIndexModel ?? 99
//        print("FFFFF\(indexxxx)")
//    }
//    private func setModelData() {
//        guard let cellModel = self.cellIndexModel else { return }
//        cellModel.cellIndexModel = indexxxx
//        print("QQQQQQQQQ\(indexxxx)")
//        print("DDDDDDDD\(cellModel.cellIndexModel)")
//    }
//    func cellData() {
//        setModelData()
//        let I = indexxxx
//        delegate?.editContactsChanged(I: I)
//    }
//    func readOneCell(i: Int) {
//        for (index, document) in self.filteredInvites.enumerated() {
//            if i == index {
//                var result: IYIvent
//                result = IYIvent(id: document.id,
//                                 logo: document.logo,
//                                 organizerName: document.organizerName,
//                                 infoAboutOrganizer: document.infoAboutEvent,
//                                 nameOfEvent: document.nameOfEvent,
//                                 typeOfIvent: document.typeOfIvent,
//                                 person: document.person,
//                                 address: document.address,
//                                 date: document.date,
//                                 time: document.time,
//                                 infoAboutEvent: document.infoAboutEvent,
//                                 closedOrOpen: document.closedOrOpen,
//                                 subscribe: document.subscribe,
//                                 unsubscribe: document.unsubscribe)
//                oneCellIvent = result
//            }
//        }
//    }

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
