//
//  RequestClient.swift
//  NetworkLIB
//
//  Created by Raphael Henrique on 30/01/20.
//  Copyright © 2020 TBD-patrichel. All rights reserved.
//

import Foundation

public typealias RequestResult = (_ data: Data?, _ response: URLResponse? ,_ error: Error? ) -> Void

public class RequestLib {
    
    public static var client = RequestLib()

//    let config = URLSessionConfiguration.default
//    config.httpAdditionalHeaders = ["User-Agent":"Legit Safari", "Authorization" : "Bearer key1234567"]
//    config.timeoutIntervalForRequest = 30
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    public func request(url: String, completionHandler: @escaping RequestResult) {
        
        dataTask?.cancel()
        
        if let url = URL(string: url) {
            
            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in
                
                completionHandler(data,response,error)
                
            })
            dataTask?.resume()
        }
    }
    
    public func request(searchTerm: String) {
        // 1
        dataTask?.cancel()
            
        // 2
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
          urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
          // 3
          guard let url = urlComponents.url else {
            return
          }
          // 4
          dataTask =
            defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
              self?.dataTask = nil
            }
            // 5
            if let error = error {
            
                print("DataTask error: " + error.localizedDescription + "\n")
                
            } else if
              let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode == 200 {
                print(data)
                print("SUCCESSSSSSSS")
                
              // self?.updateSearchResults(data)
              // 6
//              DispatchQueue.main.async {
//                completion(self?.tracks, self?.errorMessage ?? "")
//              }
                
            }
          }
          // 7
          dataTask?.resume()
        }

    }
    
    
    
}
