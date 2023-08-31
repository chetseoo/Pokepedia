import SwiftUI

struct ListView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.pokemons, id: \.self) { pokemon in
                    ThumnailView(pokemon: pokemon)
                }
            }
        }
        .onAppear {
            viewModel.parsing()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
