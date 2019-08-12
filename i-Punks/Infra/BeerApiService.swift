
import Foundation
import Combine
import RxSwift
import Alamofire

class BeerApiService: BeerDataSource {
    func searchBeerList(page: Int) -> Future<Array<Beer>, Error> {
        debugPrint("api: searchBeerList")
        return Future<Array<Beer>, Error> { promise in
            AF.request("https://api.punkapi.com/v2/beers",
                method: .get,
                parameters: ["page": page])
                .responseDecodable { (response: DataResponse<[BeerResponse]>) in
                    switch response.result {
                    case .success(let beerResponseList):
                        let beerList = beerResponseList.map({ $0.toBeer() })
                        debugPrint("api : success")
                        return promise(.success(beerList))
                    case .failure(_):
                        debugPrint("api : error")
                        return promise(.failure(PunksError.apiError))
                    }
            }
        }
    }
}
