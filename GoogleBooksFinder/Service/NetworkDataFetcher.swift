

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
//    Trying to get data and decode JSON
    func fetchImagies(searchTerms: String, complition: @escaping (BooksData?) ->()) {
        networkService.request(serachterm: searchTerms) { (data, error) in
            
            guard let data = data else { return }
            
            do {
                let booksData = try JSONDecoder().decode(BooksData.self, from: data)
                complition(booksData)
            }catch {
                
            }
            
        }
    }
    
}
