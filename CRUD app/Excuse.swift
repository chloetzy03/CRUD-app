//
//  Excuse.swift
//  CRUD app
//
//  Created by Chloe Tay on 19/10/26.
//
import Foundation

//CaseIterable lets us ask for ALL cases as a list later (Reason.allCases), which we'll need to fill the picker on the form screen
enum Reason: String, CaseIterable {
    case tired = "Tired"
    case busy = "Busy"
    case lazy = "Lazy"
    case weather = "Weather"
    case other = "Other"
}


class Excuse {
    var activity: String //what activity did u skip
    var reason: Reason //why, picked from enum
    var validity: Int //how legit is that excuse
    var date: Date //when it happened
    
    //initialiser 
    init(activity: String, reason: Reason, validity: Int, date: Date = Date()) {
        self.activity = activity
        self.reason = reason
        self.validity = validity
        self.date = date
    }
    
}
