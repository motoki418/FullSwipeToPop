//
//  HomeView.swift
//  FullSwipeToPop
//
//  Created by nakamura motoki on 2022/02/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            
            // Sample List...
            List{
                ForEach(1...15, id: \.self){
                    Text("Day\($0) of SwiftUI")
                }// ForEach
            }// List
            .listStyle(.insetGrouped)
            .navigationTitle("Full Swipe Pop")
        }// NavigationView
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
