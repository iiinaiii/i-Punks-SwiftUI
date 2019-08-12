
import Foundation
import Combine
import RxSwift
import Alamofire

class BeerApiService: BeerDataSource {
    func searchBeerList(page: Int) -> Future<Array<Beer>, Error> {
        return Future<Array<Beer>, Error> { promise in
            AF.request("https://api.punkapi.com/v2/beers",
                method: .get,
                parameters: ["page": page])
                .responseDecodable { (response: DataResponse<[BeerResponse]>) in
                    switch response.result {
                    case .success(let beerResponseList):
                        let beerList = beerResponseList.map({ $0.toBeer() })
                        return promise(.success(beerList))
                    case .failure(_):
                        return promise(.failure(PunksError.apiError))
                    }
            }
        }
    }
}
