//
//  Game.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import Foundation
import SwiftData

@Model
class Game: ObservableObject{
    var id = UUID()
    var homeTeam: Team
    var awayTeam: Team
    var periods: [Period] = [] //[Period(number: 1)]
    
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
    
    init(homeTeam: Team, awayTeam: Team) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.periods = [Period(number: 1)]
      
    }
    
    init(homeTeam: Team, awayTeam: Team, periods: [Period]) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.periods = periods
      
    }
    
    func homeShotsFun() -> Int{
        var totalshots = 0
        for period in periods {
            totalshots += period.homeTeamShots
        }
        return totalshots
    }

    
    
    
}
