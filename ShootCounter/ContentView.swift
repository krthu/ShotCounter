//
//  ContentView.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GameView(game: Game(homeTeam: Team(name: "Vaksala"), awayTeam: Team(name: "Sundsvall"), periods: [Period( number: 1, homeTeamShots: 0, homeTeamGoals: 0, awayTeamShots: 0, awayTeamGoals: 0 )]))
    }
}

#Preview {
    ContentView()
}
