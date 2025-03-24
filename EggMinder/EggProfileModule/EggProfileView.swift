import SwiftUI

struct EggProfileView: View {
    @StateObject var eggProfileModel =  EggProfileViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 39/255, green: 17/255, blue: 25/255)
                    .ignoresSafeArea()
                
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Profile")
                                .Paytone(size: 24)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 40)
                        
                        VStack(spacing: 5) {
                            ZStack {
                                if let image = eggProfileModel.selectedImage {
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
                                                        eggProfileModel.isImagePick = true
                                                    }) {
                                                        Image(.pick)
                                                            .resizable()
                                                            .frame(width: 32, height: 32)
                                                    }
                                                    .sheet(isPresented: $eggProfileModel.isImagePick) {
                                                        ImagePicker(image: $eggProfileModel.selectedImage, isPresented: $eggProfileModel.isImagePick)
                                                            .onDisappear {
                                                                if let image = eggProfileModel.selectedImage {
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
                                                            eggProfileModel.isImagePick = true
                                                        }) {
                                                            Image(.pick)
                                                                .resizable()
                                                                .frame(width: 32, height: 32)
                                                        }
                                                        .sheet(isPresented: $eggProfileModel.isImagePick) {
                                                            ImagePicker(image: $eggProfileModel.selectedImage, isPresented: $eggProfileModel.isImagePick)
                                                                .onDisappear {
                                                                    if let image = eggProfileModel.selectedImage {
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
                                                            eggProfileModel.isImagePick = true
                                                        }) {
                                                            Image(.pick)
                                                                .resizable()
                                                                .frame(width: 32, height: 32)
                                                        }
                                                        .sheet(isPresented: $eggProfileModel.isImagePick) {
                                                            ImagePicker(image: $eggProfileModel.selectedImage, isPresented: $eggProfileModel.isImagePick)
                                                                .onDisappear {
                                                                    if let image = eggProfileModel.selectedImage {
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
                            
                            Text("\(UserDefaultsManager().getNickname(for: UserDefaultsManager().getEmail() ?? "") ?? "Chiken")")
                                .Paytone(size: 20)
                                .padding(.top, 5)
                            
                            Text("\(UserDefaultsManager().getEmail() ?? "Chiken")")
                                .Paytone(size: 14, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                        }
                        
                        Spacer(minLength: 40)
                        
                        HStack {
                            Text("Notification Settings")
                                .Paytone(size: 14,
                                         color:  Color(red: 236/255, green: 192/255, blue: 22/255))
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        VStack(spacing: 20) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 49/255, green: 29/255, blue: 37/255))
                                    .frame(height: 56)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10)
                                    
                                
                                HStack {
                                    Image(.notif)
                                        .resizable()
                                        .frame(width: 14, height: 16)
                                        .offset(y: 1)
                                    
                                    Text("Push Notifications")
                                        .Paytone(size: 16)
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $eggProfileModel.isPush)
                                        .toggleStyle(CustomToggleStyle())
                                        .padding(.trailing, 20)
                                        .onChange(of: eggProfileModel.isPush) { newValue in
                                                if !newValue {
                                                    NotificationManager.shared.cancelAllNotifications()
                                                }
                                            }
                                }
                                .padding(.leading, 30)
                            }
                            .frame(height: 56)
                            .padding(.horizontal, 10)
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 49/255, green: 29/255, blue: 37/255))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10)
                                
                                HStack {
                                    Image(.email)
                                        .resizable()
                                        .frame(width: 14, height: 16)
                                        .offset(y: 1)
                                    
                                    Text("Email Notifications")
                                        .Paytone(size: 16)
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $eggProfileModel.isEmail)
                                        .toggleStyle(CustomToggleStyle())
                                        .padding(.trailing, 20)
                                }
                                .padding(.leading, 30)
                            }
                            .frame(height: 56)
                            .padding(.horizontal, 10)
                        }
                        
                        Spacer(minLength: 30)
                        
                        VStack(spacing: 20) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    UserDefaultsManager().logout()
                                    eggProfileModel.isLogOut = true
                                }) {
                                    Text("Log Out")
                                        .Paytone(size: 16, color: Color(red: 201/255, green: 29/255, blue: 86/255))
                                        .padding(.vertical, 20)
                                }
                                Spacer()
                            }
                            .cornerRadius(30)
                            .padding(.horizontal, 20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(red: 201/255, green: 29/255, blue: 86/255), lineWidth: 3)
                                    .padding(.horizontal, 20)
                            }
                            .fullScreenCover(isPresented: $eggProfileModel.isLogOut) {
                                EggOboardingView()
                            }
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    UserDefaultsManager().deleteAccount()
                                    eggProfileModel.isLogOut = true
                                }) {
                                    Text("Delete Account")
                                        .Paytone(size: 16, color: Color(red: 201/255, green: 29/255, blue: 86/255))
                                        .padding(.vertical, 20)
                                }
                                Spacer()
                            }
                            .cornerRadius(30)
                            .padding(.horizontal, 20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(red: 201/255, green: 29/255, blue: 86/255), lineWidth: 3)
                                    .padding(.horizontal, 20)
                            }
                            .fullScreenCover(isPresented: $eggProfileModel.isLogOut) {
                                EggOboardingView()
                            }
                        }
                        
                        Color(.clear)
                            .frame(height: 60)
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#Preview {
    EggProfileView()
}


