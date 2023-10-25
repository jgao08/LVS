//
//  ContentView.swift
//  FirebaseTest
//
//  Created by Jacky Gao on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userViewModel = UserViewModel()
        
        var body: some View {
            VStack {
                Text("Name: \(userViewModel.user?.name ?? "")")
                Text("Photo: \(userViewModel.user?.photo ?? "")")
            }
            .onAppear {
                userViewModel.fetchUserData()
            }
        }
}

#Preview {
    ContentView()
}
