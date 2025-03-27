import Foundation
import SwiftUI

class UserDefaultsManager: ObservableObject {
    func enterAsGuest() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "guest")
    }
    
    func isGuest() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "guest")
    }
    
    func quitQuest() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "guest")
    }
    
    func register(email: String, password: String, nickname: String) -> Bool {
        let userDefaults = UserDefaults.standard
        var storedUsers: [String: [String: String]] = [:]
        
        if let existingUsers = userDefaults.dictionary(forKey: "users") as? [String: [String: String]] {
            storedUsers = existingUsers
        }
        
        storedUsers[email] = ["password": password, "nickname": nickname]
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        userDefaults.set(storedUsers, forKey: "users")
        userDefaults.set(dateFormatter.string(from: currentDate), forKey: "accountCreationDate")
        
        saveLoginStatus(true)
        return true
    }
    
    func checkLogin() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "isLoggedIn")
    }
    
    private func saveLoginStatus(_ isLoggedIn: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isLoggedIn, forKey: "isLoggedIn")
    }
    
    func deleteAccount() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "users")
        saveLoginStatus(false)
    }
    
    func getNickname(for email: String) -> String? {
        let defaults = UserDefaults.standard
        if let storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: String]] {
            return storedUsers[email]?["nickname"]
        }
        return nil
    }
    
    func getEmail() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "currentEmail")
    }
    
    func logout() {
        saveLoginStatus(false)
    }
    
    func saveCurrentEmail(_ email: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "currentEmail")
    }
    
    func login(email: String, password: String) -> Bool {
        let defaults = UserDefaults.standard
        if let storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: String]] {
            for (storedUsername, storedUser) in storedUsers {
                if email == storedUsername && password == storedUser["password"] {
                    saveLoginStatus(true)
                    saveCurrentEmail(email)
                    return true
                }
            }
        }
        return false
    }
    
    func saveProfileImage(_ image: UIImage) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = "profileImage.png"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if let imageData = image.pngData() {
            do {
                try imageData.write(to: fileURL)
                print("Изображение сохранено успешно")
            } catch {
                print("Ошибка сохранения изображения: \(error)")
            }
        }
    }
    
    func loadProfileImage() -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileName = "profileImage.png"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            if let imageData = try? Data(contentsOf: fileURL) {
                return UIImage(data: imageData)
            }
        }
        
        return nil
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    func saveReminders(_ reminders: [RemindModel]) {
        var dataToSave: [[String: String]] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        for reminder in reminders {
            let dataString = dateFormatter.string(from: reminder.data)
            let timeString = timeFormatter.string(from: reminder.time)
            
            let dict: [String: String] = [
                "id": reminder.id,
                "image": reminder.image,
                "data": dataString,
                "time": timeString,
                "repeatMode": reminder.repeatMode.rawValue,
                "title": reminder.title
            ]
            
            dataToSave.append(dict)
        }
        
        UserDefaults.standard.set(dataToSave, forKey: "reminders")
    }
    
    func loadReminders() -> [RemindModel] {
        guard let data = UserDefaults.standard.array(forKey: "reminders") as? [[String: String]] else {
            return []
        }
        
        var reminders: [RemindModel] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        for dict in data {
            guard let id = dict["id"],
                  let image = dict["image"],
                  let dataString = dict["data"],
                  let timeString = dict["time"],
                  let repeatModeRaw = dict["repeatMode"],
                  let repeatMode = Repeate(rawValue: repeatModeRaw),
                  let title = dict["title"] else {
                continue
            }
            
            guard let dataDate = dateFormatter.date(from: dataString),
                  let timeDate = timeFormatter.date(from: timeString) else {
                continue
            }
            
            var components = Calendar.current.dateComponents([.year, .month, .day], from: dataDate)
            let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: timeDate)
            components.hour = timeComponents.hour
            components.minute = timeComponents.minute
            
            guard let reminderDate = Calendar.current.date(from: components) else {
                continue
            }
            
            let reminder = RemindModel(id: id, image: image, data: reminderDate, time: reminderDate, repeatMode: repeatMode, title: title)
            reminders.append(reminder)
        }
        
        return reminders
    }
    
    func deleteReminder(_ reminder: RemindModel) {
        var reminders = loadReminders()
        
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders.remove(at: index)
            saveReminders(reminders)
        }
    }
    
    func clearAllReminders() {
        UserDefaults.standard.removeObject(forKey: "reminders")
    }
}
