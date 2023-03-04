//
//  DataManager.swift
//  RailroadTimeBook
//
//  Created by Matthew Hayward on 12/28/22.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
    @Published var dogs: [Dog] = []
    
    init() {
        fetchDogs()
    }
    
    func fetchDogs() {
        dogs.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Dogs")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let breed = data["breed"] as? String ?? ""
                    
                    let dog = Dog(id: id, breed: breed)
                    self.dogs.append(dog)
                }
            }
        }
    }
    
    func addDog(dogBreed: String) {
        // Get a reference to the "Dogs" collection in Firestore
        let db = Firestore.firestore()
        let ref = db.collection("Dogs")

        // Get the current timestamp and the user's ID
        let timestamp = Timestamp()
        let userId = Auth.auth().currentUser?.uid ?? "anonymous"

        // Generate a unique ID for the document using the timestamp and user's ID
        let documentId = "\(timestamp.seconds)-\(userId)"

        // Set the data for the document using the `setData` method
        ref.document(documentId).setData(["breed": dogBreed]) { error in
            if let error = error {
                // An error occurred while creating the document
                print(error.localizedDescription)
            } else {
                // The document was created successfully
                print("Document ID: \(documentId)")
            }
        }
    }

    
//    func addDog(dogBreed: String) {
//        let db = Firestore.firestore()
//        let ref = db.collection("Dogs")
//
//        ref.addDocument(data: ["breed": dogBreed]) { error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                // The document was created successfully
//                let documentId = ref.document().documentID
//                print("Document ID: \(documentId)")
//            }
//        }
//    }

    
//    func addDog(dogBreed: String) {
//        let db = Firestore.firestore()
//        let ref = db.collection("Dogs").document(dogBreed)
//        ref.setData(["breed": dogBreed, "id" : 10]) { error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//        }
//    }
}
