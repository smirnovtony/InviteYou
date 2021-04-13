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
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        customLabel(label)
        return label
    }()
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.inputView = datePicker
        textField.inputAccessoryView = doneToolBar
        textField.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return textField
    }()
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.minimumDate = Date()
        return picker
    }()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        customLabel(label)
        return label
    }()
    private lazy var timeTextField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.inputView = timePicker
        textField.inputAccessoryView = doneToolBar
        textField.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)
        return textField
    }()
    private lazy  var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    private lazy var openOrClosedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Open", "Closed"])
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = mainСolorGreen?.withAlphaComponent(0.5)
        control.layer.borderColor = UIColor.black.cgColor
        control.setTitleTextAttributes([.foregroundColor: UIColor.white,
                                        .font: fontFamilyLittle ?? UIFont.systemFont(ofSize: 30)],
                                       for: .normal)
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
        self.navigationController?.navigationBar.tintColor = .white
        self.mainView.addSubviews([
            self.logoView,
            createInviteStack,
            self.dateLabel,
            self.dateTextField,
            self.timeLabel,
            self.timeTextField,
            self.openOrClosedControl,
            self.createButton
        ])
        self.setUpConstraintsFunction()
        self.customizationStack()
    }
    func customizationStack() {
        numberOfPersonsTextField.inputView = numberOfPersonsPicker
        numberOfPersonsTextField.inputAccessoryView = doneToolBar
        numberOfPersonsPicker.delegate = self
        numberOfPersonsPicker.dataSource = self
        doneToolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))]
        typeOfEventTextField.inputView = typeOfEventPicker
        typeOfEventTextField.inputAccessoryView = doneToolBar
        typeOfEventPicker.delegate = self
        typeOfEventPicker.dataSource = self
    }
    //MARK: - ButtonTapped
    @objc private func createButtonTapped() {
        self.navigationController?.pushViewController(IYDetailsViewController(), animated: true)
// сохрание данных и передача их на предыдущий контроллер и в ячейку !!!!!!!!!!!!!!!!
    }
    @objc func datePickerValueChanged() {
        dateTextField.text = datePicker.date.toString
    }
    @objc func timePickerValueChanged() {
        timeTextField.text = timePicker.date.timeToString
    }
    @objc private func doneTapped() {
        dateTextField.resignFirstResponder()
        timeTextField.resignFirstResponder()
        numberOfPersonsTextField.resignFirstResponder()
        typeOfEventTextField.resignFirstResponder()
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
        createInviteStack.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(createInviteStack.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(30)
        }
        self.dateTextField.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(30)
            make.width.equalTo(170)
        }
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(createInviteStack.snp.bottom).offset(30)
            make.right.equalToSuperview().inset(90)
        }
        self.timeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(30)
            make.width.equalTo(100)
        }
        self.openOrClosedControl.snp.makeConstraints { (make) in
            make.top.equalTo(dateTextField.snp.bottom).offset(60)
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
