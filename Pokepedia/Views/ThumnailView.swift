import SwiftUI

struct ThumnailView: View {
    @State var pokemon: Pokemon

    var body: some View {
        VStack {
            if let image = pokemon.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.secondary, lineWidth: 2)
                    }
            }

            HStack {
                Text(pokemon.id)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)

                Text(pokemon.korName)
                    .font(.system(size: 17))
                    .fontWeight(.bold)
            }

            HStack {
                ForEach(pokemon.type, id: \.self) { type in
                    TypeStringStyle(type: type)
                }
            }

            Text(pokemon.appearance)
                .font(.system(size: 14))
                .fontWeight(.semibold)
        }
        .padding()
        .cornerRadius(15)
        .border(.black)
    }
}

struct ThumnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumnailView(pokemon: Pokemon(id: "NO.124", korName: "루주라", image: nil, appearance: "거다이맥스의 모습", type: []))
            .previewLayout(.sizeThatFits)
    }
}
