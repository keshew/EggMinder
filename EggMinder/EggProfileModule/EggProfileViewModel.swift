import SwiftUI

class EggProfileViewModel: ObservableObject {
    let contact = EggProfileModel()
    @Published var isPush = true
    @Published var isEmail = false
    @Published var isImagePick = false
    @Published var selectedImage: UIImage?
    @Published var isLogOut = false
}
