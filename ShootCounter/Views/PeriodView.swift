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
                addShotButtons(period: period, add: add)
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
    
    var body: some View {
        Button(action: {
            period.addShoot(forHomeTeam: buttonForHomeTeam, add: add)
        }, label: {
            Text("Home")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Material.thin)
            
                .simultaneousGesture(
                    TapGesture().onEnded {
                        // Handling för en enkel tryckning
                        period.addShoot(forHomeTeam: buttonForHomeTeam, add: add)
                    }.exclusively(
                        before: LongPressGesture().onEnded { _ in
                            // Handling för en lång tryckning
                            period.addShoot(forHomeTeam: buttonForHomeTeam, add: add)
                            period.addGoal(forHomeTeam: buttonForHomeTeam, add: add)
                          
                        }
                    )
                )
        })
    }
}

struct addShotButtons: View{
    //@Bindable var game: Game
    var period: Period
    var add: Int
    var body: some View{
        HStack(alignment: .center){
            shotButton(period: period, add: add, buttonForHomeTeam: true)
            shotButton(period: period, add: add, buttonForHomeTeam: false)
//            Button(action: {
//                addShoot(forHomeTeam: true, add: add)
//            }, label: {
//                Text("Home")
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(Material.thin)
//                
//                    .simultaneousGesture(
//                        TapGesture().onEnded {
//                            // Handling för en enkel tryckning
//                            addShoot(forHomeTeam: true, add: add)
//                        }.exclusively(
//                            before: LongPressGesture().onEnded { _ in
//                                // Handling för en lång tryckning
//                                addShoot(forHomeTeam: true, add: add)
//                                addGoal(forHomeTeam: true, add: add)
//                              
//                            }
//                        )
//                    )
//            })
//            .buttonStyle(PlainButtonStyle())
//          
//            
//            Button(action: {
//                addShoot(forHomeTeam: false, add: add)
//            }, label: {
//                Text("Away")
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                 
//                    .background(Material.thin)
//                    .simultaneousGesture(
//                        TapGesture().onEnded {
//                            // Handling för en enkel tryckning
//                            addShoot(forHomeTeam: false, add: add)
//                        }.exclusively(
//                            before: LongPressGesture().onEnded { _ in
//                                // Handling för en lång tryckning
//                                addShoot(forHomeTeam: false, add: add)
//                                addGoal(forHomeTeam: false, add: add)
//                              
//                            }
//                        )
//                    )
//            })
//            .buttonStyle(PlainButtonStyle())
            
//            Button(action: {
//                addShoot(forHomeTeam: false)
//            }, label: {
//                Text("Away")
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .border(.black)
//                    .background(Material.thin)
//            })

          
            

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.secondary)
        .cornerRadius(10)
       
    
    }
//    func addShoot(forHomeTeam: Bool, add: Int){
//        if forHomeTeam {
//            game.periods[periodNR - 1].homeTeamShots += add
//
//        } else{
//            game.periods[periodNR - 1].awayTeamShots += add
//        }
//    }
//    
//    func addGoal(forHomeTeam: Bool, add: Int){
//        if forHomeTeam {
//            game.periods[periodNR - 1].homeTeamGoals += add
//           
//        } else{
//            game.periods[periodNR - 1].awayTeamGoals += add
//        }
//    }
}


//struct shotButton: View{
//    var addshot: (Bool) -> Void
//   // var addGoal: (Bool) -> Void
//
//    var body: some View{
//        Button(action: {
//            self.addShoot(forHomeTeam: true)
//        }, label: {
//            Text("Home")
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .border(.black)
//                .background(Material.thin)
//                .simultaneousGesture(
//                    TapGesture().onEnded {
//                        // Handling för en enkel tryckning
//                        self.addShoot(forHomeTeam: true)
//                    }.exclusively(
//                        before: LongPressGesture().onEnded { _ in
//                            // Handling för en lång tryckning
//                            self.addShoot(forHomeTeam: true)
//                            self.addGoal(forHomeTeam: true)
//                          
//                        }
//                    )
//                )
//        })
//    }
//}


//#Preview {
//    PeriodView(game: Game(homeTeam: Team(name: "Vaksala"), awayTeam: Team(name: "Sundsvall"), periods: [Period( number: 1, homeTeamShots: 0, homeTeamGoals: 0, awayTeamShots: 0, awayTeamGoals: 0 )]), periodNR: 1 )
//}
