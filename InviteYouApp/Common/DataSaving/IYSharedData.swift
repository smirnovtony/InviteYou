//
//  IYSharedData.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 31.03.21.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class IYSharedData {

    static let sh = IYSharedData()
    private let databaseReference: DatabaseReference
    var collectionInvites: [IYIvent] = []
    var idUser = Auth.auth().currentUser?.uid
    var cellIndex: Int = 12345678
    private init() {
        databaseReference = Database.database().reference()
    }
    private struct Keys {
        static let userStatus = "userLoggedBool"
    }
    lazy var userLogged: Bool = self.loadTestValue()
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
                                     infoAboutOrganizer: document["infoAboutOrganizer"] as? String ?? "",
                                     nameOfEvent: document["nameOfEvent"] as? String ?? "",
                                     typeOfIvent: document["typeOfIvent"] as? String ?? "",
                                     person: document["person"] as? String ?? "",
                                     address: document["address"] as? String ?? "",
                                     date: document["date"] as? String ?? "",
                                     time: document["time"] as? String ?? "",
                                     infoAboutEvent: document["infoAboutEvent"] as? String ?? "",
                                     closedOrOpen: document["closedOrOpen"] as? Int ?? 0,
                                     subscribe: document["subscribe"] as? Bool ?? true,
                                     unsubscribe: document["unsubscribe"] as? Bool ?? true)
                    self.collectionInvites.append(result)
                }
            }
        }
    }
}
