//
//  NetworkDataFetcher.swift
//  AudioPlayer
//
//  Created by Леся on 28.06.2021.
//

import Foundation

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetchTracks(urlString: String, responce: @escaping (SearchResponse?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(SearchResponse.self, from: data)
                    responce(tracks)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    responce(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                responce(nil)
            }
        }
    }
}
