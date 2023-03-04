//
//  NewDogView.swift
//  RailroadTimeBook
//
//  Created by Matthew Hayward on 12/28/22.
//

import SwiftUI

struct NewTrain: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var newDog = ""
    
    var body: some View {
        VStack {
            TextField("Dog", text: $newDog)
            
            Button {
                dataManager.addDog(dogBreed: newDog)
            } label: {
                Text("Save")
            }
        }
        .padding()
    }
}

struct NewDogView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrain()
    }
}
