//
//  IYInfoView.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 20.03.21.
//

// ВЬЮ ДЛЯ ВВОДА ИНФЫ В ПРОФИЛЕ. не закончено!!!!!!!!!!!!

import UIKit

class IYInfoView: UIView {

    private lazy var contentInfoView: UIView = {
        let view = UIView()

        view.backgroundColor = .black

        return view
    }()

    private lazy var titleTextLable: UILabel = {
        let label = UILabel()

        label.text = "Name"
        label.textColor = mainСolorGreen
        label.font = fontFamilyLittle
        label.textAlignment = .left

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = .white
        textField.textColor = mainСolorGreen
        textField.font = fontFamilyLittle
        textField.borderStyle = .roundedRect
//        textField.placeholder = ""
        textField.clearButtonMode = .always
        textField.layer.shadowRadius = 20
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.gray.cgColor

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

//    // MARK: - init
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    // MARK: - func

    func initInfoView() {

        self.contentInfoView.addSubview(self.titleTextLable)
        self.contentInfoView.addSubview(self.descriptionTextField)
        
        self.setUpConstraintsFunction()
    }

    func set(title: String, desc: String) {
        self.titleTextLable.text = title
        self.descriptionTextField.text = desc

        self.setNeedsUpdateConstraints()

        initInfoView()
    }

    // MARK: - Constraints

    func setUpConstraintsFunction() {

        self.contentInfoView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
        self.titleTextLable.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        self.descriptionTextField.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview().inset(10)
            make.left.equalTo(titleTextLable.snp.right).inset(10)
        }
    }

}
