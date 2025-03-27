import SwiftUI

struct EggMenuView: View {
    @StateObject var eggMenuModel =  EggMenuViewModel()
    @State private var reminders: [RemindModel] = []
    @ObservedObject var userDefaultsManager = UserDefaultsManager()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 39/255, green: 17/255, blue: 25/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("My Eggs")
                                .Paytone(size: 24,
                                         color:  Color(red: 236/255, green: 192/255, blue: 22/255))
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 30)
                        
                        Image(.menu)
                            .resizable()
                            .frame(width: geometry.size.width * 0.92, height: 200)
                            .cornerRadius(20)
                        
                        Spacer(minLength: 20)
                        
                        LazyVGrid(columns: eggMenuModel.gridItem, spacing: 20) {
                            ForEach(reminders) { reminder in
                                if reminder.repeatMode == .Never {
                                    NonRepeateView(reminder: reminder, geometry: geometry)
                                } else {
                                    RepeateView(reminder: reminder, geometry: geometry)
                                }
                            }
                        }
                    }
                    .padding(.top)
                    
                    Color(.clear)
                        .frame(height: 60)
                }
                
                Button(action: {
                    eggMenuModel.isAdd = true
                }) {
                    Image(.addButton)
                        .resizable()
                        .frame(width: 65, height: 65)
                }
                .position(x: geometry.size.width / 1.15, y: geometry.size.height / 1.17)
                .fullScreenCover(isPresented: $eggMenuModel.isAdd) {
                    EggCreateReminderView()
                }
                .disabled(UserDefaultsManager().isGuest() ? true : false)
                .opacity(UserDefaultsManager().isGuest() ? 0.5 : 1)
            }
            .onAppear {
                reminders = userDefaultsManager.loadReminders()
            }
            
            .onChange(of: eggMenuModel.isAdd) { newValue in
                if !newValue {
                    reminders = userDefaultsManager.loadReminders()
                }
            }
        }
    }
}

#Preview {
    EggMenuView()
}

struct NonRepeateView: View {
    var reminder: RemindModel
    var geometry: GeometryProxy
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [Color(red: 236/255, green: 192/255, blue: 22/255), Color(red: 236/255, green: 192/255, blue: 22/255)],
                                     startPoint: .leading,
                                     endPoint: .trailing))
                .frame(width: geometry.size.width * 0.43, height: geometry.size.height * 0.186)
                .cornerRadius(20)
            
            VStack {
                HStack {
                    Image(reminder.image)
                        .resizable()
                        .frame(width: 24, height: reminder.image == "cat2" ? 20 : 24)
                        .padding(.leading)
                        .padding(.top)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(reminder.title)
                            .Paytone(size: 16,
                                     color: Color(red: 39/255, green: 17/255, blue: 25/255))
                        
                        Text(getFormattedDate(date: reminder.data))
                            .Paytone(size: 12,
                                     color: Color(red: 74/255, green: 48/255, blue: 25/255))
                    }
                    .padding(.bottom, 10)
                    .padding(.leading)
                    
                    Spacer()
                }
            }
        }
        .frame(width: geometry.size.width * 0.43, height: geometry.size.height * 0.186)
    }
    
    func getFormattedDate(date: Date) -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Today, \(date.formatted(date: .omitted, time: .shortened))"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM, HH:mm"
            return dateFormatter.string(from: date)
        }
    }
}

struct RepeateView: View {
    var reminder: RemindModel
    var geometry: GeometryProxy
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 60/255, green: 40/255, blue: 47/255))
                .frame(width: geometry.size.width * 0.43, height: geometry.size.height * 0.186)
                .cornerRadius(20)
            
            VStack {
                HStack {
                    Image(reminder.image)
                        .resizable()
                        .frame(width: 24, height: reminder.image == "cat2" ? 20 : 24)
                        .padding(.leading)
                        .padding(.top)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(reminder.title)
                            .Paytone(size: 16)
                        
                        Text(getFormattedDate(date: reminder.data))
                            .Paytone(size: 12)
                    }
                    .padding(.bottom, 10)
                    .padding(.leading)
                    
                    Spacer()
                }
            }
        }
        .frame(width: geometry.size.width * 0.43, height: geometry.size.height * 0.186)
    }
    
    func getFormattedDate(date: Date) -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "\(reminder.repeatMode), \(date.formatted(date: .omitted, time: .shortened))"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM, HH:mm"
            return dateFormatter.string(from: date)
        }
    }
}
