import SwiftUI

class EggOboardingViewModel: ObservableObject {
    let contact = EggOboardingModel()
    @Published var isCreating = false
    @Published var isLogin = false
    @Published var isGuest = false
}
