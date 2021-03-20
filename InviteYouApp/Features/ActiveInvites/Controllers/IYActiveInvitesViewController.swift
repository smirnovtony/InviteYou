//
//  IYActiveInvitesViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit

class IYActiveInvitesViewController: UITableViewController {

    //MARK: - var

        private var invites: [String] = [
            "Invitation Ex"
        ]
    //MARK: - life cycle
        override func viewDidLoad() {
            super.viewDidLoad()

            self.title = "Invites"

//            self.tableView.allowsMultipleSelection = true // выбор нескольких ячеек (появляется выделение)
            self.tableView.separatorStyle = .none // убрать разделитель таблицы
            self.tableView.backgroundColor = backgroundСolorWhite
            self.tableView.showsVerticalScrollIndicator = false // убрать полосочку скрола
            self.tableView.register(IYInvitationCell.self, forCellReuseIdentifier: IYInvitationCell.reuseIdentifier) // регистрация ячейки, .self обязательно

            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(createButtonTapped))
            navigationItem.rightBarButtonItem?.tintColor = .white
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.invites.count // число ячеек
        }

        // создание ячейки
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            // создаем ячейку WAPlaceCell (имя класса) автоматически и добавляем ее в таблицу, если ее нет
            let cell = tableView.dequeueReusableCell(withIdentifier: IYInvitationCell.reuseIdentifier,
                                                     for: indexPath) as? IYInvitationCell ?? IYInvitationCell()

            // передача данных
            cell.set(organizerLable: "Event Organizer",
                     addressLable: "Address",
                     dataLable: "Data")

            return cell
        }

        // действие при выбре ячейки
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.navigationController?.pushViewController(IYDetailsViewController(), animated: true)
        }

    //MARK: - ButtonTapped

    @objc private func createButtonTapped() { // изменить на правильный адрес
        navigationController?.pushViewController(IYCreateInviteViewController(), animated: true)
    }

    
}
