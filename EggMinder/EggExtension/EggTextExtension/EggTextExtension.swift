import SwiftUI

extension Text {
    func Paytone(size: CGFloat,
                 color: Color = .white) -> some View {
        self.font(.custom("PaytoneOne-Regular", size: size))
            .foregroundColor(color)
    }
}
