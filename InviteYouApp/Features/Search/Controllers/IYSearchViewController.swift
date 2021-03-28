//
//  IYSubscriptionsViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 19.03.21.
//

import UIKit

class IYSearchViewController: UITableViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        self.view.backgroundColor = backgroundСolorWhite
        self.tableView.separatorStyle = .none // убрать разделитель таблицы
    }

}
