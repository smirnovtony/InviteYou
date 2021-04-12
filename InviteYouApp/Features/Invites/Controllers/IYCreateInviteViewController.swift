//
//  IYCreateInviteViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 18.03.21.
//

import UIKit
import SnapKit

class IYCreateInviteViewController: IYViewController, UITextViewDelegate {

    //MARK: - Variables

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "photography") // дeфолтная картинка, сюда логотип организации
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameOrganizerLable: UILabel = {
        let label = UILabel()
        label.text = "Name Organizer"
        customLable(label)
        return label
    }()

    private lazy var nameOrganizerTextField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        return textField
    }()
    private lazy var infoAboutOrganizerLable: UILabel = {
        let label = UILabel()
        label.text = "Info About The Organizer"
        customLable(label)
        return label
    }()
    private lazy var infoAboutOrganizerTextField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        return textField
    }()
    private lazy var addressLable: UILabel = { // связать с картой!!!!!!!!!!!!!!!!!!!!!!!!!!
        let label = UILabel()
        label.text = "Address"
        customLable(label)
        return label
    }()
    private lazy var addressTextField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        return textField
    }()

    private lazy var numberOfPersonsLable: UILabel = {
        let label = UILabel()
        label.text = "Persons"
        customLable(label)
        return label
    }()
    private lazy var numberOfPersonsTextField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.inputView = self.numberOfPersonsPicker
        textField.inputAccessoryView = self.doneToolBar
        return textField
    }()

    private lazy var numberOfPersonsPicker: UIPickerView = {
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
    private lazy var typeOfEventLable: UILabel = {
        let label = UILabel()
        label.text = "Type Of Event"
        customLable(label)
        return label
    }()
    private lazy var typeOfEventTextField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.inputView = self.typeOfEventPicker
        textField.inputAccessoryView = self.doneToolBar
        return textField
    }()

    private lazy var typeOfEventPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    private lazy var nameOfEventLable: UILabel = {
        let label = UILabel()
        label.text = "Name Of Event"
        customLable(label)
        return label
    }()
    private lazy var nameOfEventTextField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        return textField
    }()
    private lazy var dataLable: UILabel = {
        let label = UILabel()
        label.text = "Data"
        customLable(label)
        return label
    }()
    private lazy var dataTextField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.inputView = self.datePicker
        textField.inputAccessoryView = self.doneToolBar
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
    private lazy var timeLable: UILabel = {
        let label = UILabel()
        label.text = "Time"
        customLable(label)
        return label
    }()
    private lazy var timeTextField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.inputView = self.timePicker
        textField.inputAccessoryView = self.doneToolBar
        return textField
    }()

    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)
        return picker
    }()

    private lazy var infoAboutEventLable: UILabel = {
        let label = UILabel()
        label.text = "Info about Event"
        customLable(label)
        return label
    }()
    private lazy var infoAboutEventTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.font = fontFamilyLittle
        textView.textColor = mainСolorGreen
        return textView
    }()

    private lazy var openOrClosedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Open", "Closed"])
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = mainСolorGreen?.withAlphaComponent(0.5)
        control.layer.borderColor = UIColor.black.cgColor
        control.setTitleTextAttributes([.foregroundColor: UIColor.white,
                                        .font: fontFamilyLittle ?? UIFont.systemFont(ofSize: 30)], for: .normal)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Invitation", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = mainСolorGreen
        customButton(button)
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()

        self.title = "Create Invitation"
        self.navigationController?.navigationBar.tintColor = .white // цвет стрелки "назад"

        self.mainView.addSubview(self.logoView)

        self.mainView.addSubview(self.nameOrganizerLable)
        self.mainView.addSubview(self.nameOrganizerTextField)

        self.mainView.addSubview(self.infoAboutOrganizerLable)
        self.mainView.addSubview(self.infoAboutOrganizerTextField)

        self.mainView.addSubview(self.nameOfEventLable)
        self.mainView.addSubview(self.nameOfEventTextField)

        self.mainView.addSubview(self.typeOfEventLable)
        self.mainView.addSubview(self.typeOfEventTextField)

        self.mainView.addSubview(self.numberOfPersonsLable)
        self.mainView.addSubview(self.numberOfPersonsTextField)

        self.mainView.addSubview(self.addressLable)
        self.mainView.addSubview(self.addressTextField)

        self.mainView.addSubview(self.dataLable)
        self.mainView.addSubview(self.dataTextField)

        self.mainView.addSubview(self.timeLable)
        self.mainView.addSubview(self.timeTextField)

        self.mainView.addSubview(self.infoAboutEventLable)
        self.mainView.addSubview(self.infoAboutEventTextView)

        self.mainView.addSubview(self.openOrClosedControl)

        self.mainView.addSubview(self.createButton)

        self.setUpConstraintsFunction()
    }

    //MARK: - ButtonTapped

    @objc private func createButtonTapped() {
//        sendLikeActionNotification(name: self.nameOrganizerLable.text ?? "")
        self.navigationController?.pushViewController(IYDetailsViewController(), animated: true)
// сохрание данных и передача их на предыдущий контроллер и в ячейку !!!!!!!!!!!!!!!!
    }

    @objc func datePickerValueChanged() {
        self.dataTextField.text = datePicker.date.toString
    }

    @objc func timePickerValueChanged() {
        self.timeTextField.text = timePicker.date.timeToString
    }

    @objc private func doneTapped() {
        self.dataTextField.resignFirstResponder()
        self.timeTextField.resignFirstResponder()
        self.numberOfPersonsTextField.resignFirstResponder()
        self.typeOfEventTextField.resignFirstResponder()
    }

    @objc private func backToButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

