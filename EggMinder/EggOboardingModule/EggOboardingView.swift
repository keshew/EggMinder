import SwiftUI

struct EggOboardingView: View {
    @StateObject var eggOboardingModel =  EggOboardingViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 39/255, green: 17/255, blue: 25/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer(minLength: 10)
                        
                        Text("EggMinder")
                            .Paytone(size: 30, color:  Color(red: 236/255, green: 192/255, blue: 22/255))
                        
                        Spacer(minLength: 30)
                        
                        Image(.chicken)
                            .resizable()
                            .frame(width: 203, height: 231)
                        
                        Spacer(minLength: 40)
                        
                        Text("Create reminders that\nyour chicken will lay for\nyou!")
                            .Paytone(size: 24)
                            .multilineTextAlignment(.center)
                        
                        Spacer(minLength: 15)
                        
                        Text("Create tasks, and the chicken will lay\nthem as eggs. To complete a task, break\nthe egg!")
                            .Paytone(size: 14)
                            .multilineTextAlignment(.center)
                        
                        Spacer(minLength: 30)
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                eggOboardingModel.isCreating = true
                            }) {
                                Text("Create Account")
                                    .Paytone(size: 16)
                                    .padding(.vertical, 16)
                            }
                            Spacer()
                        }
                        .background(Color(red: 201/255, green: 29/255, blue: 86/255))
                        .cornerRadius(30)
                        .padding(.horizontal, 40)
                        .fullScreenCover(isPresented: $eggOboardingModel.isCreating) {
                            EggCreateAccountView()
                        }
                        
                        Spacer(minLength: 20)
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                eggOboardingModel.isLogin = true
                            }) {
                                Text("Log In")
                                    .Paytone(size: 16, color: Color(red: 201/255, green: 29/255, blue: 86/255))
                                    .padding(.vertical, 16)
                            }
                            Spacer()
                        }
                        .cornerRadius(30)
                        .padding(.horizontal, 40)
                        .overlay {
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 201/255, green: 29/255, blue: 86/255), lineWidth: 3)
                                .padding(.horizontal, 40)
                        }
                        .fullScreenCover(isPresented: $eggOboardingModel.isLogin) {
                            EggLoginView()
                        }
                        
                        Spacer(minLength: 20)
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                eggOboardingModel.isGuest = true
                                UserDefaultsManager().enterAsGuest()
                            }) {
                                Text("Enter as Guest")
                                    .Paytone(size: 16, color: Color(red: 201/255, green: 29/255, blue: 86/255))
                                    .padding(.vertical, 16)
                            }
                            Spacer()
                        }
                        .cornerRadius(30)
                        .padding(.horizontal, 40)
                        .overlay {
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 201/255, green: 29/255, blue: 86/255), lineWidth: 3)
                                .padding(.horizontal, 40)
                        }
                        .fullScreenCover(isPresented: $eggOboardingModel.isGuest) {
                            EggTabBarView()
                        }
                        
                        Color(.clear)
                            .frame(height: 20)
                    }
                }
            }
        }
    }
}

#Preview {
    EggOboardingView()
}

