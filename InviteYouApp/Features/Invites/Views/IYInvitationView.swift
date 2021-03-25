//
//  IYInvitationView.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 18.03.21.
//

//import UIKit
//import SnapKit
//
//
////   ВЬЮ В ЯЧЕЙКЕ
//
//class IYInvitationView: UIView {
//
//    private lazy var logoView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "photography")
////        imageView.layer.cornerRadius = 15
////        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
////        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    private lazy var organizerLable: UILabel = {
//        let label = UILabel()
//        label.font = fontFamilyLittle
//        label.textColor = mainСolor
//        label.text = "Organizer"
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
//
//    private lazy var adressLable: UILabel = {
//        let label = UILabel()
////        label.numberOfLines = 0
//        label.textColor = .black
//        label.font = fontFamilyLittle
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Adress"
//
//        return label
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.initView()
//    }
//
//    init() {
//        super.init(frame: CGRect.zero)
//        self.initView()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func initView() {
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        self.backgroundColor = UIColor.lightGray
//
//        self.layer.cornerRadius = 15
//
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowRadius = 6
//        self.layer.shadowOffset = CGSize(width: 0, height: 0)
//
//        self.addSubview(self.logoView)
//        self.addSubview(self.organizerLable)
//        self.addSubview(self.adressLable)
//    }
//
//    override func updateConstraints() {
//        self.logoView.snp.makeConstraints { (make) in
//            make.top.bottom.left.equalToSuperview().inset(5)
//        }
//        self.organizerLable.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().inset(5)
//            make.right.equalToSuperview().inset(10)
//            make.left.equalTo(self.logoView.snp.right).inset(10)
//        }
//        self.adressLable.snp.makeConstraints { (make) in
//            make.top.equalTo(self.organizerLable.snp.right).inset(10)
//            make.right.equalToSuperview().inset(10)
//            make.left.equalTo(self.logoView.snp.right).inset(10)
//        }
//
//        super.updateConstraints()
//    }
//
////    func setConstraintsWithSnapKit() {
////        self.logoView.snp.updateConstraints { (make) in
////            make.top.left.right.equalToSuperview()
////        }
////        self.organizerLable.snp.updateConstraints { (make) in
////            make.top.equalTo(self.logoView.snp.bottom).offset(15)
////            make.left.right.equalToSuperview().inset(15)
////        }
////        self.adressLable.snp.updateConstraints { (make) in
////            make.top.equalTo(self.organizerLable.snp.bottom).offset(5)
////            make.left.right.bottom.equalToSuperview().inset(15)
////        }
////
////    }
//}
////class MyViewController : UIViewController {
////
////    private lazy var contentView = PhotoView()
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        self.view.backgroundColor = .white
////
////        self.view.addSubview(contentView)
////
////        self.setUpConstraints()
////    }
////
////    func setUpConstraints() {
////
////    }
////}
//// Present the view controller in the Live View window
////let controller = MyViewController()
////PlaygroundPage.current.liveView = MyViewController().view
//
