//
//  Period.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import Foundation
import SwiftData

@Model
class Period: Identifiable {
    var id = UUID()
    let number: Int
    var homeTeamShots: Int = 0
    var homeTeamGoals: Int = 0
    var awayTeamShots: Int = 0
    var awayTeamGoals: Int = 0
    
    init(id: UUID = UUID(), number: Int, homeTeamShots: Int, homeTeamGoals: Int, awayTeamShots: Int, awayTeamGoals: Int) {
        self.id = id
        self.number = number
        self.homeTeamShots = homeTeamShots
        self.homeTeamGoals = homeTeamGoals
        self.awayTeamShots = awayTeamShots
        self.awayTeamGoals = awayTeamGoals
    }
    
    init(number: Int){
        self.number = number
    }
    
    func addShoot(forHomeTeam: Bool, add: Int){
        if forHomeTeam {
            homeTeamShots += add

        } else{
  
            awayTeamShots += add
        }
    }
    
    func addGoal(forHomeTeam: Bool, add: Int){
        if forHomeTeam {
   
            homeTeamGoals += add
           
        } else{
   
            awayTeamGoals += add
        }
    }
}
