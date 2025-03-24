import SwiftUI

class EggProfileViewModel: ObservableObject {
    let contact = EggProfileModel()
    @Published var isPush: Bool {
           didSet {
               UserDefaults.standard.set(isPush, forKey: "isPushEnabled")
               if isPush {
                   UNUserNotificationCenter.current().getNotificationSettings { settings in
                       if settings.authorizationStatus != .authorized {
                           NotificationManager.shared.requestPermission { granted in
                               if !granted {
                                   DispatchQueue.main.async {
                                       self.isPush = false
                                       UserDefaults.standard.set(false, forKey: "isPushEnabled")
                                   }
                               }
                           }
                       }
                   }
               } else {
                   NotificationManager.shared.cancelAllNotifications()
               }
           }
       }

    @Published var isEmail: Bool {
          didSet {
              UserDefaults.standard.set(isEmail, forKey: "isEmailEnabled")
              if isEmail {
              } else {
              }
          }
      }
    
       @Published var isImagePick = false
       @Published var selectedImage: UIImage?
       @Published var isLogOut = false

    init() {
         self.isPush = UserDefaults.standard.bool(forKey: "isPushEnabled")
         self.isEmail = UserDefaults.standard.bool(forKey: "isEmailEnabled")
     }

     deinit {
         UserDefaults.standard.set(isPush, forKey: "isPushEnabled")
         UserDefaults.standard.set(isEmail, forKey: "isEmailEnabled")
     }
}
