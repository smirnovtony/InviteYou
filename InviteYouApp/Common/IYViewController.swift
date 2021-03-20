//
//  ITViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 17.03.21.
//

import UIKit

// если SnapKit через СocoPods, то не надо import каждый раз

class IYViewController: UIViewController {

    private lazy var mainScrollView: UIScrollView = {
        let scroll = UIScrollView()
//        scroll.showsVerticalScrollIndicator = false // удалить индиктор скрола
        scroll.contentInsetAdjustmentBehavior = .never // хз почему, но надо
        scroll.backgroundColor = .clear

        return scroll
    }()

    private(set) lazy var mainView = UIView() // самая самая главная view. На нее все будет ложиться

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = backgroundСolorWhite

        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.addSubview(self.mainView)

        self.mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }

        self.mainView.snp.makeConstraints { (make) in
            make.edges.width.equalToSuperview() //  ширина как супервью, чтобы скролилось вертикально
//            make.height.equalToSuperview() // если так, то скрол выключится
        }
    }
}
