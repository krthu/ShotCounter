//
//  GameHeader.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import SwiftUI

struct GameHeader: View{
    @Bindable var game: Game
    
    var body: some View{
        HStack{
            GameTeamInfo(teamName: game.homeTeam.name, team: game.homeTeam, shots: game.homeShots)
            
            Spacer()
            VStack{
                Text("GOALS")
                    .font(.system(size: 8))
                    .foregroundColor(.secondary)
                Text("\(game.homeGoals) - \(game.awayGoals)")
                    .font(.title)
            }
            
            Spacer()
            
            GameTeamInfo(teamName: game.awayTeam.name, team: game.awayTeam, shots: game.awayShots)
            
        }
        .padding(.horizontal, 20)
    }
}

struct GameTeamInfo: View{
    var teamName: String
    var team: Team
    var shots: Int
    var body: some View{
        VStack{
            //Text(teamName)
            TeamInfo(team: team)
            Text("SHOTS")
                .font(.system(size: 8))
                .foregroundColor(.secondary)
            Text("\(shots)")
        }
    }
}

//#Preview {
//    GameHeader(game: Game(homeTeam: Team(name: "Vaksala"), awayTeam: Team(name: "Sundsvall"), periods: [Period( number: 1, homeTeamShots: 0, homeTeamGoals: 0, awayTeamShots: 0, awayTeamGoals: 0 )]))
//}
