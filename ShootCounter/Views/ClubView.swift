//
//  ClubView.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-06-19.
//

import SwiftUI

struct ClubView: View {
    @State var club: Club
    @State var showAddTeamSheet = false
    
    
    var body: some View {
        VStack{
            ClubLogoImageView(imageData: club.logoData, maxHeight: 100)
                .padding()
            Form{
                Section("Teams"){
                    ForEach(club.teams){ team in
                        Text(team.name)
                    }
                    .onDelete(perform: { indexSet in
                        deleteTeam(indexSet)
                    })
                }
            }
            Button("Add Team"){
               showAddTeamSheet = true
            }
        }
        .navigationTitle(club.name)
        .sheet(isPresented: $showAddTeamSheet, content:{
            AddTeamSheet(club: $club)
                .presentationDetents([.medium])
        })

        
    }
    func deleteTeam(_ indexSet: IndexSet){
        for index in indexSet{
            club.teams.remove(at: index)
        }
    }
}

struct AddTeamSheet: View {
    @Binding var club: Club
    @State var name = ""
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text("New Team")
                .font(.title)
                .bold()
                .frame(alignment: .center)
            Spacer()
            TextField("Name of team:", text: $name)
            Spacer()
            Button("Save Team"){
                saveTeam()
                    
            }
        }
        .padding()
    }
    func saveTeam(){
        let team = Team(name: name)
        if !club.teams.contains(where: {$0.name.lowercased() == team.name.lowercased() }){
            club.teams.append(team)

            print(club)
            dismiss()
        }
    }
}

//#Preview {
//  //  ClubView()
//}
