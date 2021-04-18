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

    //MARK: - Variables

    static let reuseIdentifier: String = "IYInvitationCell"

//    var closedOrOpenFlag: (() -> Void)? // создаем замыкание (1 из 3-х действий)

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
//        imageView.image = UIImage(systemName: nameLogo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var nameLogo: String = "face.smiling" { // времнно, чтобы протестить как отображается
        didSet {
            self.logoView.image = UIImage(systemName: nameLogo)
        }
    }
    private lazy var organizerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = fontFamilyLittle?.withSize(30)
        label.textColor = mainСolorBlue
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = fontFamilyLittle
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameOfEventLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = mainСolorBlue
        label.font = fontFamilyLittle
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = mainСolorBlue?.withAlphaComponent(0.5)
        label.textColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 40
        label.font = fontFamilyLittle?.withSize(18)
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

    private var closedOrOpenEventFlag: Bool = true { // true - открытое
        didSet {
            if closedOrOpenEventFlag {
                self.closedOrOpenEventView.image = UIImage(systemName: "lock.open")
                self.closedOrOpenEventView.tintColor = mainСolorBlue
            } else {
                self.closedOrOpenEventView.image = UIImage(systemName: "lock")
                self.closedOrOpenEventView.tintColor = notСolorPink
            }
        }
    }

    //MARK: - Initializators

    override init(style: IYInvitationCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initCell()
    }

    required init?(coder: NSCoder) { // FIX
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions

    func initCell() {
        self.contentView.backgroundColor = backgroundСolorWhite
        self.contentView.addSubview(self.cardContainerView)
        self.cardContainerView.addSubview(self.logoView)
        self.cardContainerView.addSubview(self.organizerLabel)
        self.cardContainerView.addSubview(self.dateLabel)
        self.cardContainerView.addSubview(self.addressLabel)
        self.cardContainerView.addSubview(self.nameOfEventLabel)
        self.cardContainerView.addSubview(self.closedOrOpenEventView)
        self.updateConstraints()
        self.selectionStyle = .none // чтобы при выборе ячейки она не подсвечивалась
    }

    func setCell(model: ExampleInvites) {
        self.nameLogo = model.logo // передать изобаржение!!!!!!!!!!!!!!
        self.organizerLabel.text = model.nameOrganizer
        self.dateLabel.text = model.date
        self.nameOfEventLabel.text = model.nameOfEvent
        self.closedOrOpenEventFlag = model.closedOrOpen
        self.addressLabel.text = model.address

        self.setNeedsUpdateConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        self.backgroundColor = selected ? .lightGray : .white // фон ячейки при наведении
    }

    //MARK: - Constraints

    override func updateConstraints() {
        self.cardContainerView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.bottom.equalToSuperview().inset(10)
            make.height.greaterThanOrEqualTo(50)
        }
        self.logoView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(10)
            make.size.equalTo(80)
        }
        self.organizerLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(10)
            make.left.equalTo(self.logoView.snp.right).offset(10)
        }
        self.nameOfEventLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.organizerLabel.snp.bottom).offset(10)
            make.left.equalTo(self.logoView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalTo(self.dateLabel.snp.top).offset(-10)
        }
        self.addressLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.dateLabel.snp.left).offset(-10)
            make.left.equalTo(self.closedOrOpenEventView.snp.right).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        self.dateLabel.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().inset(10)
            make.size.equalTo(80)
        }
        self.closedOrOpenEventView.snp.makeConstraints { (make) in
            make.bottom.left.equalToSuperview().inset(10)
            make.size.equalTo(25)
        }
        super.updateConstraints()
    }

}
