//
//  Period.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import Foundation

struct Period: Identifiable {
    var id = UUID()
    let number: Int
    var homeTeamShots: Int = 0
    var homeTeamGoals: Int = 0
    var awayTeamShots: Int = 0
    var awayTeamGoals: Int = 0
}
