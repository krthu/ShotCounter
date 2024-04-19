//
//  GamesListView.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-19.
//

import SwiftUI
import SwiftData

struct GamesListView: View {
    
    @Query var games: [Game]
    @State var showNewGameSheet = false
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(games){ game in
                        // GameRow(game: game)
                        NavigationLink(destination: GameView(game: game)){
                            //                            GameHeader(game: game)
                            //                                .foregroundColor(.black)
                            GameRow(game: game)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        deleteGame(indexSet)
                    })
                    
                }
            }
            .toolbar{
                Button("New Note", systemImage: "plus", action: {showNewGameSheet = true})
            }
            .navigationTitle("Games")
        }
        .sheet(isPresented: $showNewGameSheet, content: {
            NewGameSheet()
        })
        
        
    }
    
    func deleteGame(_ indexSet: IndexSet){
        for index in indexSet{
            let game = games[index]
            modelContext.delete(game)
        }
    }
}

struct GameRow: View{
    var game: Game
    
    var body: some View{
        HStack{
            TeamInfo(team: game.homeTeam)
                .frame(width: 100)
            Spacer()
            Text("\(game.homeGoals) - \(game.awayGoals)")
            Spacer()
            TeamInfo(team: game.awayTeam)
                .frame(width: 100)
                
        }
        .padding()
    }
}

struct TeamInfo: View {
    var team: Team
    var body: some View {
        Text(team.name)
    }
}

struct NewGameSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @State var homeTeamName: String = ""
    @State var awayTeamName: String = ""
    
    var body: some View {
        VStack{
            TextField("Home team name", text: $homeTeamName)
                .padding()
                .border(.black)
            
            TextField("Away team name", text: $awayTeamName)
                .padding()
                .border(.black)
            Button("Create Game"){
                let game = Game(homeTeam: Team(name: homeTeamName), awayTeam: Team(name: awayTeamName))
                modelContext.insert(game)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}



#Preview {
    GamesListView()
}
