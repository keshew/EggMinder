import SwiftUI

class EggHistoryViewModel: ObservableObject {
    let contact = EggHistoryModel()
    @Published var reminders: [RemindModel] = []
    @Published var isClear = false
    
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "dd.MM.yyyy"
       return formatter
   }()
   
   func getGroupedReminders() -> [String: [RemindModel]] {
       var grouped = [String: [RemindModel]]()
       
       for reminder in reminders {
           let key = dateFormatter.string(from: reminder.data)
           grouped[key, default: []].append(reminder)
       }
       
       return grouped
   }
   
   func formatReminderDate(_ date: Date) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "dd.MM, HH:mm"
       
       return dateFormatter.string(from: date)
   }
}
