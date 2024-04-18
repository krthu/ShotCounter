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
            Text("\(game.homeTeam.name)")
            Spacer()
            Text("\(game.homeShots) - \(game.awayShots)")
            Spacer()
            Text("\(game.awayTeam.name)")
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    GameHeader(game: Game(homeTeam: Team(name: "Vaksala"), awayTeam: Team(name: "Sundsvall"), periods: [Period( number: 1, homeTeamShots: 0, homeTeamGoals: 0, awayTeamShots: 0, awayTeamGoals: 0 )]))
}
