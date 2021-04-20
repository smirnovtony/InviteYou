//
//  IYCreateInviteViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 18.03.21.
//

import UIKit
import SnapKit
import Firebase

class IYCreateInviteViewController: IYViewController, UITextViewDelegate {

    //MARK: - Variables
    private lazy var logoView: UIImageView = {
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
    private lazy var logoPicker: UIImagePickerController = {
        let getImage = UIImagePickerController()
        getImage.allowsEditing = true
        getImage.sourceType = .photoLibrary
        getImage.delegate = self
        return getImage
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
        control.selectedSegmentTintColor = mainСolorBlue?.withAlphaComponent(0.5)
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
        button.backgroundColor = mainСolorBlue
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
        guard let address = addressTextField.text else { return }
        guard let closedOrOpen = Int?(openOrClosedControl.selectedSegmentIndex) else { return }
        guard let date = dateTextField.text else { return }
        guard let id = Auth.auth().currentUser?.uid else { return }
        guard let infoAboutEvent = infoAboutEventTextView.text else { return }
        guard let infoAboutOrganizer = infoAboutOrganizerTextField.text else { return }
        guard let logo = logoView.image else { return }
        guard let nameOfEvent = nameOfEventTextField.text else { return }
        guard let organizerName = infoAboutOrganizerTextField.text else { return }
        guard let person = numberOfPersonsTextField.text else { return }
        guard let time = timeTextField.text else { return }
        guard let typeOfIvent = typeOfEventTextField.text else { return }
        let addDocumentData: [String: Any] = ["address": address,
                                              "closedOrOpen": closedOrOpen,
                                              "date": date,
                                              "id": id,
                                              "infoAboutEvent": infoAboutEvent,
                                              "infoAboutOrganizer": infoAboutOrganizer,
                                              "nameOfEvent": nameOfEvent,
                                              "organizerName": organizerName,
                                              "person": person,
                                              "time": time,
                                              "typeOfIvent": typeOfIvent]
            self.uploadInviteImage(logo) { url in
                if url != nil {
                    Firestore.firestore().collection("invites").document(nameOfEvent).setData(addDocumentData) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }

                    Firestore.firestore().collection("invites").document(nameOfEvent).updateData(["logo": url?.absoluteString ?? "", "subscribe": "true"])
                } else {
                    return Swift.print(Error.self)
    //                self.resetForm()
                }
            }
            self.navigationController?.popViewController(animated: true)
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

    private func uploadInviteImage(_ image: UIImage, completion: @escaping ((_ url: URL?) -> Void)) {
        guard let logoName = nameOfEventTextField.text else { return }
        let dataRef = Storage.storage().reference().child("/invitesPics/\(logoName)")
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        dataRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                dataRef.downloadURL { url, error in
                    completion(url)
                }
            } else {
                // failed
                completion(nil)
            }
        }
    }
//    private func saveInvitelogotoProfile(inviteLogo: URL, completion: @escaping ((_ success: Bool) -> Void)) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
//        let userObject = [
//            "username": username,
//            "photoURL": profileImageURL.absoluteString,
//            "phoneNumber": phoneNumber,
//            "userDateOfBirth": userDateOfBirth
//        ] as [String: Any]
//
//        databaseRef.setValue(userObject) { error, ref in
//            completion(error == nil)
//        }
//    }

//    func getInvitesDetail(collection: String, docName: String, completion: @escaping (IYIvent?) -> Void) {
//        let db = IYDefault.sh.configureFB()
//        db.collection(collection).document(docName).getDocument(completion: { (document, error) in
//            guard error == nil else { completion(nil); return }
//        })
//        }
    @objc private func openImagePicker(_ sender: Any) {
        self.present(logoPicker, animated: true, completion: nil)
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
extension IYCreateInviteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.logoView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
