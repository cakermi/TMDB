//
//  RestClient.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 25/07/22.
//

import Foundation

class RestClient {
    static let baseURL: String = "https://api.themoviedb.org/3"
    static let API_KEY = "dfe7bab465ffa1a7594cb3ec9706db8a"
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, authToken: String?, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // check token is have data
        if let authToken = authToken{
            request.setValue("token \(authToken)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let response = response as? HTTPURLResponse
            if response != nil {
                print("GET \(response!.statusCode) -- \(url.absoluteString)")
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    
                    completion(nil, error)
                }
            }
        }
        task.resume()
        
        return task
    }

}
