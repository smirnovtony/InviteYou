//
//  IYEditProfileViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 12.03.21.
//

import UIKit
import Firebase
import FirebaseStorage

class IYEditProfileViewController: IYViewController, UITextViewDelegate {

    //MARK: - Variables

    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imageView.layer.cornerRadius = 70
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "photography")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var imagePicker: UIImagePickerController = {
        let getImage = UIImagePickerController()
        getImage.allowsEditing = true
        getImage.sourceType = .photoLibrary
        getImage.delegate = self
        return getImage
    }()
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User name"
        customLabel(label)
        return label
    }()
    private lazy var userNameField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        return textField
    }()
    private lazy var userDateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = "User date of birth"
        customLabel(label)
        return label
    }()
    private lazy var userDateOfBirthField: UITextField = {
        let textField = UITextField()
        textField.inputView = dateOfBirthPicker
        textField.inputAccessoryView = doneToolBar
        customTextField(textField)
        return textField
    }()
    private lazy var dateOfBirthPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.minimumDate = .none
        picker.maximumDate = Date()
        picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
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
    private lazy var userPhoneLabel: UILabel = {
        let label = UILabel()
        label.text = "User phone number"
        customLabel(label)
        return label
    }()
    private lazy var userPhoneField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.keyboardType = .phonePad
        return textField
    }()
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = mainСolorBlue
        customButton(button)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        navigationController?.navigationBar.tintColor = .white
        self.addTapGestureToHideKeyboard()
        self.mainView.addSubviews([
            self.userImageView,
            self.userNameLabel,
            self.userNameField,
            self.userDateOfBirthLabel,
            self.userDateOfBirthField,
            self.userPhoneLabel,
            self.userPhoneField,
            self.saveButton
        ])
        self.setUpConstraintsFunction()
        self.userPhoneField.keyboardType = .phonePad
        self.userPhoneField.textContentType = .telephoneNumber
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.downloadUserInfo()
    }

    //MARK: - ButtonTapped

    private func errorAllert() {
        let alertController = UIAlertController(title: "Error",
                                                message: "Something went wrong...",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive)
        self.present(alertController, animated: true)
        alertController.addAction(okAction)
    }
    @objc func datePickerValueChanged() {
        self.userDateOfBirthField.text = dateOfBirthPicker.date.toString
    }
    @objc private func doneTapped() {
        self.userDateOfBirthField.resignFirstResponder()
    }
    @objc private func saveButtonTapped() {
        guard let image = userImageView.image else { return }
        guard let username = userNameField.text else { return }
        guard let userPhoneNumber = userPhoneField.text else { return }
        guard let userDateOfBirth = userDateOfBirthField.text else { return }
        self.uploadUserImage(image) { url in
            if url != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.photoURL = url
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User display name changed!")
                        self.saveProfile(username: username, profileImageURL: url!, phoneNumber: userPhoneNumber, userDateOfBirth: userDateOfBirth) { success in
                            if success {
                                self.dismiss(animated: true, completion: nil)
                            } else {
                                self.errorAllert()
                            }
                        }
                    } else {
                        self.errorAllert()
                    }
                }
            } else {
                self.errorAllert()
            }
        }
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func openImagePicker(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }

    //MARK: - Firebase

    private func uploadUserImage(_ image: UIImage, completion: @escaping ((_ url: URL?) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let dataRef = Storage.storage().reference().child("user/\(uid)")
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        dataRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                dataRef.downloadURL { url, error in
                    completion(url)
                }
            } else {
                self.errorAllert()
                completion(nil)
            }
        }
    }

    private func saveProfile(username: String, profileImageURL: URL, phoneNumber: String, userDateOfBirth: String, completion: @escaping ((_ success: Bool) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString,
            "phoneNumber": phoneNumber,
            "userDateOfBirth": userDateOfBirth
        ] as [String: Any]

        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }

    private func downloadUserInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        databaseRef.observeSingleEvent(of: .value) { (snapshot) in
            if let userInfo = snapshot.value as? [String: Any] {
                for (key, value) in userInfo {
                    switch key {
                    case "phoneNumber":
                        self.userPhoneField.text = value as? String
                    case "username":
                        self.userNameField.text = value as? String
                    case "userDateOfBirth":
                        self.userDateOfBirthField.text = value as? String
                    case "photoURL":
                        guard let url = URL(string: value as? String ?? "") else { return }
                        UIImage.loadFrom(url: url) { image in
                            self.userImageView.image = image
                        }
                    default:
                        break
                    }
                }
            }
        }
    }

    //MARK: - Constraints

    func setUpConstraintsFunction() {
        self.userImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(140)
        }
        self.userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userImageView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
        self.userNameField.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(30)
        }
        self.userDateOfBirthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userNameField.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(30)
        }
        self.userDateOfBirthField.snp.makeConstraints { (make) in
            make.top.equalTo(userDateOfBirthLabel.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(30)
        }
        self.userPhoneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userDateOfBirthField.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(30)
        }
        self.userPhoneField.snp.makeConstraints { (make) in
            make.top.equalTo(userPhoneLabel.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(30)
        }
        self.saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(userPhoneField.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(30)
        }
    }

}
//MARK: - Extensions

extension IYEditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.userImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
