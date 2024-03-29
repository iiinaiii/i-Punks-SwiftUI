
import Foundation
import SwiftUI
import Combine

final class BeerListViewModel: ObservableObject {
    let useCase: BeerUseCase

    private var canceller: Cancellable? = nil

    @Published var loadState: LoadState = LoadState.preload
    @Published var beerList: Array<Beer> = []

    init(useCase: BeerUseCase) {
        self.useCase = useCase
        canceller = self.useCase.observeBeerList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { result in
                    self.loadState = LoadState.complete
                    self.beerList = result
                })
    }

    func fetchBeerList(page: Int) {
        loadState = LoadState.loading
        useCase.fetchBeerList(page: page)
    }

    func dispose() {
        canceller?.cancel()
        canceller = nil
    }
}
