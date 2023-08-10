import SwiftUI

struct ThumnailView: View {
    @State var pokemon: Pokemon

    var body: some View {
        VStack {
            if let image = pokemon.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 130, height: 130)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.secondary)
                    }
            }

            HStack {
                Text(pokemon.id)
                    .font(.system(size: 14))

                Text(pokemon.name)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
            }
        }
    }
}

struct ThumnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumnailView(pokemon: Pokemon(id: "NO.124", name: "루주라", image: nil))
            .previewLayout(.sizeThatFits)
    }
}
