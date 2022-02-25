//
//  HomeView.swift
//  FullSwipeToPop
//
//  Created by nakamura motoki on 2022/02/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var show = false
    
    // Storing Current Day...
    @State private var CurrentDay: Int = 1
    
    var body: some View {
        NavigationView{
            // Sample List...
            List{
                Section(header: Text("Tutoriall's")){
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
                }// Section
            }// List
            .listStyle(.insetGrouped)
            .navigationTitle("Full Swipe Pop")
        }// NavigationView
        .fullSwipePop(show: $show){
            List{
                Section(header: Text("Day \(CurrentDay)")){
                    ForEach(1...30, id: \.self){index in
                        Text("Course \(index)")
                    }// ForEach
                }// Section
            }// List
        }// .fullSwipePop
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
