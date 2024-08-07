//
//  Game.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import Foundation
import SwiftData

@Model
class Game: ObservableObject, Identifiable{
    var id = UUID()
    var homeClub: Club
    var homeTeam: Team
    
    var awayClub: Club
    var awayTeam: Team
    @Relationship(deleteRule: .cascade) var periods: [Period]
    var date: Date
    var homeShots: Int {
        var totalshots = 0
        for period in periods {
            totalshots += period.homeTeamShots
        }
        return totalshots
    }
    
    var awayShots: Int {
        var totalshots = 0
        for period in periods {
            totalshots += period.awayTeamShots
        }
        return totalshots
    }
    
    var homeGoals: Int {
        var totalGoals = 0
        for period in periods {
            totalGoals += period.homeTeamGoals
        }
        return totalGoals
    }
    
    var awayGoals: Int {
        var totalGoals = 0
        for period in periods {
            totalGoals += period.awayTeamGoals
        }
        return totalGoals
    }
    
    init(homeClub: Club, homeTeam: Team, awayClub: Club, awayTeam: Team, date: Date) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.periods = [Period(number: 1)]
        self.date = date
        self.awayClub = awayClub
        self.homeClub = homeClub
      
    }
    
//    init(homeTeam: Team, awayTeam: Team, periods: [Period]) {
//        self.homeTeam = homeTeam
//        self.awayTeam = awayTeam
//        self.periods = periods
//      
//    }
}
