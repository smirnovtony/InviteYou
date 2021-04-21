//
//  IYSharedData.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 31.03.21.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class IYSharedData {

    //MARK: - Variables

    static let sh = IYSharedData()
    var collectionInvites: [IYIvent] = []
    var idUser = Auth.auth().currentUser?.uid
    lazy var userLogged: Bool = self.loadTestValue()
    private let databaseReference: DatabaseReference

    //MARK: - Initializators

    private init() {
        databaseReference = Database.database().reference()
    }

    //MARK: - Struct

    private struct Keys {
        static let userStatus = "userLoggedBool"
    }

    //MARK: - Functions

    func saveTestValue() {
        UserDefaults.standard.setValue(userLogged, forKey: "userLoggedBool")
    }
    func loadTestValue() -> Bool {
        let value = UserDefaults.standard.value(forKey: "userLoggedBool") as? Bool
        return value ?? true
    }

    //MARK: - Firestore

    func readCollectionInvites() {
        Firestore.firestore().collection("invites").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let snapshot = snapshot else { return }
                for document in snapshot.documents {
                    var result: IYIvent
                    result = IYIvent(id: document["id"] as? String ?? "",
                                     logo: document["logo"] as? String ?? "",
                                     organizerName: document["organizerName"] as? String ?? "",
                                     nameOfEvent: document["nameOfEvent"] as? String ?? "",
                                     typeOfIvent: document["typeOfIvent"] as? String ?? "",
                                     person: document["person"] as? String ?? "",
                                     address: document["address"] as? String ?? "",
                                     date: document["date"] as? String ?? "",
                                     time: document["time"] as? String ?? "",
                                     closedOrOpen: document["closedOrOpen"] as? Int ?? 0,
                                     subscribe: document["subscribe"] as? Bool ?? true)
                    self.collectionInvites.append(result)
                }
            }
        }
    }
}
