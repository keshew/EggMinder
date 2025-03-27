import SwiftUI

struct EggLoginView: View {
    @StateObject var eggLoginModel = EggLoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 39/255, green: 17/255, blue: 25/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer(minLength: 10)
                        
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.button)
                                    .resizable()
                                    .frame(width: 20, height: 23)
                                    .offset(y: 3)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                            
                            Text("Log In")
                                .Paytone(size: 24, color:  Color(red: 236/255, green: 192/255, blue: 22/255))
                                .offset(x: -15)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 30)
                        
                        VStack(spacing: 20) {
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Email")
                                        .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                        .padding(.leading, 20)
                                    Spacer()
                                }
                                
                                CustomTextFiled(text: $eggLoginModel.email,
                                                geometry: geometry,
                                                placeholder: "Enter email",
                                                image: EggImageName.email.rawValue)
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Password")
                                        .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                        .padding(.leading, 20)
                                    Spacer()
                                }
                                
                                CustomSecureFiled(text: $eggLoginModel.password,
                                                  geometry: geometry,
                                                  placeholder: "Enter password",
                                                  image: EggImageName.locked.rawValue)
                            }
                        }
                        
                        Spacer(minLength: 40)
                        
                        
                        
                        Button(action: {
                            if eggLoginModel.email.isEmpty || eggLoginModel.password.isEmpty {
                                eggLoginModel.showEmptyFieldsAlert = true
                            } else {
                                let userDefaultsManager = UserDefaultsManager()
                                if userDefaultsManager.login(email: eggLoginModel.email, password: eggLoginModel.password) {
                                    eggLoginModel.isRegistered = true
                                    userDefaultsManager.saveCurrentEmail(eggLoginModel.email)
                                    
                                } else {
                                    eggLoginModel.showInvalidCredentialsAlert = true
                                }
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Log in")
                                    .Paytone(size: 16)
                                    .padding(.vertical, 16)
                                
                                Image(.egg)
                                    .resizable()
                                    .frame(width: 12, height: 16)
                                Spacer()
                            }
                        }
                        .frame(width: geometry.size.width * 0.9, height: 54)
                        .background(Color(red: 201/255, green: 29/255, blue: 86/255))
                        .cornerRadius(30)
                        .fullScreenCover(isPresented: $eggLoginModel.isRegistered) {
                            EggTabBarView()
                        }
                        
                        Color(.clear)
                            .frame(height: 20)
                    }
                }
            }
            .alert("All fields must be filled", isPresented: $eggLoginModel.showEmptyFieldsAlert) {
                Button("OK", role: .cancel) {}
            }
            .alert("Invalid email or password", isPresented: $eggLoginModel.showInvalidCredentialsAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}


#Preview {
    EggLoginView()
}

