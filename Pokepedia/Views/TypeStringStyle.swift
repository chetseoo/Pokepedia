import SwiftUI

struct TypeStringStyle: View {
    @State var type: String
    
    var body: some View {
        Text(type)
            .fontWeight(.black)
            .padding()
            .background(Color.yellow)
            .cornerRadius(20)
    }
}

struct TypeStringStyle_Previews: PreviewProvider {
    static var previews: some View {
        TypeStringStyle(type: "zzzzzzz")
    }
}
