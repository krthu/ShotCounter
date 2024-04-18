//
//  PeriodView.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import SwiftUI

struct PeriodView: View {
    @ObservedObject var game: Game
    
    var body: some View {
        ZStack{
            Color(.gray)
                .ignoresSafeArea()
                
            VStack{
                GameHeader(game: game)
                    .padding()
                
                periodRow(period: game.periods[0])
                addShotButtons()
            }
            .background()
            .cornerRadius(10)
            .padding()
            
            
            

        }
        
       
        
    }
}

struct addShotButtons: View{
    var body: some View{
        HStack(alignment: .center){
            Button(action: {
                print("Home")
            }, label: {
                Text("Home")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(.black)
                    .background(Material.thin)
            })
            
            Button(action: {
                print("Away")
            }, label: {
                Text("Away")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(.black)
                    .background(Material.thin)
            })

          
            

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
    
    }
}


#Preview {
    PeriodView(game: Game(homeTeam: Team(name: "Vaksala"), awayTeam: Team(name: "Sundsvall"), periods: [Period( number: 1, homeTeamShots: 0, homeTeamGoals: 0, awayTeamShots: 0, awayTeamGoals: 0 )]))
}
