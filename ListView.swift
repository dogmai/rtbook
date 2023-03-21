//
//  ListView.swift
//  RailroadTimeBook
//
//  Created by Matthew Hayward on 12/28/22.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showPopup = false
    
    var body: some View {
        NavigationView {
            List(dataManager.trainJobs, id: \.id) { train in
                VStack(alignment: .leading) {
                    Text("Origin: \(train.origin)")
                    Text("Destination: \(train.destination)")
                    Text("Engine Numbers: \(train.trainEngineNumbers)")
                    Text("Total Pay: \(train.totalPay)")
                }
            }
            .navigationTitle("Daily Train")
            .navigationBarItems(trailing: Button(action: {
                showPopup.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showPopup) {
                NewTrainView()
                    .environmentObject(dataManager)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(DataManager())
    }
}
