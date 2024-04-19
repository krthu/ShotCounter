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
                .border(.blue)
                HStack{
                    
                    Button(action: {
                        addShoot(forHomeTeam: true)
                    }, label: {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                        
                    })
                    Spacer()
                    Button("Away"){
                        addShoot(forHomeTeam: false)
                    }
                   
                    
                    
                }
                
                
                
            }
            .toolbar{
                Button("New Note", systemImage: "plus", action: {addPeriod()})
            }
        }
    }
    
    func addPeriod(){
        let number = game.periods.last?.number
        if let number = number{
            game.periods.append(Period(number: (number + 1)) )
        }
        
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
            
            Text("\(period.homeTeamShots)")
                .frame(width: 30)
            Spacer()
  
            Text("\(period.homeTeamGoals) - \(period.awayTeamGoals)")
    
            Spacer()
            Text("\(period.awayTeamShots)")
                .frame(width: 30)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .font(.title2)
        
        
    }
    
}

#Preview {
    GameView(game: Game(homeTeam: Team(name: "Vaksala"), awayTeam: Team(name: "Sundsvall"), periods: [Period( number: 1, homeTeamShots: 0, homeTeamGoals: 0, awayTeamShots: 0, awayTeamGoals: 0 )]))
}
