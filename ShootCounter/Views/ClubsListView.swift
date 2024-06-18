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
    @Query var clubs: [Club]
    @State var showAddClubSheet = false
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack{
            VStack{
                ForEach(clubs){ club in
                    Text(club.name)
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
}

struct AddClubSheet: View{
    @State var name = ""
    @State var selectedLogo: PhotosPickerItem?
    @State var selectedLogoData: Data?
    
    
    var body: some View{
        VStack{
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
        .task(id: selectedLogo, {
            //                if let data = try? await selectedPhotoHomeTeam?.loadTransferable(type: Data.self){
            //                    selectedPhotoDataHomeTeam = data
            //                }
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
