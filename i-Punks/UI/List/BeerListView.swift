
import SwiftUI

struct BeerListView: View {
    @ObservedObject(initialValue: createBeerListViewModel()) var viewModel: BeerListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.beerList) { beerData in
                NavigationLink(destination: BeerDetailView(beerId: beerData.id)) {
                    BeerListRow(beer: beerData)
                }
            }.navigationBarTitle(Text("Punks"))
        }.onAppear(perform: fetch)
            .onDisappear(perform: dispose)
    }

    private func fetch() {
        viewModel.fetchBeerList(page: 1)
    }

    private func dispose() {
        viewModel.dispose()
    }
}

private func createBeerListViewModel() -> BeerListViewModel {
    return BeerListViewModel(useCase: BeerUseCase(repository: BeerRepository.shared)
    )
}

#if DEBUG
    struct BeerListView_Previews: PreviewProvider {
        static var previews: some View {
            BeerListView()
        }
    }
#endif
