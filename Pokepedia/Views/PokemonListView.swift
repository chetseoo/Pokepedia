import SwiftUI

struct PokemonListView: View {
    var body: some View {
        ScrollView{
            VStack{
                ForEach(pokemons, id: \.id) {pokemon in
                    HStack{
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
