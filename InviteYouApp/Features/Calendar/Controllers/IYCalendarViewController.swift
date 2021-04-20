//
//  IYCalendarViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit

class IYCalendarViewController: IYViewController {

    //MARK: - Variables
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User name"
        customLabel(label)
        return label
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calendar"
        self.view.addSubview(userNameLabel)
        setUpConstraintsFunction()
        print("######\(IYSharedData.sh.collectionInvites)")
    }
    //MARK: - ButtonTapped
    //MARK: - Constraints
    func setUpConstraintsFunction() {
        self.userNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(130)
            make.left.right.equalToSuperview().inset(30)
            make.height.width.equalTo(30)
        }
    }
}
