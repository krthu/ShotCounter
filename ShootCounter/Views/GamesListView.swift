//
//  GamesListView.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-04-19.
//

import SwiftUI
import SwiftData
import PhotosUI

struct GamesListView: View {
    @Query(sort: \Game.date, order: .reverse)
    var games: [Game]
    @Query var clubs: [Club]
    @State var showNewGameSheet = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack{
            VStack{
                if clubs.isEmpty {
                    Text("Please add a club first!")
                } else if games.isEmpty {
                    Text("No games found")
                }
                
                else {
                    
                    List{
                        ForEach(groupedGames, id: \.key){ date, games in
                            Section(date){
                                ForEach(games){ game in
                                    
                                    NavigationLink(destination: GameView(game: game)){
                                        GameRow(game: game)
                                    }
                                }
                                .onDelete(perform: { indexSet in
                                    deleteGame(indexSet)
                                })
                                
                            }
                        }
                    }
                    .listRowSpacing(5)
                }
            }
            .toolbar{
                if clubs.count != 0 {
                    Button("New Game", systemImage: "plus", action: {showNewGameSheet = true})
                }
                
            }
            .navigationTitle("Games")
        }
        .sheet(isPresented: $showNewGameSheet, content: {
            NewGameSheet()
                .presentationDetents([.medium])
        })
        
        
    }
    
    private var groupedGames: [(key: String, value: [Game])] {
        Dictionary(grouping: games) { game in
            game.date.formatted(date: .complete, time: .omitted)
        }
        .sorted { $0.key > $1.key }
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
        VStack{
            
            HStack{
                TeamInfo(team: game.homeTeam, club: game.homeClub)
                    .frame(width: 100)
                
                VStack{
                    Text(game.date.formatted(date: .omitted, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(game.homeGoals) - \(game.awayGoals)")
                    Spacer()
                }
                Spacer()
                TeamInfo(team: game.awayTeam, club: game.awayClub)
                    .frame(width: 100)
                
            }
            .padding()
        }
        
    }
}

struct TeamInfo: View {
    var team: Team
    var club: Club
    var body: some View {
        VStack{
            ClubLogoImageView(imageData: club.logoData, maxHeight: 50)
            Text(club.name)
            Text(team.name)
                .font(.caption)
            
        }
        
    }
}

struct NewGameSheet: View {
    @Query var clubs: [Club]
    @State var homeClubIndex = 0
    @State var homeTeamIndex = 0
    
    @State var awayClubIndex = 0
    @State var awayTeamIndex = 0
    
    @State var selectedDate = Date()
    var editGame: Game?
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    init(game: Game? = nil ){
        
        self.editGame = game
        
    }
    
    
    var body: some View {
        VStack{
            Text(editGame == nil ? "New Game" : "Edit Game")
                .font(.title2)
                .bold()
                .padding()
            Form{
                Section("Game Info"){
                    DatePicker("Date:", selection: $selectedDate)
                }
                
                
                TeamPickerSection(clubIndex: $homeClubIndex, teamIndex: $homeTeamIndex, clubs: clubs, homeTeam: true)
                
                TeamPickerSection(clubIndex: $awayClubIndex, teamIndex: $awayTeamIndex, clubs: clubs, homeTeam: false)
                
            }
            Button(editGame == nil ? "Create": "Save"){
                if let editGame = editGame{
                    editGame.homeClub = clubs[homeClubIndex]
                    editGame.homeTeam = clubs[homeClubIndex].teams[homeTeamIndex]
                    editGame.awayClub = clubs[awayClubIndex]
                    editGame.awayTeam = clubs[awayClubIndex].teams[awayTeamIndex]
                    editGame.date = selectedDate
                } else{
                    let game = Game(homeClub: clubs[homeClubIndex], homeTeam: clubs[homeClubIndex].teams[homeTeamIndex], awayClub: clubs[awayClubIndex], awayTeam: clubs[awayClubIndex].teams[awayTeamIndex], date: selectedDate)
                    
                    modelContext.insert(game)
                }
                dismiss()
                
                
            }
        }
        .onAppear{
            
            if let game = editGame{
                
                homeClubIndex = clubs.firstIndex(of: game.homeClub) ?? 0
                homeTeamIndex = clubs[homeClubIndex].teams.firstIndex(of: game.homeTeam) ?? 0
                
                awayClubIndex = clubs.firstIndex(of: game.awayClub) ?? 0
                awayTeamIndex = clubs[awayClubIndex].teams.firstIndex(of: game.awayTeam) ?? 0
                
                selectedDate = game.date
                
            }
        }
        .onChange(of: homeClubIndex){
            homeTeamIndex = 0
        }
        .onChange(of: awayClubIndex){
            awayTeamIndex = 0
        }
        
    }
}
struct TeamPickerSection: View {
    @Binding var clubIndex: Int
    @Binding var teamIndex: Int
    var clubs: [Club]
    var homeTeam: Bool
    
    
    var body: some View {
        Section(homeTeam ? "Home Team" : "Away Team"){
            Picker(homeTeam ? "Home Club" :  "Away Club" , selection: $clubIndex){
                ForEach(0..<clubs.count, id:\.self){ index in
                    let club = clubs[index]
                    HStack{
                        Text(club.name)
                    }
                }
            }
            TeamPickerView(teamIndex: $teamIndex, teams: clubs[clubIndex].teams)
        }
    }
}



struct TeamPickerView: View {
    
    @Binding var teamIndex: Int
    var teams: [Team]
    
    
    var body: some View {
        if teams.isEmpty{
            Text("No teams found!")
                .foregroundColor(.red)
        } else {
            Picker("Home Team", selection: $teamIndex){
                ForEach(0..<teams.count, id:\.self){ index in
                    let team = teams[index]
                    Text(team.name)
                }
            }
        }
    }
}

#Preview {
    GamesListView()
}
