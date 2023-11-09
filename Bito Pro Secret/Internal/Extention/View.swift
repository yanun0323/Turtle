import SwiftUI

extension View {
    @ViewBuilder
    func scrollView(@ViewBuilder _ content: () -> some View) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            content()
        }.padding(.bottom)
    }
    
    @ViewBuilder
    func section(_ title: String, font: Font = .title3, spacing: CGFloat = 10 , @ViewBuilder _ content: () -> some View) -> some View {
        VStack (alignment: .leading, spacing: 5) {
            if title.count != 0 {
                Text(title)
                    .font(font)
                    .foregroundColor(.primaryHalf)
                    .padding(.leading, 5)
            }
            HStack(spacing: 0) {
                Spacer()
                VStack(spacing: spacing) {
                    content()
                }
                Spacer()
            }
            .padding(.vertical)
            .padding(.horizontal, 5)
            .background(Color.section.opacity(0.5))
            .cornerRadius(7)
        }
    }
}
