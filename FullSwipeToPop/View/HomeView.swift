//
//  HomeView.swift
//  FullSwipeToPop
//
//  Created by nakamura motoki on 2022/02/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var show = false
    
    var body: some View {
        NavigationView{
            
            // Sample List...
            List{
                ForEach(1...15, id: \.self){index in
                    Button{
                        withAnimation{
                            show.toggle()
                        }
                    }label: {
                        
                        Text("Day\(index) of SwiftUI")
                    }
                    .foregroundColor(.primary)
                }// ForEach
            }// List
            .listStyle(.insetGrouped)
            .navigationTitle("Full Swipe Pop")
        }// NavigationView
        .fullSwipePop(show: $show){
            Color.red
                .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
