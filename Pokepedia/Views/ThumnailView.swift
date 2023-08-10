import SwiftUI

struct ThumnailView: View {
    @State var pokemon: Pokemon
    var body: some View {
        VStack {
            Image("luzura")
                .resizable()
                .frame(width: 90, height: 90)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.secondary)
                }

            HStack {
                Text(pokemon.id)
                    .font(.system(size: 12))

                Text(pokemon.name)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                
            }
        
        }
    }
}

struct ThumnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumnailView(pokemon: Pokemon(id: "NO.124", name: "루주라"))
            .previewLayout(.sizeThatFits)
    }
}
