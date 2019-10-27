
import Foundation

class NetworkService {
    
//    Configure request based on url request and query items 
    func request(serachterm: String, complition: @escaping (Data?, Error?) -> Void ) {
        let parameters = self.prepareParameters(searchTerm: serachterm)
        let url = self.url(params: parameters)
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        let task = self.createDataTask(from: request, complition: complition)
        task.resume()
    }
    
//    Configurate Google Books API quary items
    private func prepareParameters(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["q"] = searchTerm
        print(parameters)
        return parameters
    }
    
//    Create Google Books API link
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = params.map{
            URLQueryItem(name: $0, value: $1)
        }
        return components.url!
    }
    
//    Create URL session to get JSON
    private func createDataTask(from request: URLRequest, complition: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, responce, error) in
            DispatchQueue.main.async {
                complition(data, error)
            }
        })
    }
    
}
