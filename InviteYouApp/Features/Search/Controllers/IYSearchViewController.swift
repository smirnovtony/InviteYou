//
//  IYSubscriptionsViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 19.03.21.
//

// логика: если событие subscibe, unsubscibe или think - то добавить на IYActiveInvitesViewController

import UIKit

private var exampleInvites = [
    ExampleInvites(logo: "hare.fill",
                   nameOrganizer: "Domino's pizza",
                   nameOfEvent: "2+2=5",
                   address: "ул. Ложинская, 3",
                   date: "30 May 2021",
                   closedOrOpen: true),
    ExampleInvites(logo: "ladybug.fill",
                   nameOrganizer: "Sushi House",
                   nameOfEvent: "50%",
                   address: "Логойский тракт, 35",
                   date: "8 Apr 2021",
                   closedOrOpen: false),
    ExampleInvites(logo: "icloud.fill",
                   nameOrganizer: "Семья Смирновых",
                   nameOfEvent: "ДР Антона",
                   address: "Восточная, 74-57",
                   date: "1 Jun 2021",
                   closedOrOpen: false),
    ExampleInvites(logo: "eyes.inverse",
                   nameOrganizer: "VOKA CINEMA by Silver Screen в ТРЦ Dana Mall",
                   nameOfEvent: "Майор Гром: Чумной Доктор",
                   address: "ул. Петра Мстиславца, 11",
                   date: "7 Apr 2021",
                   closedOrOpen: true),
    ExampleInvites(logo: "eyes.inverse",
                   nameOrganizer: "Музей миниатюр",
                   nameOfEvent: "Выставка: Страна мини",
                   address: "пр-т Независимости, 25",
                   date: "18 Oct 2021",
                   closedOrOpen: true)
]

class IYSearchViewController: UITableViewController {

    //MARK: - Initializators

    private var invites: [ExampleInvites] = exampleInvites {  // изм!!!
        didSet {
            self.filteredInvites = self.invites
        }
    }

    private lazy var filteredInvites: [ExampleInvites] = self.invites {
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
        self.title = "Search"
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = backgroundСolorWhite
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(IYInvitationCell.self, forCellReuseIdentifier: IYInvitationCell.reuseIdentifier)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(createButtonTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.searchController = self.searchController
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.barStyle = .black
        self.searchController.searchBar.searchTextField.textColor = mainСolorBlue
        self.searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        self.searchController.searchBar.searchTextField.font = fontFamilyLittle
    }

    //как упорядочить по дате?????!!!!!!!!!

    //MARK: - TableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredInvites.count
    }
    // создание ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // создаем ячейку  (имя класса) автоматически и добавляем ее в таблицу, если ее нет
        let cell = tableView.dequeueReusableCell(withIdentifier: IYInvitationCell.reuseIdentifier,
                                                 for: indexPath) as? IYInvitationCell ?? IYInvitationCell()
        // передача данных
        cell.setCell(model: self.filteredInvites[indexPath.row])
        return cell
    }
    // действие при выбре ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(IYDetailsViewController(), animated: true)
    }
    // удаление ячейки при сдвиге влево
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
                    return $0.nameOrganizer.lowercased().contains(searchText.lowercased())
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
