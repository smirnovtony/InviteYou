//
//  IYInvitationCell.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 18.03.21.
//

import UIKit

class IYInvitationCell: UITableViewCell {
    //MARK: - Variables
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
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
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
        label.font = fontFamilyLittle?.withSize(20)
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
    private lazy var numberOfPersonsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = fontFamilyLittle?.withSize(17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var typeOfEventLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = fontFamilyLittle?.withSize(17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = mainСolorBlue?.withAlphaComponent(0.5)
        label.textColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.font = fontFamilyLittle?.withSize(18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = mainСolorBlue?.withAlphaComponent(0.5)
        label.textColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.font = fontFamilyLittle?.withSize(18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var myIventView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = mainСolorBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var myIventFlag: String = "" {
        didSet {
            if !myIventFlag.isEmpty, myIventFlag == IYSharedData.sh.idUser {
                self.myIventView.image = UIImage(systemName: "face.smiling")
            }
        }
    }
    private lazy var closedOrOpenEventView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = notСolorPink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var closedOrOpenEventFlag: Int = 0 {
        didSet {
            if closedOrOpenEventFlag == 0 {
                self.closedOrOpenEventView.image = UIImage(systemName: "lock.open")
                self.closedOrOpenEventView.tintColor = mainСolorBlue
            } else {
                self.closedOrOpenEventView.image = UIImage(systemName: "lock")
                self.closedOrOpenEventView.tintColor = notСolorPink
            }
        }
    }
    private lazy var subscribeView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var subscribeFlag: Bool = true {
        didSet {
            if subscribeFlag {
                self.subscribeView.image = UIImage(systemName: "plus")
                self.subscribeView.tintColor = mainСolorBlue
            } else {
                self.subscribeView.image = UIImage(systemName: "minus")
                self.subscribeView.tintColor = notСolorPink
            }
        }
    }
    //MARK: - Initializators
    override init(style: IYInvitationCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - FunctionsCell
    func initCell() {
        self.contentView.backgroundColor = backgroundСolorWhite
        self.contentView.addSubview(self.cardContainerView)
        self.cardContainerView.addSubviews([
            self.logoView,
            self.organizerLabel,
            self.dateLabel,
            self.addressLabel,
            self.nameOfEventLabel,
            self.closedOrOpenEventView,
            self.myIventView,
            self.numberOfPersonsLabel,
            self.typeOfEventLabel,
            self.timeLabel,
            self.subscribeView
        ])
        self.updateConstraints()
        self.selectionStyle = .none
    }
    func setCell(model: IYIvent) {
        guard let url = URL(string: model.logo ) else { return }
        UIImage.loadFrom(url: url) { image in
            self.logoView.image = image
        }
        self.organizerLabel.text = model.organizerName
        self.dateLabel.text = model.date
        self.nameOfEventLabel.text = model.nameOfEvent
        self.closedOrOpenEventFlag = model.closedOrOpen
        self.addressLabel.text = model.address
        self.myIventFlag = model.id
        self.numberOfPersonsLabel.text = model.person
        self.typeOfEventLabel.text = model.typeOfIvent
        self.timeLabel.text = model.time
        self.subscribeFlag = model.subscribe
        self.setNeedsUpdateConstraints()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK: - Constraints
    override func updateConstraints() {
        self.cardContainerView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.bottom.equalToSuperview().inset(10)
            make.height.greaterThanOrEqualTo(120)
        }
        self.logoView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(10)
            make.size.equalTo(80)
        }
        self.organizerLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(10)
            make.left.equalTo(self.logoView.snp.right).offset(10)
            make.right.equalToSuperview().inset(30)
        }
        self.nameOfEventLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.organizerLabel.snp.bottom).offset(5)
            make.left.equalTo(self.logoView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalTo(self.dateLabel.snp.top).offset(-10)
        }
        self.typeOfEventLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.dateLabel.snp.top).offset(5)
            make.right.equalTo(self.dateLabel.snp.left).offset(-10)
        }
        self.numberOfPersonsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.typeOfEventLabel.snp.bottom)
            make.right.equalTo(self.dateLabel.snp.left).offset(-10)
        }
        self.addressLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.dateLabel.snp.left).offset(-15)
            make.left.equalTo(self.closedOrOpenEventView.snp.right).offset(10)
            make.bottom.equalTo(self.timeLabel.snp.bottom)
        }
        self.dateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.timeLabel.snp.top).offset(-10)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        self.timeLabel.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().inset(10)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        self.subscribeView.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(10)
            make.size.equalTo(25)
        }
        self.closedOrOpenEventView.snp.makeConstraints { (make) in
            make.bottom.left.equalToSuperview().inset(10)
            make.size.equalTo(25)
        }
        self.myIventView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.closedOrOpenEventView.snp.top).inset(-10)
            make.left.equalToSuperview().inset(10)
            make.size.equalTo(25)
        }
        super.updateConstraints()
    }
}
