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
    
    @Query var games: [Game]
    @State var showNewGameSheet = false
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(games){ game in
                        NavigationLink(destination: GameView(game: game)){
                            GameRow(game: game)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        deleteGame(indexSet)
                    })
                    
                }
                .listRowSpacing(10)
            }
            .toolbar{
                Button("New Note", systemImage: "plus", action: {showNewGameSheet = true})
            }
            .navigationTitle("Games")
        }
        .sheet(isPresented: $showNewGameSheet, content: {
            NewGameSheet()
                .presentationDetents([.medium])
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
        VStack{
            if let logodata = team.logoData,
               let uiImage = UIImage(data: logodata){
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }else{
                Image(systemName: "shield.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            Text(team.name)
        }
        
    }
}

struct NewGameSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @State var homeTeamName: String = ""
    @State var awayTeamName: String = ""
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    
    var body: some View {
        VStack{
            Text("New Game")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity)
                
            Spacer()
            Form{
                Section(header: Text("Home team")){
                    TextField("Home team name", text: $homeTeamName)
                    HStack{
                        PhotosPicker(selection: $selectedPhoto, matching: .images){
                            Label("Logo", systemImage: "shield.fill")
                        }
                        Spacer()
                        if let selectedPhotoData,
                           let uiImage = UIImage(data: selectedPhotoData){
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                    }

      
                    
                }
                    //.border(.black)
                Section(header: Text("Away Team")){
                    
                    TextField("Away team name", text: $awayTeamName)
                      
                    Label("Logo", systemImage: "shield.fill")
                    //.border(.black)
                }
            }
            .task(id: selectedPhoto, {
                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                    selectedPhotoData = data
                }
            })
            Button("Create Game"){
                let game = Game(homeTeam: Team(name: homeTeamName, logoData: selectedPhotoData), awayTeam: Team(name: awayTeamName))
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
