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
                HStack{
                    Text("\(game.homeTeam.name)")
                    Spacer()
                    Text("\(game.homeShots) - \(game.awayShots)")
                    Spacer()
                    Text("\(game.awayTeam.name)")
                }
                .padding(.horizontal, 20)
                
                Text("Periods")
                VStack{
                    ForEach(game.periods){ period in
                        VStack{
                            Text("\(period.number)")
                            HStack{
                                Text("\(period.homeTeamShots)")
                                
                                Text(" - ")
                                
                                Text("\(period.awayTeamShots)")
                            }
                        }
                        
                    }
                }
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
                    .border(.black)
                    
                    
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

#Preview {
    GameView(game: Game(homeTeam: Team(name: "Vaksala"), awayTeam: Team(name: "Sundsvall"), periods: [Period( number: 1, homeTeamShots: 0, homeTeamGoals: 0, awayTeamShots: 0, awayTeamGoals: 0 )]))
}
