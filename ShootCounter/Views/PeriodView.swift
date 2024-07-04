//
//  PeriodView.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-18.
//

import SwiftUI

struct PeriodView: View {
    @Bindable var game: Game
    var period: Period
    @State var add = 1
    
    
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack{
                GameHeader(game: game)
                    .padding()
                
                periodRow(period: period)
                    .background(.secondary)
                    .cornerRadius(10)
               // addShotButtons(game: game, periodNR: period.number, add: add)
                addShotButtons(game: game, period: period, add: add)
                Button(action: {
                    if add == 1{
                        add = -1
                    } else{
                        add = 1
                    }
                }, label: {
                    Text(add == 1 ? "Add" : "Remove")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(add == 1 ? Color(.systemBackground) : .red)
                        
                })
                .buttonStyle(PlainButtonStyle())
                
            }
            .background()
            .cornerRadius(10)
            .padding()
        }
        .navigationTitle("Period \(period.number)")
        .navigationBarTitleDisplayMode(.inline)
//        .toolbar{
//            Button(action: {
//                if add == 1{
//                    add = -1
//                } else{
//                    add = 1
//                }
//            }, label: {
//                Image(systemName: add == 1 ? "plus" : "minus")
//            })
//        }
    }
}

struct shotButton: View {
    var period: Period
    var add: Int
    var buttonForHomeTeam: Bool
    var team: Team
    var club: Club
    
    
    var body: some View {
        Button(action: {
            period.addShoot(forHomeTeam: buttonForHomeTeam, add: add)
        }, label: {
            VStack{
                Spacer()
                ClubLogoImageView(imageData: club.logoData, maxHeight: 100)
                Text(club.name)
                Text(team.name)
                    .font(.caption)
                  //  .frame(maxWidth: .infinity, maxHeight: .infinity)
                  //  .background(Material.thin)
                Spacer()
            }
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture().onEnded {
                    
                    period.addShoot(forHomeTeam: buttonForHomeTeam, add: add)
                }.exclusively(
                    before: LongPressGesture().onEnded { _ in
                        
                        period.addShoot(forHomeTeam: buttonForHomeTeam, add: add)
                        period.addGoal(forHomeTeam: buttonForHomeTeam, add: add)
                        
                    }
                )
            )
        })
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
            )
    }
}

struct addShotButtons: View{
    //@Bindable var game: Game
    var game: Game
    var period: Period
    var add: Int
    var body: some View{
        HStack(alignment: .center){
            shotButton(period: period, add: add, buttonForHomeTeam: true, team: game.homeTeam, club: game.homeClub)
            shotButton(period: period, add: add, buttonForHomeTeam: false, team: game.awayTeam, club: game.awayClub)


        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(.secondary)
        
       // .cornerRadius(10)

       
    
    }

}



//#Preview {
//    PeriodView(game: Game(homeTeam: Team(name: "Vaksala"), awayTeam: Team(name: "Sundsvall"), periods: [Period( number: 1, homeTeamShots: 0, homeTeamGoals: 0, awayTeamShots: 0, awayTeamGoals: 0 )]), periodNR: 1 )
//}
