import SwiftUI

class EggCreateAccountViewModel: ObservableObject {
    let contact = EggCreateAccountModel()
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var secondPassword: String = ""
    @Published var isReg = false
    @Published var showEmptyFieldsAlert = false
    @Published var showPasswordsMismatchAlert = false
    @Published var isImagePick = false
    @Published var selectedImage: UIImage?
}
