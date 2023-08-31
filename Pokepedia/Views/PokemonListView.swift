import SwiftUI

struct PokemonListView: View {
    @State var searchingText: String = ""
    @StateObject var viewModel = testViewModel()

    var body: some View {
        VStack {
            NavigationStack {

                Divider()

                VStack(alignment: .leading) {
                    ScrollView {
                        ForEach((0..<viewModel.pokemons.count / 2).filter { "\($0)".contains(self.searchingText) || self.searchingText.isEmpty }, id: \.self) { rowIndex in
                            HStack {
                                ForEach(0..<2, id: \.self) { columnIndex in
                                    let index = rowIndex * 2 + columnIndex
                                    if index < viewModel.pokemons.count {
                                        NavigationLink(destination: PokemonInfoView(pokemon: viewModel.pokemons[index])) {
                                            ThumnailView(pokemon: viewModel.pokemons[index])
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.test()
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
