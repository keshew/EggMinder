import SwiftUI

struct RemindModel: Codable, Identifiable {
    var id = UUID().uuidString
    var image: String
    var data: Date
    var time: Date
    var repeatMode: Repeate
    var title: String
}

enum Repeate: String, Codable {
    case Never
    case Daily
    case Weekly
    case Mountly
}

class EggCreateReminderViewModel: ObservableObject {
    let contact = EggCreateReminderModel()
    @Published var title: String = ""
    @Published var date: Date = Date()
    @Published var time: Date = Date()
    @Published var isNever = true
    @Published var isDaily = false
    @Published var isWeekly = false
    @Published var isMountly = false
    @Published var isWork = true
    @Published var isWorkout = false
    @Published var isHealth = false
    @Published var isCooking = false
}
