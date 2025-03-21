import SwiftUI

struct EggBreakView: View {
    @StateObject var eggBreakModel =  EggBreakViewModel()
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isEgg") private var isEgg = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.black)
                    .opacity(0.5)
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color(red: 39/255, green: 17/255, blue: 25/255))
                            .frame(width: 342, height: 590)
                            .cornerRadius(20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 71/255, green: 19/255, blue: 37/255), lineWidth: 3)
                            }
                        
                        VStack(spacing: 45) {
                            VStack(spacing: 10) {
                                if eggBreakModel.isBroke {
                                    Text("COOL!")
                                        .Paytone(size: 24,
                                                 color: Color(red: 236/255, green: 192/255, blue: 22/255))
                                    
                                    Text("Daily Workout Reminder")
                                        .Paytone(size: 14, color: .clear)
                                } else {
                                    Text("Time to Break an Egg!")
                                        .Paytone(size: 24,
                                                 color: Color(red: 236/255, green: 192/255, blue: 22/255))
                                    
                                    Text("Daily Workout Reminder")
                                        .Paytone(size: 14)
                                }
                            }
                            
                            Image(eggBreakModel.isBroke ? .eggBroken : .eggBreake)
                                .resizable()
                                .frame(width: 174, height: 224)
                            
                            VStack(spacing: 5) {
                                if eggBreakModel.isBroke {
                                    Button(action: {
                                        isEgg = false
                                    }) {
                                        HStack {
                                            Spacer()
                                            
                                            Text("Close")
                                                .Paytone(size: 16, color: Color(red: 200/255, green: 29/255, blue: 86/255))
                                                .padding(.vertical, 16)
                                            
                                            Spacer()
                                        }
                                    }
                                    .background(Color(red: 88/255, green: 21/255, blue: 43/255))
                                    .cornerRadius(30)
                                    .padding(.horizontal, 20)
                                } else {
                                    Button(action: {
                                        eggBreakModel.isBroke = true
                                    }) {
                                        HStack {
                                            Spacer()
                                            
                                            Image(.egg)
                                                .resizable()
                                                .frame(width: 12, height: 16)
                                            
                                            Text("Break the Egg")
                                                .Paytone(size: 16)
                                                .padding(.vertical, 16)
                                            
                                            Spacer()
                                        }
                                        .background(Color(red: 201/255, green: 29/255, blue: 86/255))
                                        .cornerRadius(30)
                                        .padding(.horizontal, 20)
                                    }
                                }
                            
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    eggBreakModel.isBroke = true
                                }) {
                                    Text("5 min")
                                        .Paytone(size: 16, color: Color(red: 201/255, green: 29/255, blue: 86/255))
                                }
                                
                                .cornerRadius(30)
                                .frame(width: 88, height: 60)
                                .disabled(eggBreakModel.isBroke ? true : false)
                                .opacity(eggBreakModel.isBroke ? 0.5 : 1)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(red: 201/255, green: 29/255, blue: 86/255), lineWidth: 2)
                                        .frame(width: 88, height: 60)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    eggBreakModel.isBroke = true
                                }) {
                                    Text("15 min")
                                        .Paytone(size: 16, color: Color(red: 201/255, green: 29/255, blue: 86/255))
                                }
                                
                                .cornerRadius(30)
                                .frame(width: 88, height: 60)
                                .disabled(eggBreakModel.isBroke ? true : false)
                                .opacity(eggBreakModel.isBroke ? 0.5 : 1)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(red: 201/255, green: 29/255, blue: 86/255), lineWidth: 2)
                                        .frame(width: 88, height: 60)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    eggBreakModel.isBroke = true
                                }) {
                                    Text("30 min")
                                        .Paytone(size: 16, color: Color(red: 201/255, green: 29/255, blue: 86/255))
                                }
                                .cornerRadius(30)
                                .frame(width: 88, height: 60)
                                .disabled(eggBreakModel.isBroke ? true : false)
                                .opacity(eggBreakModel.isBroke ? 0.5 : 1)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(red: 201/255, green: 29/255, blue: 86/255), lineWidth: 2)
                                        .frame(width: 88, height: 60)
                                }
                                Spacer()
                            }
                            .padding(.top, 20)
                            }
                        }
                    }
                    .frame(width: 342, height: 590)
                }
            }
        }
    }
}

#Preview {
    EggBreakView()
}

