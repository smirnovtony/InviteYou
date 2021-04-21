//
//  IYProfileViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit
import Firebase

class IYProfileViewController: IYViewController {

    //MARK: - Enumeration

    enum NavBarStyle {
        case simple
        case notSimple
        func getStyle() -> String {
            return ""
        }
    }
    //MARK: - Variables

    var dbReference: DatabaseReference?
    var dbHandle: DatabaseHandle?
    var ref = Database.database().reference()

    private lazy var userView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.image = UIImage(named: "photography")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = mainСolorBlue
        label.font = fontFamilyMiddle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var userDateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = fontFamilyLittle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var userPhoneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = fontFamilyLittle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = fontFamilyLittle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var createEventButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Invitation", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = mainСolorBlue
        customButton(button)
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = notСolorPink
        customButton(button)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        let barButtonItem = UIBarButtonItem(title: "Edit",
                                            style: .done,
                                            target: self,
                                            action: #selector(editButtonTapped))
        barButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = barButtonItem
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: fontFamilyLittle?.withSize(25) ?? UIFont.systemFont(ofSize: 30)], for: .normal)
        self.mainView.addSubviews([
            self.userView,
            self.userNameLabel,
            self.userDateOfBirthLabel,
            self.userPhoneLabel,
            self.userEmailLabel,
            self.createEventButton,
            self.logOutButton
        ])
        self.setUpConstraintsFunction()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.downloadUserInfo()
    }

    //MARK: - ButtonTapped

    @objc private func editButtonTapped() {
        navigationController?.pushViewController(IYEditProfileViewController(), animated: true)
    }

    @objc private func logOutButtonTapped() {
        let alertController = UIAlertController(title: "Log out",
                                                message: "Sign out of your account?",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        do {
                try Auth.auth().signOut()
            } catch {
                print(error)
            }
            UserDefaults.standard.set(false, forKey: "userLoggedBool")
            self.navigationController?.pushViewController(IYInitViewController(), animated: true)
        }
        alertController.addAction(okAction)
        let canselAction = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(canselAction)
        self.present(alertController, animated: true)
    }

    @objc private func createButtonTapped() {
        navigationController?.pushViewController(IYCreateInviteViewController(), animated: true)
    }

    //MARK: - Firebase Database read

    private func downloadUserInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseReference = Database.database().reference().child("users/\(uid)")
        databaseReference.observeSingleEvent(of: .value) { (snapshot) in
            if let userInfo = snapshot.value as? [String: Any] {
                for (key, value) in userInfo {
                    switch key {
                    case "email":
                        self.userEmailLabel.text = ("Email: \(value)")
                    default:
                        break
                    }
                }
            }
        }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        databaseRef.observeSingleEvent(of: .value) { (snapshot) in
            if let userInfo = snapshot.value as? [String: Any] {
                for (key, value) in userInfo {
                    switch key {
                    case "phoneNumber":
                        self.userPhoneLabel.text = ("Phone: \(value)")
                    case "username":
                        self.userNameLabel.text = ("Name: \(value)")
                    case "userDateOfBirth":
                        self.userDateOfBirthLabel.text = ("Date of birth: \(value)")
                    case "photoURL":
                        guard let url = URL(string: value as? String ?? "") else { return }
                        UIImage.loadFrom(url: url) { image in
                            self.userView.image = image
                        }
                    default:
                        break
                    }
                }
            }
        }
    }

    //MARK: - Constraints

    private func setUpConstraintsFunction() {
        self.userView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(140)
        }
        self.userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
        }
        self.userDateOfBirthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        self.userPhoneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userDateOfBirthLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(40)
        }
        self.userEmailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userPhoneLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
        }
        self.createEventButton.snp.makeConstraints { (make) in
            make.top.equalTo(userEmailLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        self.logOutButton.snp.makeConstraints { (make) in
            make.top.equalTo(createEventButton.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(20)
        }
    }

}
//MARK: - Extensions

extension UIImage {
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
