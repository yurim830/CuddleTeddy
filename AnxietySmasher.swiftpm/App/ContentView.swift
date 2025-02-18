import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView {
            StressSmasherView()
                .tabItem {
                    Label("Stress Smasher", systemImage: "hand.tap")
                }
                .onAppear {
                    selectedTab = 0
                }

            CheerUpView()
                .tabItem {
                    Label("Cheer Up", systemImage: "message")
                }
                .onAppear {
                    selectedTab = 1
                }
            
            SafeSpaceView()
                .tabItem {
                    Label("Safe Space", systemImage: "pencil.line")
                }
                .onAppear {
                    selectedTab = 2
                }
        }
        .accentColor(TabAccentColorType.allCases[selectedTab].color)
    }
    
}
