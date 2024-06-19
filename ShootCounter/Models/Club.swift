//
//  Club.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-06-17.
//

import Foundation
import SwiftData

@Model
class Club: ObservableObject, Identifiable {
    let id: UUID = UUID()
    var name: String
    var logoData: Data?
    var teams: [Team] = []
    
    init(name: String, logoData: Data? = nil) {
        self.name = name
        self.logoData = logoData
    }
}
