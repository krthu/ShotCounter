//
//  Team.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import Foundation
import SwiftData


@Model
class Team{
    let name: String
    init(name: String) {
        self.name = name
    }
}
