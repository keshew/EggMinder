import SwiftUI

struct EggHistoryView: View {
    @StateObject var eggHistoryModel = EggHistoryViewModel()
    @ObservedObject var userDefaultsManager = UserDefaultsManager()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 39/255, green: 17/255, blue: 25/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("History")
                                .Paytone(size: 24,
                                         color: Color(red: 236/255, green: 192/255, blue: 22/255))
                                .padding(.leading)
                            
                            Spacer()
                            
                            Button(action: {
                                userDefaultsManager.clearAllReminders()
                                eggHistoryModel.isClear = true
                            }) {
                                Text("Clear All")
                                    .Paytone(size: 14, color: Color(red: 200/255, green: 29/255, blue: 86/255))
                                
                            }
                            .padding(.trailing)
                        }
                        
                        Spacer(minLength: 20)
                        
                        let groupedReminders = eggHistoryModel.getGroupedReminders()
                        let sortedDates = groupedReminders.keys.sorted(by: { $0 > $1 })
                        
                        ForEach(sortedDates, id: \.self) { dateKey in
                            let remindersForDate = groupedReminders[dateKey] ?? []
                            if let date = eggHistoryModel.dateFormatter.date(from: dateKey) {
                                if Calendar.current.isDateInToday(date) {
                                    HStack {
                                        Text("Today")
                                            .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                            .padding(.leading, 20)
                                        
                                        Spacer()
                                    }
                                    
                                } else {
                                    HStack {
                                        Text(dateKey)
                                            .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                            .padding(.leading, 20)
                                        
                                        Spacer()
                                    }
                                }
                            }
                            ForEach(remindersForDate) { reminder in
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 50/255, green: 29/255, blue: 37/255))
                                        .frame(height: 72)
                                        .cornerRadius(15)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        Circle()
                                            .fill(Color(red: 80/255, green: 29/255, blue: 47/255))
                                            .frame(width: 45, height: 45)
                                            .overlay {
                                                Image(reminder.image)
                                                    .resizable()
                                                    .frame(width: 19, height: reminder.image == "cat2" ? 17 : 20)
                                            }
                                            .padding(.leading, 30)
                                        
                                        VStack(alignment: .leading) {
                                            Text(reminder.title)
                                                .Paytone(size: 16)
                                                .lineLimit(1)
                                            
                                            Text(eggHistoryModel.formatReminderDate(reminder.data))
                                                .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                        }
                                        .padding(.leading, 5)
                                        
                                        Spacer()
                                        
                                        Text(reminder.data > Date() ? "On Time" : "Late")
                                            .Paytone(size: 14,
                                                     color: reminder.data > Date() ? Color(red: 235/255, green: 191/255, blue: 24/255) : Color(red: 200/255, green: 29/255, blue: 86/255))
                                            .padding(.trailing, 40)
                                    }
                                }
                            }
                        }
                        
                        Color(.clear)
                            .frame(height: 55)
                    }
                    .padding(.top)
                }
            }
            .onAppear {
                eggHistoryModel.reminders = userDefaultsManager.loadReminders()
            }
            
            .onChange(of: eggHistoryModel.isClear) { newValue in
                if newValue {
                    eggHistoryModel.reminders = userDefaultsManager.loadReminders()
                    eggHistoryModel.isClear = false 
                }
            }
        }
    }
}


#Preview {
    EggHistoryView()
}
