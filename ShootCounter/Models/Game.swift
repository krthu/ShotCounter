//
//  Game.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import Foundation

class Game: ObservableObject{
    @Published var homeTeam: Team
    @Published var awayTeam: Team
    @Published var periods: [Period] = [] // [Period(number: 1, homeTeamShoots: 0, homeTeamGoals: 0, awayTeamShots: 0, awayTeamGoals: 0)]
    
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
      
    }
    
    init(homeTeam: Team, awayTeam: Team, periods: [Period]) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.periods = periods
      
    }

    
    
    
}
