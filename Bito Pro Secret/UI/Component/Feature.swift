import SwiftUI
import Ditto

struct Feature: View {
    @State var data: [String] = ["1", "2", "3", "4", "5"]
    @State var selected: Int = 0
    @State var isNew: Bool = false
    
    let pageWidth: CGFloat = 150
    let pageHeight: CGFloat = 250
    let stepWidth: CGFloat = 150
    
    var body: some View {
        VStack {
            page(data[selected])
                .frame(width: 200)
            HStack(spacing: 5) {
                ForEach(data.indices, id: \.self) { i in
                    Circle()
                        .frame(width: 5)
                        .foregroundColor(selected == i ? .gray : .section)
                    
                }
            }
        }
        .frame(width: 200, height: 350)
    }
    
    @ViewBuilder
    private func page(_ s: String) -> some View {
        Rectangle()
            .foregroundColor(.section)
            .overlay {
                 Text(s)
            }
            .cornerRadius(7)
            .frame(width: pageWidth, height: pageHeight)
    }
    
}

struct Feature_Previews: PreviewProvider {
    static var previews: some View {
        Feature()
    }
}
