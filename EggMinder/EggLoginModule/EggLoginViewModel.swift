import SwiftUI

class EggLoginViewModel: ObservableObject {
    let contact = EggLoginModel()
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isRegistered: Bool = false
    @Published var isSigIn: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var showEmptyFieldsAlert = false
    @Published var showInvalidCredentialsAlert = false
}
