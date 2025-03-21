import SwiftUI

class EggBreakViewModel: ObservableObject {
    let contact = EggBreakModel()
    @Published var isBroke = false
}
