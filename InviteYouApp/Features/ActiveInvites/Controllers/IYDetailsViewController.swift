//
//  IYDetailsViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//


// это окно красивой инфы
// отсюда по кнопке Edit будет передох на редактирование

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
        label.font = fontFamilyMiddle // шрифт (размер)
        label.textAlignment = .center // выравнивание текста

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var infoAboutOrganizerLabel: UILabel = {
        let label = UILabel()

        label.text = "Info About The Organizer"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = fontFamilyLittle // шрифт (размер)
        label.textAlignment = .center // выравнивание текста

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var addressButton: UIButton = { // нажимаешь и открывается карта
        let button = UIButton()

        button.setTitle("Address", for: UIControl.State())
        button.setTitleColor(.black, for: UIControl.State()) // цвет текста
        button.titleLabel?.font = fontFamilyLittle // шрифт (размер)
        

//        button.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside) // действие кнопки

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var dataLable: UIButton = { // переход на календарь
        let button = UIButton()

        button.setTitle("Data", for: UIControl.State())
        button.titleLabel?.font = fontFamilyLittle
        button.setTitleColor(mainСolorGreen, for: UIControl.State())

        button.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside) // действие кнопки

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var infoAboutIventLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        // swiftlint:disable line_length
        label.text = """
Info About Ivent.
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vestibulum erat eget aliquet semper. Integer mattis ultrices erat eget vestibulum. Suspendisse tempor felis at scelerisque varius. Nam viverra lorem in mauris consequat, id fermentum risus porta. Vestibulum lobortis leo sit amet fringilla finibus. Vivamus eget fermentum enim, eu mollis quam.
"""
        label.textColor = .black
        label.font = fontFamilyLittle // шрифт (размер)
        label.textAlignment = .justified // выравнивание текста

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var subscribeButton: UIButton = { // нажимаешь и открывается карта
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

        navigationController?.navigationBar.tintColor = .white // цвет стрелки "назад"

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white

        self.title = "Details"

        self.mainView.addSubview(self.logoView)
        self.mainView.addSubview(self.nameOrganizerLabel)
        self.mainView.addSubview(self.infoAboutOrganizerLabel)
        self.mainView.addSubview(self.addressButton)
        self.mainView.addSubview(self.dataLable)
        self.mainView.addSubview(self.infoAboutIventLabel)
        self.mainView.addSubview(self.subscribeButton)
        self.mainView.addSubview(self.unsubscribeButton)

        self.setUpConstraintsFunction()

    }

    //MARK: - ButtonTapped

    @objc private func shareButtonTapped() { // изменить на правильный адрес
        let text = "Invite You"
        guard let url = URL(string: "google.com") else { return }
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
        self.addressButton.snp.makeConstraints { (make) in
            make.top.equalTo(infoAboutOrganizerLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.dataLable.snp.makeConstraints { (make) in
            make.top.equalTo(addressButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        self.infoAboutIventLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dataLable.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.subscribeButton.snp.makeConstraints { (make) in
            make.top.equalTo(infoAboutIventLabel.snp.bottom).offset(30)
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
