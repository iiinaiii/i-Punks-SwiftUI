import Foundation
import Combine

class BeerUseCase {
    let repository: BeerRepository

    init(repository: BeerRepository) {
        self.repository = repository
    }

    func fetchBeerList(page: Int) {
        repository.fetchBeerList(page: page)
    }

    func fetchBeerDetail(beerId: Int) {
        repository.fetchBeerDetail(beerId: beerId)
    }

    func observeBeerDetail() -> AnyPublisher<Beer, Error> {
        repository.observeBeerDetail()
    }

    func observeBeerList() -> AnyPublisher<Array<Beer>, Error> {
        repository.observeBeerList()
    }
}
