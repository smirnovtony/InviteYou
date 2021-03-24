//
//  IYInvitationCell.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 18.03.21.
//

import UIKit
import SnapKit

//     САМА ЯЧЕЙКА

class IYInvitationCell: UITableViewCell {

    static let reuseIdentifier: String = "IYInvitationCell"

    private lazy var cardContainerView: UIView = {
        let view = UIView()

        view.backgroundColor = backgroundСolorWhite
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 6
        view.layer.shouldRasterize = true
        view.clipsToBounds = false
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.shadowOffset = CGSize(width: 0, height: 0)

        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "photography") // дефолтная картинка, сюда логотип организации!!!!!!!!!

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var organizerLable: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.font = fontFamilyLittle?.withSize(17)
        label.textColor = mainСolorGreen
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var nameIventLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = fontFamilyLittle?.withSize(17)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var dataLable: UILabel = {
        let label = UILabel()

        label.backgroundColor = mainСolorGreen?.withAlphaComponent(0.5) // сделать его меняющимся в зависимости от даты: красный если прошло или отменено, зеленый если принял, желтый если не знаешь!!!!!!!!!!!!!!!!!!!!!!!!
        label.textColor = .white// цвет
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 40
        label.font = fontFamilyLittle
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(style: IYInvitationCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.initCell()
    }

    required init?(coder: NSCoder) { // FIX
        fatalError("init(coder:) has not been implemented")
    }

    func initCell() {
        self.contentView.backgroundColor = backgroundСolorWhite
        self.contentView.addSubview(self.cardContainerView)
        self.cardContainerView.addSubview(self.logoView)
        self.cardContainerView.addSubview(self.organizerLable)
        self.cardContainerView.addSubview(self.nameIventLable)
        self.cardContainerView.addSubview(self.dataLable)

        self.updateConstraints()
        self.selectionStyle = .none // чтобы при выборе ячейки она не подсвечивалась
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        self.backgroundColor = selected ? .lightGray : .white // фон ячейки при наведении
    }

    override func updateConstraints() {
        self.cardContainerView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.bottom.equalToSuperview().inset(15)
            make.height.greaterThanOrEqualTo(150)
        }
        self.logoView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(10)
            make.size.equalTo(80)
        }
        self.organizerLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(15)
            make.right.equalToSuperview().offset(-20)
            make.left.equalTo(self.logoView.snp.right).offset(10)
            make.bottom.equalTo(self.dataLable.snp.top).offset(-10)
        }
        self.nameIventLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.logoView.snp.bottom).offset(10)
            make.right.equalTo(self.dataLable.snp.left).offset(-20)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(15)
        }
        self.dataLable.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.size.equalTo(80)
        }
        super.updateConstraints()
    }

    func set(organizerLable: String, addressLable: String, dataLable: String) {
//        self.logoView // передать изобаржение!!!!!!!!!!!!!!
        self.organizerLable.text = organizerLable
        self.nameIventLable.text = addressLable
        self.dataLable.text = dataLable

        self.setNeedsUpdateConstraints()
    }

}