//    private func sendLikeActionNotification(name: String) { // (2.1 из 3 действий (содание) для передачи данных через Notification)
//        let text: String = nameOrganizerLable.text ?? ""
//        NotificationCenter.default.post(Notification(name: .createInvite,
//                                                     object: text,
//                                                     userInfo: nil))
//    }

    //MARK: - Constraints

    func setUpConstraintsFunction() {
        self.logoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(140)
        }
        self.nameOrganizerLable.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.nameOrganizerTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameOrganizerLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.infoAboutOrganizerLable.snp.makeConstraints { (make) in
            make.top.equalTo(nameOrganizerTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
        self.infoAboutOrganizerTextField.snp.makeConstraints { (make) in
            make.top.equalTo(infoAboutOrganizerLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.nameOfEventLable.snp.makeConstraints { (make) in
            make.top.equalTo(infoAboutOrganizerTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
        self.nameOfEventTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameOfEventLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.typeOfEventLable.snp.makeConstraints { (make) in
            make.top.equalTo(nameOfEventTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
        self.typeOfEventTextField.snp.makeConstraints { (make) in
            make.top.equalTo(typeOfEventLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.numberOfPersonsLable.snp.makeConstraints { (make) in
            make.top.equalTo(typeOfEventTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
        self.numberOfPersonsTextField.snp.makeConstraints { (make) in
            make.top.equalTo(numberOfPersonsLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.addressLable.snp.makeConstraints { (make) in
            make.top.equalTo(numberOfPersonsTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
        self.addressTextField.snp.makeConstraints { (make) in
            make.top.equalTo(addressLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.dataLable.snp.makeConstraints { (make) in
            make.top.equalTo(addressTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(30)
        }
        self.dataTextField.snp.makeConstraints { (make) in
            make.top.equalTo(dataLable.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(30)
            make.width.equalTo(170)
        }
        self.timeLable.snp.makeConstraints { (make) in
            make.top.equalTo(addressTextField.snp.bottom).offset(30)
            make.right.equalToSuperview().inset(90)
        }
        self.timeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(timeLable.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(30)
            make.width.equalTo(100)
        }
        self.infoAboutEventLable.snp.makeConstraints { (make) in
            make.top.equalTo(timeTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
        self.infoAboutEventTextView.snp.makeConstraints { (make) in
            make.top.equalTo(infoAboutEventLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.openOrClosedControl.snp.makeConstraints { (make) in
            make.top.equalTo(infoAboutEventTextView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        self.createButton.snp.makeConstraints { (make) in
            make.top.equalTo(openOrClosedControl.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(20)
        }
    }

}

    //MARK: - Extensions

extension IYCreateInviteViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var picker: Int = 0
        switch pickerView {
        case typeOfEventPicker:
            picker = IYTypeOfEvent.allCases.count
        case numberOfPersonsPicker:
            picker = IYNumberOfPersons.allCases.count
        default:
            break
        }
        return picker
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var picker: String? = nil
        switch pickerView {
        case typeOfEventPicker:
            picker = IYTypeOfEvent.allCases[row].rawValue
        case numberOfPersonsPicker:
            picker = IYNumberOfPersons.allCases[row].rawValue
        default:
            break
        }
        return picker
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case typeOfEventPicker:
            self.typeOfEventTextField.text = IYTypeOfEvent.allCases[row].rawValue
        case numberOfPersonsPicker:
            self.numberOfPersonsTextField.text = IYNumberOfPersons.allCases[row].rawValue
        default:
            break
        }
    }
}

extension Date {
    var toString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: self)
    }
}

extension Date {
    var timeToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
