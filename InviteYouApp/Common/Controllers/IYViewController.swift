//
//  ITViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 17.03.21.
//

import UIKit

class IYViewController: UIViewController {

    //MARK: - Variables

    private lazy var mainScrollView: UIScrollView = {
        let scroll = UIScrollView()
//        scroll.showsVerticalScrollIndicator = false // удалить индиктор скрола
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.backgroundColor = .clear
        return scroll
    }()

    private(set) lazy var mainView = UIView() // самая самая главная view. На нее все будет ложиться

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()

        self.view.backgroundColor = backgroundСolorWhite

        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.addSubview(self.mainView)

        self.mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }

        self.mainView.snp.makeConstraints { (make) in
            make.edges.width.equalToSuperview()
//            make.height.equalToSuperview() // если так, то скрол выключится
        }
    }
}
