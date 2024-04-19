//
//  GameView.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import SwiftUI

struct GameView: View {
    @StateObject var game: Game
    
    var body: some View {
        NavigationStack{
            VStack{
                GameHeader(game: game)
                List{
                    ForEach(game.periods){ period in
                        Section(header: Text("Period: \(period.number)")){
                            NavigationLink(destination: PeriodView(game: game, periodNR: period.number)){
                                periodRow(period: period)
                            }
                        }
                    }
                }
            }
            .toolbar{
                Button("New Period", systemImage: "plus", action: {addPeriod()})
            }
        }
    }
    
    func addPeriod(){
        let num = game.periods.count
        //let number = game.periods.last?.number
       // if let num = num{
        print(num)
        game.periods.append(Period(number: (num + 1)) )
        for period in game.periods{
            print("\(period.number)")
        }
      //  }
        
    }
    
    func addShoot(forHomeTeam: Bool){
        
        if forHomeTeam {
            game.periods[game.periods.count - 1 ].homeTeamShots += 1
        } else{
            game.periods[game.periods.count - 1 ].awayTeamShots += 1
        }
    }
}

struct periodRow: View{
    var period: Period
    var body: some View{
        HStack{
            VStack{
                Text("SHOOTS")
                    .font(.system(size: 8))
                    .foregroundColor(.secondary)
                Text("\(period.homeTeamShots)")
                    .frame(width: 30)
            }

            Spacer()
            VStack{
                Text("GOALS")
                    .font(.system(size: 8))
                    .foregroundColor(.secondary)
                Text("\(period.homeTeamGoals) - \(period.awayTeamGoals)")
            }
            Spacer()
            VStack{
                Text("GOALS")
                    .font(.system(size: 8))
                    .foregroundColor(.secondary)
                Text("\(period.awayTeamShots)")
                    .frame(width: 30)
                
            }

        }
        .frame(maxWidth: .infinity)
        .padding()
        .font(.title2)
    }
}

#Preview {
    GameView(game: Game(homeTeam: Team(name: "Vaksala"), awayTeam: Team(name: "Sundsvall"), periods: [Period( number: 1, homeTeamShots: 0, homeTeamGoals: 0, awayTeamShots: 0, awayTeamGoals: 0 )]))
}
