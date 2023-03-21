//
//  DataManager.swift
//  RailroadTimeBook
//
//  Created by Matthew Hayward on 12/28/22.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
    @Published var trainJobs: [TrainJobs] = []

    private var userId: String? {
        return Auth.auth().currentUser?.uid
    }
    
    init() {
        fetchTrains()
    }
    
    func fetchTrains() {
        guard let userId = userId else { return }
        
        trainJobs.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("users").document(userId).collection("Train")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let origin = data["origin"] as? String ?? ""
                    let originDateTime = data["originDateTime"] as? String ?? ""
                    let destination = data["destination"] as? String ?? ""
                    let destinationDateTime = data["destinationDateTime"] as? String ?? ""
                    let trainEngineNumbers = data["trainEngineNumbers"] as? String ?? ""
                    let heldAway = data["heldAway"] as? String ?? ""
                    let totalPay = data["totalPay"] as? String ?? ""
                    
                    let train = TrainJobs(
                        id: id,
                        origin: origin,
                        originDateTime: originDateTime,
                        destination: destination,
                        destinationDateTime: destinationDateTime,
                        trainEngineNumbers: trainEngineNumbers,
                        heldAway: heldAway,
                        totalPay: totalPay
                    )
                    self.trainJobs.append(train)
                }
            }
        }
    }
    
    func addTrain(
            origin: String,
            originDateTime: String,
            destination: String,
            destinationDateTime: String,
            trainEngineNumbers: String,
            heldAway: String,
            totalPay: String,
            completion: @escaping(Bool) -> Void
        ) {
            guard let userId = userId else { return }
            
            // Get a reference to the "Trains" collection in Firestore
            let db = Firestore.firestore()
            let ref = db.collection("users").document(userId).collection("Train")
            
            // Generate a unique ID for the train job
            let trainJobId = UUID().uuidString
            
            // Set data for the document using the 'setData' method
            ref.document(trainJobId).setData([
                "id": trainJobId,
                "origin": origin,
                "originDateTime": originDateTime,
                "destination": destination,
                "destinationDateTime": destinationDateTime,
                "trainEngineNumbers": trainEngineNumbers,
                "heldAway": heldAway,
                "totalPay": totalPay
            ]) { error in
                if let error = error {
                    // An error occured while creating the document
                    print("Error creating document: \(error.localizedDescription)")
                    completion(false)
                } else {
                    // The document was created successfully
                    print("Document ID: \(trainJobId)")
                    completion(true)
                }
            }
        }

}



//    func addDog(dogBreed: String) {
//        // Get a reference to the "Dogs" collection in Firestore
//        let db = Firestore.firestore()
//        let ref = db.collection("Train")
//
//        // Get the current timestamp and the user's ID
//        let timestamp = Timestamp()
//        let userId = Auth.auth().currentUser?.uid ?? "anonymous"
//
//        // Generate a unique ID for the document using the timestamp and user's ID
//        let documentId = "\(timestamp.seconds)-\(userId)"
//
//        // Set the data for the document using the `setData` method
//        ref.document(documentId).setData(["breed": dogBreed]) { error in
//            if let error = error {
//                // An error occurred while creating the document
//                print(error.localizedDescription)
//            } else {
//                // The document was created successfully
//                print("Document ID: \(documentId)")
//            }
//        }
//    }

    
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
