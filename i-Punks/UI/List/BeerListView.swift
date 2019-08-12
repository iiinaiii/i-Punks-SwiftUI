
import SwiftUI

struct BeerListView: View {
    @ObservedObject(initialValue: createBeerListViewModel()) var viewModel: BeerListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.beerList) { beerData in
                BeerListRow(beer: beerData)
            }
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
    return BeerListViewModel(useCase: BeerUseCase(repository: BeerRepository(dataSource: BeerApiService()))
    )
}

#if DEBUG
    struct BeerListView_Previews: PreviewProvider {
        static var previews: some View {
            BeerListView()
        }
    }
#endif
