import SwiftUI

struct PokemonListView: View {
    @State var searchingText: String = ""
    var body: some View {
        VStack {
            TextField("포켓몬 이름을 입력하세요.", text: $searchingText)
                .padding()

            Divider()

            ScrollView {
                ForEach(pokemons, id: \.id) { pokemon in
                    HStack {
                        ThumnailView(pokemon: pokemon)
                        ThumnailView(pokemon: pokemon)
                        ThumnailView(pokemon: pokemon)
                    }
                }
            }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
