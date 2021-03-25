//
//  IYCreateInviteViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 18.03.21.
//

import UIKit
import SnapKit


class IYCreateInviteViewController: IYViewController, UITextViewDelegate {

    //MARK: - var

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "photography") // дeфолтная картинка, сюда логотип организации

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var nameOrganizerTextView: UITextView = {
        let textView = UITextView()

        textView.textColor = .lightGray
        textView.font = fontFamilyMiddle
        textView.text = "Name Organizer"
        textView.textAlignment = .center
        textView.backgroundColor = backgroundСolorWhite
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.delegate = self

        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()

    private lazy var infoAboutOrganizerTextView: UITextView = {
        let textView = UITextView()

        textView.textColor = .lightGray
        textView.font = fontFamilyLittle
        textView.text = "Info About The Organizer"
        textView.textAlignment = .center
        textView.backgroundColor = backgroundСolorWhite
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.delegate = self

        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()

    private lazy var addressTextView: UITextView = { // связать с картой!!!!!!!!!!!!!!!!!!!!!!!!!!
        let textView = UITextView()

        textView.textColor = .lightGray
        textView.font = fontFamilyLittle
        textView.text = "Address"
        textView.textAlignment = .center
        textView.backgroundColor = backgroundСolorWhite
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.delegate = self

        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()

    private lazy var dataImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.backgroundColor = mainСolorGreen?.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = 15

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var dataTextField: UITextField = {
        let textField = UITextField()

        textField.textColor = .white
        textField.font = fontFamilyLittle
        textField.placeholder = "Date"
        textField.textAlignment = .center
        textField.inputView = self.datePicker
        textField.inputAccessoryView = self.doneToolBar

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()

        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.minimumDate = Date()

        picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)

        return picker
    }()

    private lazy var timeImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.backgroundColor = mainСolorGreen?.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = 15

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var timeTextField: UITextField = {
        let textField = UITextField()

        textField.textColor = .white
        textField.font = fontFamilyLittle
        textField.placeholder = "Time"
        textField.textAlignment = .center
        textField.inputView = self.timePicker
        textField.inputAccessoryView = self.doneToolBar

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()

        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.minimumDate = Date()

        picker.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)

        return picker
    }()

    lazy var numberOfPersonsTextField: UITextField = { // пикер колличество
        let textField = UITextField()

        textField.textColor = mainСolorGreen
        textField.font = fontFamilyLittle
        textField.placeholder = "Persons"
        textField.textAlignment = .center
        textField.inputView = self.numberOfPersonsPicker

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    lazy var numberOfPersonsPicker: UIPickerView = {
         let picker = UIPickerView()

         picker.delegate = self
         picker.dataSource = self

         picker.translatesAutoresizingMaskIntoConstraints = false

         return picker
     }()

    private lazy var doneToolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        ]
        return toolbar
    }()




    lazy var typeOfEventTextField: UITextField = {
        let textField = UITextField()

        textField.textColor = mainСolorGreen
        textField.font = fontFamilyLittle
        textField.placeholder = "Type Of Event"
        textField.textAlignment = .center
        textField.inputView = self.typeOfEventPicker

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    lazy var typeOfEventPicker: UIPickerView = {
        let picker = UIPickerView()

        picker.delegate = self
        picker.dataSource = self

        picker.translatesAutoresizingMaskIntoConstraints = false

        return picker
    }()

    private lazy var nameOfEventTextView: UITextView = {
        let textView = UITextView()

        textView.textColor = .lightGray
        textView.font = fontFamilyLittle
        textView.text = "Name Of Event"
        textView.textAlignment = .center
        textView.backgroundColor = backgroundСolorWhite
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.delegate = self

        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()

    private lazy var infoAboutEventTextView: UITextView = { // сделать, чтобы удалялась надпись
        let textView = UITextView()

        textView.textColor = .lightGray
        textView.font = fontFamilyLittle
        textView.text = "Info about Event"
        textView.backgroundColor = backgroundСolorWhite
        textView.textAlignment = .justified
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.delegate = self

        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()

    private lazy var openOrClosedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Open", "Closed"])

        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = mainСolorGreen?.withAlphaComponent(0.5)
        control.layer.borderColor = UIColor.black.cgColor
        control.setTitleTextAttributes([.foregroundColor: UIColor.gray,
                                        .font: fontFamilyLittle ?? UIFont.systemFont(ofSize: 30)], for: .normal)

        control.translatesAutoresizingMaskIntoConstraints = false

        return control
    }()


    private lazy var createButton: UIButton = {
        let button = UIButton()

        button.setTitle("Create Invitation", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = mainСolorGreen
        button.titleLabel?.font = fontFamilyMiddle
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 20
        button.clipsToBounds = false

        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()


    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()

        self.title = "Create Invitation"
        self.navigationController?.navigationBar.tintColor = .white // цвет стрелки "назад"

        self.mainView.addSubview(self.logoView)
        self.mainView.addSubview(self.nameOrganizerTextView)
        self.mainView.addSubview(self.infoAboutOrganizerTextView)
        self.mainView.addSubview(self.nameOfEventTextView)
        self.mainView.addSubview(self.typeOfEventTextField)
        self.mainView.addSubview(self.numberOfPersonsTextField)
        self.mainView.addSubview(self.addressTextView)
        self.mainView.addSubview(self.dataImageView)
        self.mainView.addSubview(self.dataTextField)
        self.mainView.addSubview(self.timeImageView)
        self.mainView.addSubview(self.timeTextField)
        self.mainView.addSubview(self.infoAboutEventTextView)
        self.mainView.addSubview(self.openOrClosedControl)

        self.mainView.addSubview(self.createButton)

        self.setUpConstraintsFunction()
    }

    // MARK: - TextView

    func textViewDidBeginEditing (_ textView: UITextView) {
        switch textView {
        case self.nameOrganizerTextView:
            textView.text = nil
            textView.textColor = mainСolorGreen
        case self.infoAboutOrganizerTextView:
            textView.text = nil
            textView.textColor = .black
        case self.nameOfEventTextView:
            textView.text = nil
            textView.textColor = mainСolorGreen
        case self.addressTextView:
            textView.text = nil
            textView.textColor = .black
        case self.infoAboutEventTextView:
            textView.text = nil
            textView.textColor = .black
        default:
            break
        }
    }

    func textViewDidEndEditing (_ textView: UITextView) {
        if textView.text.isEmpty {
        switch textView {
        case self.nameOrganizerTextView:
            self.nameOrganizerTextView.text = "Name Organizer"
            textView.textColor = .lightGray
        case self.infoAboutOrganizerTextView:
            self.infoAboutOrganizerTextView.text = "Info About Organizer"
            textView.textColor = .lightGray
        case self.nameOfEventTextView:
            self.nameOfEventTextView.text = "Name Of Event"
            textView.textColor = .lightGray
        case self.addressTextView:
            self.addressTextView.text = "Address"
            textView.textColor = .lightGray
        case self.infoAboutEventTextView:
            self.infoAboutEventTextView.text = "Info About Event"
            textView.textColor = .lightGray
        default:
            break
        }
        }

    }

    //MARK: - ButtonTapped

    @objc private func createButtonTapped() {
// сохрание данных и передача их на предыдущий контроллер и в ячейку !!!!!!!!!!!!!!!!
    }

    @objc func datePickerValueChanged() {
        self.dataTextField.text = datePicker.date.toString
    }

    @objc func timePickerValueChanged() {
        self.timeTextField.text = datePicker.date.timeToString
    }

    @objc private func doneTapped() {
        self.dataTextField.resignFirstResponder()
        self.timeTextField.resignFirstResponder()
    }

    @objc private func backToButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - Constraints

    func setUpConstraintsFunction() {
        self.logoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(140)
        }
        self.nameOrganizerTextView.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
            make.height.width.equalTo(50)
        }
        self.infoAboutOrganizerTextView.snp.makeConstraints { (make) in
            make.top.equalTo(nameOrganizerTextView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
        }
        self.nameOfEventTextView.snp.makeConstraints { (make) in
            make.top.equalTo(infoAboutOrganizerTextView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.typeOfEventTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameOfEventTextView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
        }
        self.numberOfPersonsTextField.snp.makeConstraints { (make) in
            make.top.equalTo(typeOfEventTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.addressTextView.snp.makeConstraints { (make) in
            make.top.equalTo(numberOfPersonsTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.dataImageView.snp.makeConstraints { (make) in
            make.top.equalTo(addressTextView.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(-90)
            make.left.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        self.dataTextField.snp.makeConstraints { (make) in
            make.center.equalTo(dataImageView.snp.center)
        }
        self.timeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(addressTextView.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(90)
            make.right.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        self.timeTextField.snp.makeConstraints { (make) in
            make.center.equalTo(timeImageView.snp.center)
        }
        self.infoAboutEventTextView.snp.makeConstraints { (make) in
            make.top.equalTo(dataImageView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.openOrClosedControl.snp.makeConstraints { (make) in
            make.top.equalTo(infoAboutEventTextView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        self.createButton.snp.makeConstraints { (make) in
            make.top.equalTo(openOrClosedControl.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(20)
        }
    }

}



