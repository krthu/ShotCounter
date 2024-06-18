//
//  Team.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import Foundation
import SwiftData


@Model
class Team {
    let id: UUID = UUID()
    let name: String
    var logoData: Data?
    init(name: String) {
        self.name = name
    }
    init(name: String, logoData: Data?){
        self.name = name
        self.logoData = logoData
    }

}
