//
//  NewDogView.swift
//  RailroadTimeBook
//
//  Created by Matthew Hayward on 12/28/22.
//

import SwiftUI

struct NewTrainView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var origin = ""
    @State private var originDateTime = ""
    @State private var destination = ""
    @State private var destinationDateTime = ""
    @State private var trainEngineNumbers = ""
    @State private var heldAway = ""
    @State private var totalPay = ""
    
    var body: some View {
        VStack {
            TextField("Origin", text: $origin)
            TextField("Origin Date and Time", text: $originDateTime)
            TextField("Destination", text: $destination)
            TextField("Destination Date and Time", text: $destinationDateTime)
            TextField("Train Engine Numbers", text: $trainEngineNumbers)
            TextField("Held Away", text: $heldAway)
            TextField("Total Pay", text: $totalPay)
            
            Button(action: {
                dataManager.addTrain(
                    origin: origin,
                    originDateTime: originDateTime,
                    destination: destination,
                    destinationDateTime: destinationDateTime,
                    trainEngineNumbers: trainEngineNumbers,
                    heldAway: heldAway,
                    totalPay: totalPay
                ) { success in
                    if success {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        // Handle the error, e.g., show an alert
                    }
                }
            }) {
                Text("Save")
            }


        }
        .padding()
    }
}

struct NewTrainView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrainView()
    }
}
