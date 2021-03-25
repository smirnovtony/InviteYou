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
        label.font = fontFamilyMiddle
        label.textColor = mainСolorGreen
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var nameEventLable: UILabel = {
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
        label.textColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 40
        label.font = fontFamilyLittle
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var closedOrOpenEventView: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(systemName: "lock") // если мероприятие закрытое, то "lock", если открытое то "lock.open" и .tintColor = mainColorGreen
        imageView.tintColor = notСolorPink

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        self.cardContainerView.addSubview(self.nameEventLable)
        self.cardContainerView.addSubview(self.dataLable)

        self.cardContainerView.addSubview(self.closedOrOpenEventView)


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
            make.top.right.equalToSuperview().inset(15)
            make.left.equalTo(self.logoView.snp.right).offset(15)
        }
        self.nameEventLable.snp.makeConstraints { (make) in
            make.right.equalTo(self.dataLable.snp.left).offset(-15)
            make.left.equalTo(self.closedOrOpenEventView.snp.right).inset(10)
            make.bottom.equalToSuperview().inset(15)
        }
        self.dataLable.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().inset(10)
            make.size.equalTo(80)
        }
        self.closedOrOpenEventView.snp.makeConstraints { (make) in
            make.bottom.left.equalToSuperview().inset(10)
            make.size.equalTo(30)
        }

        super.updateConstraints()
    }

    func set(organizerLable: String, addressLable: String, dataLable: String) {
//        self.logoView // передать изобаржение!!!!!!!!!!!!!!
        self.organizerLable.text = organizerLable
        self.nameEventLable.text = addressLable
        self.dataLable.text = dataLable

        self.setNeedsUpdateConstraints()
    }

}

