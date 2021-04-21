//
//  IYLoadingViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 20.04.21.
//

import UIKit

class IYLoadingViewController: IYViewController {
    //MARK: - Variables
    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = mainСolorBlue
        return view
    }()
    private lazy var appView: UIView = {
        let view = UIView()
        view.backgroundColor = mainСolorBlue
        view.layer.cornerRadius = 15
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var appLabel: UILabel = {
        let label = UILabel()
        label.text = "Invite.You"
        label.textColor = .white
        label.font = fontFamilyBig
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var byTonyLabel: UILabel = {
        let label = UILabel()
        label.text = "by Tony.S"
        label.textColor = mainСolorBlue
        label.font = fontFamilyLittle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        IYSharedData.sh.collectionInvites = []
        IYSharedData.sh.readCollectionInvites()
        self.view.addSubviews([
            self.appView,
            self.appLabel,
            self.indicator,
            self.byTonyLabel
        ])
        setUpConstraintsFunction()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.indicator.startAnimating()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.indicator.stopAnimating()
            if IYSharedData.sh.collectionInvites.count != 0 {
                let tabBarController = IYTabBarViewController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
            }
        }
    }
    //MARK: - Constraints
    func setUpConstraintsFunction() {
        self.appView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-150)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(80)
        }
        self.appLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.appView.snp.center)
        }
        self.indicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        self.byTonyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
