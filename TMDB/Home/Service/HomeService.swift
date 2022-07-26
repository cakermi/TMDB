//
//  HomeService.swift
//  TMDB
//
//  Created by JUSTIKA-MAC-PROD-04 on 26/07/22.
//

import Foundation

class HomeService: HomeServiceProtocol {
    static let shared = HomeService()
    
    enum endpoints {
        case popular(String)
        case trending(String)
        
        var stringValue: String {
            switch self {
            case .popular(let token):
                return RestClient.baseURL + "/movie/popular?api_key=\(token)&language=en-US&page=1/"
            case .trending(let token):
                return RestClient.baseURL + "/movie/top_rated?api_key=\(token)&language=en-US&page=1"
            
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    func getMainMoview(token: String, completion: @escaping (MovieListResponse?, Error?) -> Void) {
        let task = RestClient.taskForGETRequest(url: endpoints.popular(token).url, responseType: MovieListResponse.self, authToken: nil) { response, error in
            guard error == nil else {
                completion(nil, error!)
                return
            }
            
            completion(response, nil)
        }
        task.resume()
    }
    
    func getTrendingMovie(token: String, completion: @escaping (MovieListResponse?, Error?) -> Void) {
        let task = RestClient.taskForGETRequest(url: endpoints.trending(token).url, responseType: MovieListResponse.self, authToken: nil) { response, error in
            guard error == nil else {
                completion(nil, error!)
                return
            }
            
            completion(response, nil)
        }
        task.resume()
    }
}
