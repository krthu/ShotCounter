//
//  GameHeader.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import SwiftUI

struct GameHeader: View{
    @ObservedObject var game: Game
    
    var body: some View{
        HStack{
            GameTeamInfo(teamName: game.homeTeam.name, shots: game.homeShots)
            
            Spacer()
            Text("\(game.homeGoals) - \(game.awayGoals)")
            Spacer()
            
            GameTeamInfo(teamName: game.awayTeam.name, shots: game.awayShots)
            
        }
        .padding(.horizontal, 20)
    }
}

struct GameTeamInfo: View{
    var teamName: String
    var shots: Int
    var body: some View{
        VStack{
            Text(teamName)
            Text("\(shots)")
        }
    }
}

#Preview {
    GameHeader(game: Game(homeTeam: Team(name: "Vaksala"), awayTeam: Team(name: "Sundsvall"), periods: [Period( number: 1, homeTeamShots: 0, homeTeamGoals: 0, awayTeamShots: 0, awayTeamGoals: 0 )]))
}
