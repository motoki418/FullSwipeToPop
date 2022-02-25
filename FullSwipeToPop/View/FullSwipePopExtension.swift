//
//  FullSwipePopExtension.swift
//  FullSwipeToPop
//
//  Created by nakamura motoki on 2022/02/25.
//

import SwiftUI
extension View{
    // Creating a Property for View to access easily...
    func fullSwipePop<Content: View>(show: Binding<Bool>, content: @escaping () -> Content) -> some View{
        
        return FullSwipePopHelper(show: show, mainContent: self, content: content())
    }
}

struct FullSwipePopExtension_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Helper function to Build View...
private struct FullSwipePopHelper<MainContent: View, Content: View>: View{
    
    // Where main Content will be our main view...
    // since we are moving our main left when overlay view shows...
    var mainContent: MainContent
    var content: Content
    @Binding var show: Bool
    
    init(show: Binding<Bool>, mainContent: MainContent, content: Content) {
        self._show = show
        self.content = content
        self.mainContent = mainContent
    }
    
    // Gesture Properties...
    @GestureState var gestureOffset: CGFloat = 0
    @State var offset: CGFloat = 0
    
    var body: some View{
        // Geometry Reader for Getting Screen width for gesture calc...
        GeometryReader{proxy in
            mainContent
            // Moving main Content Slightly...
                .offset(x: show && offset >= 0 ? getOffset(size: proxy.size.width) : 0)
                .overlay(
                    ZStack{
                        if show{
                            content
                            
                            // 右から左へのスワイプを無効にする
                                .offset(x: offset > 0 ? offset : 0)
                            // Adding Gesture...
                                .gesture(DragGesture().updating($gestureOffset,
                                                                body: { value, out, _ in
                                    out = value.translation.width
                                    print(value)
                                    print(out)
                                }).onEnded({ value in
                                    
                                    // Close if pass...
                                    withAnimation(.linear.speed(2)){
                                        offset = 0
                                        
                                        let translation = value.translation.width
                                        
                                        let maxtranslation = proxy.size.width / 2.5
                                        
                                        if translation > maxtranslation{
                                            show = false
                                        }
                                    }
                                }))
                                .transition(.move(edge: .trailing))
                        }
                    }// ZStack
                )// .overlay
            // Updating Offset...
            // This is why bcx it will update only for valid touch...
                .onChange(of: gestureOffset){ newValue in
                    offset = gestureOffset
                }// .onChange
        }// GeometryReader
    }// body
    
    func getOffset(size: CGFloat) -> CGFloat{
        let progress = offset / size
        
        // Were slighlty moving the view
        // and getting back to 0 based on user drag...
        let start: CGFloat = -80
        let progressWidth = (progress * 90) <= 90 ? (progress * 90) : 90
        
        let mainOffset = (start + progressWidth) < 0 ? (start + progressWidth) : 0
        
        return mainOffset
    }
}
