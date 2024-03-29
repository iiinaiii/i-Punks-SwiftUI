import Foundation
import Combine

class BeerRepository {
    static let shared = BeerRepository()

    private init() {
        dataSource = BeerApiService()
    }

    let dataSource: BeerDataSource

    private var canceller: Cancellable? = nil

    private var beerCache: [Int: Beer] = [:]
    private let beerListSubject = PassthroughSubject<Array<Beer>, Error>()
    private let beerDetailSubject = PassthroughSubject<Beer, Error>()
    private let backgroundQueue: DispatchQueue = DispatchQueue(label: "backgroundQueue")

    init(dataSource: BeerDataSource) {
        self.dataSource = dataSource
    }

    func fetchBeerList(page: Int) {
        canceller = dataSource.searchBeerList(page: page)
            .subscribe(on: backgroundQueue)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { value in
                    self.cache(beerList: value)
                    self.beerListSubject.send(value)
                })
    }

    func fetchBeerDetail(beerId: Int) {
        if let beer = beerCache[beerId] {
            beerDetailSubject.send(beer)
        } else {
            beerDetailSubject.send(completion: .failure(PunksError.detailError))
        }
    }

    func observeBeerList() -> AnyPublisher<Array<Beer>, Error> {
        return beerListSubject.eraseToAnyPublisher()
    }

    func observeBeerDetail() -> AnyPublisher<Beer, Error> {
        return beerDetailSubject.eraseToAnyPublisher()
    }

    private func cache(beerList: Array<Beer>) {
        beerList.forEach { beer in
            self.beerCache[beer.id] = beer
        }
    }
}
