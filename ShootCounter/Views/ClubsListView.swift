//
//  ClubsListView.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-06-18.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ClubsListView: View {
    @Query(sort: \Club.name) var clubs: [Club]
    @Query var games: [Game]
    @State var showAddClubSheet = false
    @Environment(\.modelContext) private var modelContext
    @State var showAlert = false
    @State private var clubToDelete: Club?
    
    
  
    var body: some View {
        NavigationStack{
            List{
                ForEach(clubs){ club in
                
                    NavigationLink(destination: ClubView(club: club)){
                        ClubListItemView(club: club)
                        //.frame(maxWidth: .infinity, maxHeight: 50)
                    }
                }
                .onDelete(perform: { indexSet in
                    if let index = indexSet.first{
                        clubToDelete = clubs[index]
                        showAlert = true
                    }
                 //   deleteClub(indexSet)
                })
              //  .frame(maxWidth: .infinity)
            }
            .alert("Delete Club", isPresented: $showAlert){
                Button(role: .destructive){
                    if let clubToDelete = clubToDelete {
                        delete(club: clubToDelete)
                    }
                } label: {
                    Text("Delete")
                }
                Button("Cancel", role: .cancel){
                }
            }
                
            
   
            .toolbar{
                Button("New Club", systemImage: "plus", action: {showAddClubSheet = true})
            }
            .navigationTitle("Clubs")
        }
        .sheet(isPresented: $showAddClubSheet, content: {
            AddClubSheet()
                .presentationDetents([.medium])
        })
  

    }
    func delete(club: Club){
 //   func deleteClub(_ indexSet: IndexSet){
     //   for index in indexSet {
     //       let club = clubs[index]
   //         deleteGamesWith(club: club)
            deleteGamesWith(club: club)
            modelContext.delete(club)
     //   }
    }
//    
//    func deleteGamesWith(club: Club) {
//        
////        @Query(filter: #Predicate<Game> { game in
////            game.awayClub == club || game.homeClub == club
////        }) var gamesToDelete: [Game]
////        for game in gamesToDelete{
////            modelContext.delete(game)
////        }
////        
////        
////        
////        let gamesToDelete = modelContext.fetch(#Predicate<Game>).filter{$0.homeClub == club || $0.awayClub == club}
//        let gamesToDelete = FetchDescriptor(predicate: #Predicate<Game> { game in
//            game.awayClub == club || game.homeClub == club })
//    }
    func deleteGamesWith(club: Club){
        for game in games {
            if game.awayClub == club || game.homeClub == club {
                modelContext.delete(game)
            }
        }
    }
}
    


struct ClubListItemView: View {
    var club: Club
    var body: some View {
        HStack{
            ClubLogoImageView(imageData: club.logoData, maxWidth: 70, maxHeight: 70)
            VStack{
                Text(club.name)
                    .bold()
            }
           
        }
 
    }
}



struct AddClubSheet: View{
    @State var name = ""
    @State var selectedLogo: PhotosPickerItem?
    @State var selectedLogoData: Data?
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View{
        Text("Create Club")
            .font(.title3)
            .bold()
            .padding()
        Form{
            TextField("Name:", text: $name)
                
            HStack{
                PhotosPicker(selection: $selectedLogo, matching: .images){
                    Label("Logo", systemImage: "shield.fill")
                }
                Spacer()
                if let selectedLogoData,
                   let uiImage = UIImage(data: selectedLogoData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
            }
            
            
            
        }
        Button("Create"){
            let newClub = Club(name: name, logoData: selectedLogoData)
            modelContext.insert(newClub)
            presentationMode.wrappedValue.dismiss()
        }
   
        .task(id: selectedLogo, {
            await loadSelectedImageData(from: selectedLogo, to: $selectedLogoData)
        })
        
    }
    
    @MainActor
    func loadSelectedImageData(from pickerItem: PhotosPickerItem?, to dataBinding: Binding<Data?>) async{
        if let pickerItem = pickerItem, let data = try? await pickerItem.loadTransferable(type: Data.self){
            dataBinding.wrappedValue = data
            
        }
    }
}


#Preview {
    AddClubSheet()
}
