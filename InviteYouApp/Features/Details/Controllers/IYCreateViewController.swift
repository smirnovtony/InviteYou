//
//  IYDetailsViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//


// это окно красивой инфы
// отсюда по кнопке Edit будет передох на редактирование

import UIKit

class IYCreateViewController: UIViewController {

    private lazy var backgroundColor: UIView = {
        let image = UIView()

        image.backgroundColor = backgroundСolor // добавляем картинку по имени
        image.contentMode = .scaleAspectFill // заполнение картинкой всего вью

        image.translatesAutoresizingMaskIntoConstraints = false // этот флаг обязателен для всех UI элементов

        return image
    }()



    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create An Ivent"

        self.view.addSubview(backgroundColor)

        self.setUpConstraintsFunction()


    }
    func setUpConstraintsFunction() {
        self.backgroundColor.snp.updateConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }








}
