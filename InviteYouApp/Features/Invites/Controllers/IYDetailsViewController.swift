//
//  IYDetailsViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit

class IYDetailsViewController: IYViewController {
//                               IYActiveInvitesViewControllerDelegate 
//    let userEditContacts = CellIndexModel()
//    let cellDeledate = IYActiveInvitesViewController()
//    func editContactsChanged(I i: Int) {
//        index = i
//    }
//    func setViewData() {
//        index = userEditContacts.cellIndexModel
//    }
//    var index: Int = 111

//    var oneIventFinal: IYIvent = IYIvent(id: "", logo: "",
//                                         organizerName: "", infoAboutOrganizer: "",
//                                         nameOfEvent: "", typeOfIvent: "",
//                                         person: "", address: "",
//                                         date: "", time: "",
//                                         infoAboutEvent: "", closedOrOpen: 0,
//                                         subscribe: true, unsubscribe: false)
//    var vc = IYActiveInvitesViewController()
    //MARK: - Variables

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "photography")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var closedOrOpenEventView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock")
        imageView.tintColor = notСolorPink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
//    {
//        didSet {
//            if closedOrOpenEventFlag == 0 {
//                self.closedOrOpenEventView.image = UIImage(systemName: "lock.open")
//                self.closedOrOpenEventView.tintColor = mainСolorBlue
//            } else if closedOrOpenEventFlag == 1 {
//                self.closedOrOpenEventView.image = UIImage(systemName: "lock")
//                self.closedOrOpenEventView.tintColor = notСolorPink
//            }
//        }
    private lazy var nameOrganizerLabel: UILabel = {
        let label = UILabel()
        label.text = "Name Organizer"
        label.numberOfLines = 0
        label.textColor = mainСolorBlue
        label.font = fontFamilyMiddle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var infoAboutOrganizerLabel: UILabel = {
        let label = UILabel()
        label.text = "Info About The Organizer"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = fontFamilyLittle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address"
        label.textColor = .black
        label.font = fontFamilyLittle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = fontFamilyLittle
        label.textColor = .white
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = mainСolorBlue?.withAlphaComponent(0.5)
        label.layer.cornerRadius = 15
        return label
    }()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.font = fontFamilyLittle
        label.textColor = .white
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = mainСolorBlue?.withAlphaComponent(0.5)
        label.layer.cornerRadius = 15
        return label
    }()
    private lazy var numberOfPersonsLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of persons"
        label.textColor = .black
        label.font = fontFamilyLittle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var nameOfEventLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of event"
        label.numberOfLines = 0
        label.textColor = mainСolorBlue
        label.font = fontFamilyLittle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var typeOfEventLabel: UILabel = {
        let label = UILabel()
        label.text = "Type of event"
        label.numberOfLines = 0
        label.textColor = mainСolorBlue
        label.font = fontFamilyLittle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var infoAboutEventLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        // swiftlint:disable line_length
        label.text = """
Info About Event.
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vestibulum erat eget aliquet semper. Integer mattis ultrices erat eget vestibulum. Suspendisse tempor felis at scelerisque varius. Nam viverra lorem in mauris consequat, id fermentum risus porta. Vestibulum lobortis leo sit amet fringilla finibus. Vivamus eget fermentum enim, eu mollis quam.
"""
        label.textColor = .black
        label.font = fontFamilyLittle
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var subscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Subscribe", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = mainСolorBlue
        customButton(button)
//        button.addTarget(self, action: #selector(subscribeButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var unsubscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Unsubscribe", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = notСolorPink
        customButton(button)
//        button.addTarget(self, action: #selector(unsubscribeButtonTapped), for: .touchUpInside) /
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        self.navigationControllerSetting()
        self.mainView.addSubviews([
            self.logoView,
            self.closedOrOpenEventView,
            self.nameOrganizerLabel,
            self.infoAboutOrganizerLabel,
            self.nameOfEventLabel,
            self.typeOfEventLabel,
            self.addressLabel,
            self.dateLabel,
            self.timeLabel,
            self.numberOfPersonsLabel,
            self.infoAboutEventLabel,
            self.subscribeButton,
            self.unsubscribeButton
        ])
        self.setUpConstraintsFunction()
//        cellDeledate.delegate = self
//        setViewData()
//        print("FIFIFIF\(index)")
    }
    private func navigationControllerSetting() {
    navigationController?.navigationBar.tintColor = .white
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                        style: .done,
                                                        target: self,
                                                        action: #selector(shareButtonTapped))
    navigationItem.rightBarButtonItem?.tintColor = .white
    }
    //MARK: - ButtonTapped
    @objc private func shareButtonTapped() {
        let text = "Invite You"
        guard let url = URL(string: "google.com") else { return } // изменить на правильный адрес!!!!!!!!!!!
        let activityController = UIActivityViewController(activityItems: [text, url],
                                                          applicationActivities: nil)
        self.present(activityController, animated: true) {
            print("I Invite You")
        }
    }
//    private func setData(selectedCell: Int?) {
//        var invatesCell = IYActiveInvitesViewController()
////        guard textLabel != nil else { return }vc2.callback = { text in
////        self..text = text
////    }
//
//        print("\(String(describing: selectedCell))!!!!!!!!!!!!!")
//        for (_, cell) in IYSharedData.sh.collectionInvites.enumerated() {
//            self.nameOrganizerLabel.text = cell.infoAboutEvent
////                print("\(cell.organizerName)!!!!!!!!!!!!!")
////                print("\(selection)!!!!!!!!!!!!!")
//            }
//        }
//
////    func presentVC2() {
//        var vc2 = IYActiveInvitesViewController()
//        vc2.callback = { text in
//            self.textLabel.text = text
//        }
//        self.present(vc2, animated: true, completion: nil)
//    }
    //MARK: - Constraints
    func setUpConstraintsFunction() {
        self.logoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(140)
        }
        self.closedOrOpenEventView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(40)
            make.size.equalTo(30)
        }
        self.nameOrganizerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
        }
        self.infoAboutOrganizerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameOrganizerLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
        }
        self.nameOfEventLabel.snp.makeConstraints { (make) in
            make.top.equalTo(infoAboutOrganizerLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.typeOfEventLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameOfEventLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
        }
        self.numberOfPersonsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeOfEventLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.addressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(numberOfPersonsLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(addressLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview().offset(-90)
            make.left.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(addressLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview().offset(90)
            make.right.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        self.infoAboutEventLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.subscribeButton.snp.makeConstraints { (make) in
            make.top.equalTo(infoAboutEventLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        self.unsubscribeButton.snp.makeConstraints { (make) in
            make.top.equalTo(subscribeButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
