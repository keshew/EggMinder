import SwiftUI

struct EggCreateReminderView: View {
    @StateObject var eggCreateReminderModel =  EggCreateReminderViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    @ObservedObject var userDefaultsManager = UserDefaultsManager()
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 39/255, green: 17/255, blue: 25/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.button)
                                    .resizable()
                                    .frame(width: 20, height: 24)
                                    .offset(y: 2)
                            }
                            Text("New Reminder")
                                .Paytone(size: 24)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        .padding(.leading)
                        
                        Spacer(minLength: 30)
                        
                        VStack(spacing: 30) {
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Title")
                                        .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                        .padding(.leading, 20)
                                    Spacer()
                                }
                                
                                CustomTextFiled(text: $eggCreateReminderModel.title,
                                                geometry: geometry,
                                                placeholder: "What do you need to remember?",
                                                image: EggImageName.email.rawValue, isImage: false)
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("When?")
                                        .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                        .padding(.leading, 20)
                                    Spacer()
                                }
                                
                                HStack {
                                    DateTF(date: $eggCreateReminderModel.date,
                                           geometry: geometry)
                                    
                                    Spacer()
                                    
                                    TimeTF(time: $eggCreateReminderModel.time, geometry: geometry)
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        
                        Spacer(minLength: 30)
                        
                        VStack {
                            HStack {
                                Text("Repeat")
                                    .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                    .padding(.leading, 20)
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    eggCreateReminderModel.isNever = true
                                    eggCreateReminderModel.isDaily = false
                                    eggCreateReminderModel.isWeekly = false
                                    eggCreateReminderModel.isMountly = false
                                    eggCreateReminderModel.objectWillChange.send()
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .fill(eggCreateReminderModel.isNever ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 62/255, green: 31/255, blue: 47/255))
                                            .frame(width: 78, height: 40)
                                            .cornerRadius(20)
                                        
                                        Text("Never")
                                            .Paytone(size: 16)
                                          
                                    }
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    eggCreateReminderModel.isNever = false
                                    eggCreateReminderModel.isDaily = true
                                    eggCreateReminderModel.isWeekly = false
                                    eggCreateReminderModel.isMountly = false
                                    eggCreateReminderModel.objectWillChange.send()
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .fill(eggCreateReminderModel.isDaily ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 62/255, green: 31/255, blue: 47/255))
                                            .frame(width: 78, height: 40)
                                            .cornerRadius(20)
                                        
                                        Text("Daily")
                                            .Paytone(size: 16)
                                    }
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    eggCreateReminderModel.isNever = false
                                    eggCreateReminderModel.isDaily = false
                                    eggCreateReminderModel.isWeekly = true
                                    eggCreateReminderModel.isMountly = false
                                    eggCreateReminderModel.objectWillChange.send()
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .fill(eggCreateReminderModel.isWeekly ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 62/255, green: 31/255, blue: 47/255))
                                            .frame(width: 88, height: 40)
                                            .cornerRadius(20)
                                        
                                        Text("Weekly")
                                            .Paytone(size: 16)
                                    }
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    eggCreateReminderModel.isNever = false
                                    eggCreateReminderModel.isDaily = false
                                    eggCreateReminderModel.isWeekly = false
                                    eggCreateReminderModel.isMountly = true
                                    eggCreateReminderModel.objectWillChange.send()
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .fill(eggCreateReminderModel.isMountly ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 62/255, green: 31/255, blue: 47/255))
                                            .frame(width: 98, height: 40)
                                            .cornerRadius(20)
                                        
                                        Text("Mountly")
                                            .Paytone(size: 16)
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                        
                        Spacer(minLength: 30)
                        
                        VStack {
                            HStack {
                                Text("Category")
                                    .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                    .padding(.leading, 20)
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    eggCreateReminderModel.isWork = true
                                    eggCreateReminderModel.isWorkout = false
                                    eggCreateReminderModel.isHealth = false
                                    eggCreateReminderModel.isCooking = false
                                    eggCreateReminderModel.objectWillChange.send()
                                }) {
                                    VStack {
                                        ZStack {
                                            Rectangle()
                                                .fill(eggCreateReminderModel.isWork ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 62/255, green: 31/255, blue: 47/255))
                                                .frame(width: 55, height: 55)
                                                .cornerRadius(55/2)
                                            
                                            Image(.cat1)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                        
                                        Text("work")
                                            .Paytone(size: 16,
                                                     color: eggCreateReminderModel.isWork ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 169/255, green: 160/255, blue: 163/255))
                                    }
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    eggCreateReminderModel.isWork = false
                                    eggCreateReminderModel.isWorkout = true
                                    eggCreateReminderModel.isHealth = false
                                    eggCreateReminderModel.isCooking = false
                                    eggCreateReminderModel.objectWillChange.send()
                                }) {
                                    VStack {
                                        ZStack {
                                            Rectangle()
                                                .fill(eggCreateReminderModel.isWorkout ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 62/255, green: 31/255, blue: 47/255))
                                                .frame(width: 55, height: 55)
                                                .cornerRadius(55/2)
                                            
                                            Image(.cat2)
                                                .resizable()
                                                .frame(width: 30, height: 24)
                                        }
                                        
                                        Text("workout")
                                            .Paytone(size: 16,
                                                     color: eggCreateReminderModel.isWorkout ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 169/255, green: 160/255, blue: 163/255))
                                    }
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    eggCreateReminderModel.isWork = false
                                    eggCreateReminderModel.isWorkout = false
                                    eggCreateReminderModel.isHealth = true
                                    eggCreateReminderModel.isCooking = false
                                    eggCreateReminderModel.objectWillChange.send()
                                }) {
                                    VStack {
                                        ZStack {
                                            Rectangle()
                                                .fill(eggCreateReminderModel.isHealth ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 62/255, green: 31/255, blue: 47/255))
                                                .frame(width: 55, height: 55)
                                                .cornerRadius(55/2)
                                            
                                            Image(.cat3)
                                                .resizable()
                                                .frame(width: 27, height: 24)
                                        }
                                        
                                        Text("health")
                                            .Paytone(size: 16,
                                                     color: eggCreateReminderModel.isHealth ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 169/255, green: 160/255, blue: 163/255))
                                    }
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    eggCreateReminderModel.isWork = false
                                    eggCreateReminderModel.isWorkout = false
                                    eggCreateReminderModel.isHealth = false
                                    eggCreateReminderModel.isCooking = true
                                    eggCreateReminderModel.objectWillChange.send()
                                }) {
                                    VStack {
                                        ZStack {
                                            Rectangle()
                                                .fill(eggCreateReminderModel.isCooking ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 62/255, green: 31/255, blue: 47/255))
                                                .frame(width: 55, height: 55)
                                                .cornerRadius(55/2)
                                            
                                            Image(.cat4)
                                                .resizable()
                                                .frame(width: 27, height: 21)
                                        }
                                        
                                        Text("cooking")
                                            .Paytone(size: 16,
                                                     color: eggCreateReminderModel.isCooking ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 169/255, green: 160/255, blue: 163/255))
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                        
                        Spacer(minLength: 40)
                        
                        Button(action: {
                            if eggCreateReminderModel.title.isEmpty {
                                alertMessage = "Please enter a title."
                                showAlert = true
                            } else {
                                var repeatMode: Repeate = .Never
                                if eggCreateReminderModel.isDaily {
                                    repeatMode = .Daily
                                } else if eggCreateReminderModel.isWeekly {
                                    repeatMode = .Weekly
                                } else if eggCreateReminderModel.isMountly {
                                    repeatMode = .Mountly
                                }
                                
                                var categoryMode = ""
                                if eggCreateReminderModel.isWork {
                                    categoryMode = "cat1"
                                } else if eggCreateReminderModel.isWorkout {
                                    categoryMode = "cat2"
                                } else if eggCreateReminderModel.isHealth {
                                    categoryMode = "cat3"
                                } else if eggCreateReminderModel.isCooking {
                                    categoryMode = "cat4"
                                }
                                
                                let newReminder = RemindModel(
                                    image: categoryMode,
                                    data: eggCreateReminderModel.date,
                                    time: eggCreateReminderModel.time,
                                    repeatMode: repeatMode,
                                    title: eggCreateReminderModel.title
                                )
                                
                                var existingReminders = userDefaultsManager.loadReminders()
                                existingReminders.append(newReminder)
                                userDefaultsManager.saveReminders(existingReminders)
                                NotificationManager.shared.scheduleNotification(reminder: newReminder)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Create Reminder")
                                    .Paytone(size: 16)
                                    .padding(.vertical, 16)
                                Spacer()
                            }
                            .background(Color(red: 201/255, green: 29/255, blue: 86/255))
                            .cornerRadius(30)
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}


#Preview {
    EggCreateReminderView()
}
