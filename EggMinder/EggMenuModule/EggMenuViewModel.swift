import SwiftUI

class EggMenuViewModel: ObservableObject {
    let contact = EggMenuModel()
    @Published var gridItem = [GridItem(.flexible(), spacing: -10),
                               GridItem(.flexible(), spacing: -10)]
    @Published var isAdd = false
}
