import SwiftUI

struct EggCreateAccountView: View {
    @StateObject var eggCreateAccountModel = EggCreateAccountViewModel()
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
                            
                            Text("Create Account")
                                .Paytone(size: 24, color:  Color(red: 236/255, green: 192/255, blue: 22/255))
                                .offset(x: -15)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 40)
                        
                        ZStack {
                            if let image = eggCreateAccountModel.selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 139, height: 137)
                                    .cornerRadius(139 / 2)
                                    .overlay {
                                        VStack {
                                            Spacer()
                                            
                                            HStack {
                                                Spacer()
                                                Button(action: {
                                                    eggCreateAccountModel.isImagePick = true
                                                }) {
                                                    Image(.pick)
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                }
                                                .sheet(isPresented: $eggCreateAccountModel.isImagePick) {
                                                    ImagePicker(image: $eggCreateAccountModel.selectedImage, isPresented: $eggCreateAccountModel.isImagePick)
                                                        .onDisappear {
                                                            if let image = eggCreateAccountModel.selectedImage {
                                                                UserDefaultsManager().saveProfileImage(image)
                                                            }
                                                        }
                                                }
                                            }
                                        }
                                    }
                            } else {
                                if let loadedImage = UserDefaultsManager().loadProfileImage() {
                                    Image(uiImage: loadedImage)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.346, height: geometry.size.height * 0.176)
                                        .cornerRadius(geometry.size.width * 0.346 / 2)
                                        .overlay {
                                            VStack {
                                                Spacer()
                                                
                                                HStack {
                                                    Spacer()
                                                    Button(action: {
                                                        eggCreateAccountModel.isImagePick = true
                                                    }) {
                                                        Image(.pick)
                                                            .resizable()
                                                            .frame(width: 32, height: 32)
                                                    }
                                                    .sheet(isPresented: $eggCreateAccountModel.isImagePick) {
                                                        ImagePicker(image: $eggCreateAccountModel.selectedImage, isPresented: $eggCreateAccountModel.isImagePick)
                                                            .onDisappear {
                                                                if let image = eggCreateAccountModel.selectedImage {
                                                                    UserDefaultsManager().saveProfileImage(image)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                        }
                                } else {
                                    Image(.chikenAva)
                                        .resizable()
                                        .frame(width: 96, height: 96)
                                        .overlay {
                                            VStack {
                                                Spacer()
                                                
                                                HStack {
                                                    Spacer()
                                                    Button(action: {
                                                        eggCreateAccountModel.isImagePick = true
                                                    }) {
                                                        Image(.pick)
                                                            .resizable()
                                                            .frame(width: 32, height: 32)
                                                    }
                                                    .sheet(isPresented: $eggCreateAccountModel.isImagePick) {
                                                        ImagePicker(image: $eggCreateAccountModel.selectedImage, isPresented: $eggCreateAccountModel.isImagePick)
                                                            .onDisappear {
                                                                if let image = eggCreateAccountModel.selectedImage {
                                                                    UserDefaultsManager().saveProfileImage(image)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                        }
                                }
                            }
                        }
                        
                        Spacer(minLength: 40)
                        
                        VStack(spacing: 20) {
                            VStack(spacing: 10) {
                                HStack {
                                    Text("UserName")
                                        .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                        .padding(.leading, 20)
                                    Spacer()
                                }
                                
                                CustomTextFiled(text: $eggCreateAccountModel.username,
                                                geometry: geometry,
                                                placeholder: "Enter username",
                                                image: EggImageName.profile.rawValue)
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Email")
                                        .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                        .padding(.leading, 20)
                                    Spacer()
                                }
                                
                                CustomTextFiled(text: $eggCreateAccountModel.email,
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
                                
                                CustomSecureFiled(text: $eggCreateAccountModel.password,
                                                  geometry: geometry,
                                                  placeholder: "Create password",
                                                  image: EggImageName.locked.rawValue)
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Confirm Password")
                                        .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                                        .padding(.leading, 20)
                                    Spacer()
                                }
                                
                                CustomSecureFiled(text: $eggCreateAccountModel.secondPassword,
                                                  geometry: geometry,
                                                  placeholder: "Confirm password",
                                                  image: EggImageName.locked.rawValue)
                            }
                        }
                        
                        Spacer(minLength: 60)
                        
                        Button(action: {
                            if eggCreateAccountModel.username.isEmpty || eggCreateAccountModel.email.isEmpty || eggCreateAccountModel.password.isEmpty || eggCreateAccountModel.secondPassword.isEmpty {
                                eggCreateAccountModel.showEmptyFieldsAlert = true
                            } else if eggCreateAccountModel.password != eggCreateAccountModel.secondPassword {
                                eggCreateAccountModel.showPasswordsMismatchAlert = true
                            } else {
                                let userDefaultsManager = UserDefaultsManager()
                                if userDefaultsManager.register(email: eggCreateAccountModel.email, password: eggCreateAccountModel.password, nickname: eggCreateAccountModel.username) {
                                    eggCreateAccountModel.isReg = true
                                }
                            }
                        }) {
                            HStack {
                                Spacer()
                                
                                Text("Create Account")
                                    .Paytone(size: 16)
                                    .padding(.vertical, 16)
                                
                                Image(.egg)
                                    .resizable()
                                    .frame(width: 12, height: 16)
                                
                                Spacer()
                            }
                        }
                        .background(Color(red: 201/255, green: 29/255, blue: 86/255))
                        .cornerRadius(30)
                        .padding(.horizontal, 20)
                        .fullScreenCover(isPresented: $eggCreateAccountModel.isReg) {
                            EggLoginView()
                        }
                        
                        Color(.clear)
                            .frame(height: 20)
                    }
                }
            }
            .alert("All fields must be filled", isPresented: $eggCreateAccountModel.showEmptyFieldsAlert) {
                Button("OK", role: .cancel) {}
            }
            .alert("Passwords do not match", isPresented: $eggCreateAccountModel.showPasswordsMismatchAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}


#Preview {
    EggCreateAccountView()
}


