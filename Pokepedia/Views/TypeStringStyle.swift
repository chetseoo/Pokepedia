import SwiftUI

struct TypeStringStyle: View {
    @State var type: Type

    var body: some View {
        Text(type.name)
            .fontWeight(.black)
            .foregroundColor(.white)
            .padding()
            .background(type.color)
            .cornerRadius(20)
    }
}

struct TypeStringStyle_Previews: PreviewProvider {
    static var previews: some View {
        TypeStringStyle(type: .Grass)
    }
}
