import SwiftUI

struct EggTabBarView: View {
    @StateObject var eggTabBarModel =  EggTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .Home
    @AppStorage("isEgg") private var isEgg = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
       
            VStack {
                if selectedTab == .Home {
                    EggMenuView()
                } else if selectedTab == .History {
                    EggHistoryView()
                } else if selectedTab == .Profile {
                    EggProfileView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            if isEgg {
                EggBreakView()
                    .ignoresSafeArea()
            }
            
            CustomTabBar(selectedTab: $selectedTab)
                .offset(y: isEgg ? 590 : 0)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EggTabBarView()
}


