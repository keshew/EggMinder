import SwiftUI

struct TimeTF: View {
    @Binding var time: Date
    var geometry: GeometryProxy

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 61/255, green: 41/255, blue: 48/255))
                    .frame(width: geometry.size.width * 0.38, height: geometry.size.height * 0.07)
                    .cornerRadius(9)
                    .overlay(
                        RoundedRectangle(cornerRadius: 9)
                            .stroke(.gray, lineWidth: 0.5)
                    )
                
                DatePicker(
                    "Time",
                    selection: $time,
                    in: Date()...,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.compact)
                .frame(width: geometry.size.width * 0.38, height: geometry.size.height * 0.07)
            }
            .labelsHidden()
        }
    }
}

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var image: String
    var isImage = true
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 61/255, green: 41/255, blue: 48/255))
                .frame(height: 56)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 0.5)
                        .padding(.horizontal, 20)
                }
                
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .padding(.horizontal, 16)
            .frame(height: geometry.size.height * 0.07)
            .font(.custom("Paytone-Regular", size: 20))
            .cornerRadius(9)
            .foregroundStyle(.white)
            .focused($isTextFocused)
            .padding(.horizontal, 20)
            
            if text.isEmpty && !isTextFocused {
                HStack(spacing: 20) {
                    if isImage {
                        Image(image)
                            .resizable()
                            .frame(width: image == "email" ? 16: 14, height: 16)
                    }
                    Text(placeholder)
                        .Paytone(size: 16, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                }
                .padding(.leading, 35)
                .onTapGesture {
                    isTextFocused = true
                }
                
            }
        }
    }
}

struct CustomSecureFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var image: String
    var isImage = true
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 61/255, green: 41/255, blue: 48/255))
                .frame(height: 56)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 0.5)
                        .padding(.horizontal, 20)
                }
                
            
            SecureField("", text: $text)
            .padding(.horizontal, 16)
            .frame(height: geometry.size.height * 0.07)
            .font(.custom("Paytone-Regular", size: 20))
            .cornerRadius(9)
            .foregroundStyle(.white)
            .focused($isTextFocused)
            .padding(.horizontal, 20)
            
            if text.isEmpty && !isTextFocused {
                HStack(spacing: 20) {
                    if isImage {
                        Image(image)
                            .resizable()
                            .frame(width: image == "email" ? 16: 14, height: 16)
                    }
                    Text(placeholder)
                        .Paytone(size: 16, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                }
                .padding(.leading, 35)
                .onTapGesture {
                    isTextFocused = true
                }
                
            }
        }
    }
}

struct DateTF: View {
    @Binding var date: Date
    var geometry: GeometryProxy

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 61/255, green: 41/255, blue: 48/255))
                    .frame(width: geometry.size.width * 0.48, height: geometry.size.height * 0.07)
                    .cornerRadius(9)
                    .overlay(
                        RoundedRectangle(cornerRadius: 9)
                            .stroke(.gray, lineWidth: 0.5)
                    )
                
                DatePicker(
                    "Date",
                    selection: $date,
                    in: Date()...,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .frame(width: geometry.size.width * 0.48, height: geometry.size.height * 0.07)
            }
            .labelsHidden()
        }
    }
}


struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 201/255, green: 29/255, blue: 86/255) : Color(red: 84/255, green: 88/255, blue: 91/255))
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(.white)
                        .frame(width: 20, height: 20)
                        .offset(x: configuration.isOn ? 8 : -8)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        if !isPresented {
            uiViewController.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Home
        case History
        case Profile
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 39/255, green: 17/255, blue: 25/255)
                .frame(height: 100)
                .edgesIgnoringSafeArea(.bottom)
                .offset(y: 35)
                .overlay(
                       Rectangle()
                        .fill(Color(red: 200/255, green: 29/255, blue: 86/225))
                        .frame(height: 0.4)
                        .opacity(0.4)
                        .offset(y: -14)
                   )
            
            HStack(spacing: 0) {
                TabBarItem(imageName: "tab1", tab: .Home, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .History, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Profile, selectedTab: $selectedTab)
            }
            .padding(.top, 5)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 8) {
                Image(selectedTab == tab ? imageName + "Picked" : imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .opacity(selectedTab == tab ? 1 : 0.4)
                
                Text("\(tab)")
                    .Paytone(size: 12, color: selectedTab == tab ? Color(red: 255/255, green: 188/255, blue: 6/255) : Color(red: 133/255, green: 133/255, blue: 133/255))
            }
            .frame(maxWidth: .infinity)
        }
    }
}
