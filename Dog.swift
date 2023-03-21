//
//  Train.swift
//  RailroadTimeBook
//
//  Created by Matthew Hayward on 12/28/22.
//

import SwiftUI

struct TrainJobs: Identifiable {
    var id: String
    var origin: String
    var originDateTime: String
    var destination: String
    var destinationDateTime: String
    var trainEngineNumbers: String
    var heldAway: String
    var totalPay: String
}
