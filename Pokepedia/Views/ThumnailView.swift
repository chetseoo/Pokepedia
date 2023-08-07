import SwiftUI

struct ThumnailView: View {
    @State var pokemon: Pokemon
    var body: some View {
        VStack {
            Image("luzura")
                .resizable()
                .frame(width: 120, height: 120)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.secondary)
                }

            HStack {
                Text("N0.\(pokemon.id)")
                    .font(.system(size: 15))

                Text(pokemon.name)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
            }
        }
    }
}

struct ThumnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumnailView(pokemon: Pokemon(id: 124, name: "루주라"))
            .previewLayout(.sizeThatFits)
    }
}
