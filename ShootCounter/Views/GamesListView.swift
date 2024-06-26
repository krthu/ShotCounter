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
        VStack{
            if let date = game.date{
                Text("Date: \(date.formatted())")
            }
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
}

struct TeamInfo: View {
    var team: Team
    var body: some View {
        VStack{
            TeamLogoImageView(imageData: team.logoData, maxHeight: 50)
            
            Text(team.name)
        }
        
    }
}

struct NewGameSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @State var homeTeamName: String = ""
    @State var awayTeamName: String = ""
    
    @State var selectedPhotoHomeTeam: PhotosPickerItem?
    @State var selectedPhotoDataHomeTeam: Data?
    
    @State var selectedPhotoAwayTeam: PhotosPickerItem?
    @State var selectedPhotoDataAwayTeam: Data?
    
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack{
            Text("New Game")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity)
            
            Spacer()
            Form{
                Section(header: Text("Game")){
                    DatePicker("Date:", selection: $selectedDate)
                }
                
                
                Section(header: Text("Home team")){
                    TextField("Home team name", text: $homeTeamName)
                    HStack{
                        PhotosPicker(selection: $selectedPhotoHomeTeam, matching: .images){
                            Label("Logo", systemImage: "shield.fill")
                        }
                        Spacer()
                        if let selectedPhotoDataHomeTeam,
                           let uiImage = UIImage(data: selectedPhotoDataHomeTeam){
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                    }
                    
                    
                    
                }
  
                Section(header: Text("Away Team")){
                    
                    TextField("Away team name", text: $awayTeamName)
                    //.border(.black)
                    HStack{
                        PhotosPicker(selection: $selectedPhotoAwayTeam, matching: .images){
                            Label("Logo", systemImage: "shield.fill")
                        }
                        Spacer()
                        if let selectedPhotoDataAwayTeam,
                           let uiImage = UIImage(data: selectedPhotoDataAwayTeam){
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                    }
                }
            }
            
            .task(id: selectedPhotoHomeTeam, {
                //                if let data = try? await selectedPhotoHomeTeam?.loadTransferable(type: Data.self){
                //                    selectedPhotoDataHomeTeam = data
                //                }
                await loadSelectedImageData(from: selectedPhotoHomeTeam, to: $selectedPhotoDataHomeTeam)
            })
            .task(id: selectedPhotoAwayTeam, {
                //                if let data = try? await selectedPhotoHomeTeam?.loadTransferable(type: Data.self){
                //                    selectedPhotoDataHomeTeam = data
                //                }
                await loadSelectedImageData(from: selectedPhotoAwayTeam, to: $selectedPhotoDataAwayTeam)
            })
            
            Button("Create Game"){
                let game = Game(homeTeam: Team(name: homeTeamName, logoData: selectedPhotoDataHomeTeam), awayTeam: Team(name: awayTeamName, logoData: selectedPhotoDataAwayTeam), date: selectedDate)
                modelContext.insert(game)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
    @MainActor
    func loadSelectedImageData(from pickerItem: PhotosPickerItem?, to dataBinding: Binding<Data?>) async{
        if let pickerItem = pickerItem, let data = try? await pickerItem.loadTransferable(type: Data.self){
            dataBinding.wrappedValue = data
            
        }
    }
//    @MainActor
//    private func updateSelectedPhotoData(to dataBinding: Binding<Data?>, with data: Data) {
//        dataBinding.wrappedValue = data
//    }
}
    
    
    
    #Preview {
        GamesListView()
    }
