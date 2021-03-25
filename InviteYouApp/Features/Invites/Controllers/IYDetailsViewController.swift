//
//  IYDetailsViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//


// это окно красивой инфы
// отсюда по кнопке Edit будет переход на редактирование

import UIKit

class IYDetailsViewController: IYViewController {

    //MARK: - var

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "photography") // дeфолтная картинка, сюда логотип организации
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameOrganizerLabel: UILabel = {
        let label = UILabel()

        label.text = "Name Organizer"
        label.numberOfLines = 0
        label.textColor = mainСolorGreen
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

    private lazy var addressButton: UIButton = { // нажимаешь и открывается карта!!!!!!!!!!!!!!
        let button = UIButton()

        button.setTitle("Address", for: UIControl.State())
        button.setTitleColor(.black, for: UIControl.State())
        button.titleLabel?.font = fontFamilyLittle
        

//        button.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside) // действие кнопки

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
   
    private lazy var dateButton: UIButton = { // переход на календарь
        let button = UIButton()

        button.setTitle("Date", for: UIControl.State())
        button.titleLabel?.font = fontFamilyLittle
        button.setTitleColor(.white, for: UIControl.State())

        button.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false

        button.backgroundColor = mainСolorGreen?.withAlphaComponent(0.5)

        button.layer.cornerRadius = 15


        return button
    }()

    private lazy var timeButton: UIButton = { // переход на календарь
        let button = UIButton()

        button.setTitle("Time", for: UIControl.State())
        button.titleLabel?.font = fontFamilyLittle
        button.setTitleColor(.white, for: UIControl.State())

        button.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false

        button.backgroundColor = mainСolorGreen?.withAlphaComponent(0.5)

        button.layer.cornerRadius = 15


        return button
    }()

    private lazy var numberOfPersonsLabel: UILabel = {
        let label = UILabel()

        label.text = "** person"
        label.textColor = mainСolorGreen
        label.font = fontFamilyLittle
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var nameOfEventLabel: UILabel = {
        let label = UILabel()

        label.text = "Name of event"
        label.numberOfLines = 0
        label.textColor = mainСolorGreen
        label.font = fontFamilyLittle
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var typeOfEventLabel: UILabel = { // перечисление с возможностью ввести свое назвнание!!!!!
        let label = UILabel()

        label.text = "Type of event"
        label.numberOfLines = 0
        label.textColor = mainСolorGreen
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

    private lazy var openOrClosedLabel: UILabel = { // перечисление с возможностью ввести свое назвнание!!!!!
        let label = UILabel()

        label.text = "Open Or Closed"
        label.numberOfLines = 0
        label.textColor = mainСolorGreen
        label.font = fontFamilyLittle
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var subscribeButton: UIButton = { // значок даты начинает гореть ярко, а если unsubscribeButton, то красным
        let button = UIButton()

        button.setTitle("Subscribe", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State()) // цвет текста
        button.backgroundColor = mainСolorGreen // цвет кнопки
        button.titleLabel?.font = fontFamilyMiddle // шрифт (размер)
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 20
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.clipsToBounds = false

//        button.addTarget(self, action: #selector(subscribeButtonTapped), for: .touchUpInside) // действие кнопки

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var unsubscribeButton: UIButton = { // нажимаешь и открывается карта
        let button = UIButton()

        button.setTitle("Unsubscribe", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State()) // цвет текста
        button.backgroundColor = notСolorPink // цвет кнопки
        button.titleLabel?.font = fontFamilyMiddle // шрифт (размер)
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 20
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.clipsToBounds = false

//        button.addTarget(self, action: #selector(unsubscribeButtonTapped), for: .touchUpInside) // действие кнопки

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()



    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Details"

        navigationController?.navigationBar.tintColor = .white // цвет стрелки "назад"

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white

        self.mainView.addSubview(self.logoView)
        self.mainView.addSubview(self.nameOrganizerLabel)
        self.mainView.addSubview(self.infoAboutOrganizerLabel)
        self.mainView.addSubview(self.nameOfEventLabel)
        self.mainView.addSubview(self.typeOfEventLabel)
        self.mainView.addSubview(self.openOrClosedLabel)
        self.mainView.addSubview(self.addressButton)
        self.mainView.addSubview(self.dateButton)
        self.mainView.addSubview(self.timeButton)
        self.mainView.addSubview(self.numberOfPersonsLabel)
        self.mainView.addSubview(self.infoAboutEventLabel)
        self.mainView.addSubview(self.subscribeButton)
        self.mainView.addSubview(self.unsubscribeButton)

        self.setUpConstraintsFunction()
    }

    //MARK: - ButtonTapped

    @objc private func shareButtonTapped() {
        let text = "Invite You"
        guard let url = URL(string: "google.com") else { return } // изменить на правильный адрес!!!!!!!!!!!!!!!!!!
        let activityController = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)
        self.present(activityController, animated: true) {
            print("I Invite You")
        }
    }

    @objc private func calendarButtonTapped() {
        self.navigationController?.pushViewController(IYCalendarViewController(), animated: true)
    }
    
    //MARK: - Constraints

    func setUpConstraintsFunction() {
        self.logoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(140)
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
        self.addressButton.snp.makeConstraints { (make) in
            make.top.equalTo(numberOfPersonsLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.dateButton.snp.makeConstraints { (make) in
            make.top.equalTo(addressButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(-90)
            make.left.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        self.timeButton.snp.makeConstraints { (make) in
            make.top.equalTo(addressButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(90)
            make.right.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        self.infoAboutEventLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.openOrClosedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(infoAboutEventLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.subscribeButton.snp.makeConstraints { (make) in
            make.top.equalTo(openOrClosedLabel.snp.bottom).offset(30)
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
