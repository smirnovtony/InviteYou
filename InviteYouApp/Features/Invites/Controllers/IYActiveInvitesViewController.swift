//
//  IYActiveInvitesViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit

class IYActiveInvitesViewController: UITableViewController {

    //MARK: - var

        private var invites: [String] = [ //!!!!!!!!!!!!!!!!!!!!!!
            "Invitation Ex",
            "Invitation Ex",
            "Invitation Ex"
        ]

    private lazy var filteredInvites: [String] = self.invites //

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false // скрытие
        self.navigationItem.hidesSearchBarWhenScrolling = false // скрол
//        searchController.obscuresBackgroundDuringPresentation = false // затемнение экрана
//        searchController.searchBar.placeholder = "Tap to start searching"
        searchController.searchBar.searchTextField.backgroundColor = .white

        return searchController
    }()

    //MARK: - life cycle

        override func viewDidLoad() {
            super.viewDidLoad()

            self.title = "Invites"
//            self.tableView.allowsMultipleSelection = true // выбор нескольких ячеек (появляется выделение)
            self.tableView.separatorStyle = .none // убрать разделитель таблицы
            self.tableView.backgroundColor = backgroundСolorWhite
            self.tableView.showsVerticalScrollIndicator = false // убрать полосочку скрола
            self.tableView.register(IYInvitationCell.self, forCellReuseIdentifier: IYInvitationCell.reuseIdentifier)

            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(createButtonTapped))
            self.navigationItem.leftBarButtonItem?.tintColor = .white

            self.navigationItem.rightBarButtonItems = [self.editButtonItem]
            self.editButtonItem.tintColor = .white
            self.editButtonItem.setTitleTextAttributes([.font: fontFamilyLittle?.withSize(25) ?? UIFont.systemFont(ofSize: 30)], for: .normal)
            self.searchController.searchResultsUpdater = self // подчиненпие протоколу
            self.navigationItem.searchController = self.searchController // добавление searchController на NB
            }



        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.invites.count
        }

    // создание ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // создаем ячейку WAPlaceCell (имя класса) автоматически и добавляем ее в таблицу, если ее нет
        let cell = tableView.dequeueReusableCell(withIdentifier: IYInvitationCell.reuseIdentifier,
                                                 for: indexPath) as? IYInvitationCell ?? IYInvitationCell()

        // передача данных
        cell.set(organizerLable: "Organizer",
                 addressLable: "Adsress",
                 dataLable: "Date")

        return cell
    }

    // действие при выбре ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(IYDetailsViewController(), animated: true)
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool { // можно ли двигать ячейки
        return true
    }
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) { // как двигать ячейки
//        self.invites.swapAt(sourceIndexPath.row, destinationIndexPath.row) // .swapAt меняет местами два элемента в массиве
//        self.tableView.reloadData() //  обнавляем таблицу
//    }

    //MARK: - ButtonTapped

    @objc private func createButtonTapped() { // изменить на правильный адрес
        navigationController?.pushViewController(IYCreateInviteViewController(), animated: true)
    }
}

extension IYActiveInvitesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        self.filteredInvites = searchText.isEmpty
            ? self.invites
            : self.invites.filter { $0.lowercased().contains(searchText.lowercased()) } // изменить!!!!!!!!!!!!!!!!!
        self.tableView.reloadData()
    }
}