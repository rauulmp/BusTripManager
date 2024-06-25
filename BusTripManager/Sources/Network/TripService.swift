//
//  TripService.swift
//  BusTripManager
//
//  Created by Raul Montoya Perez on 20/6/24.
//

import Foundation
import RxSwift
import Polyline

protocol TripServiceProtocol {
    func fetchTrips() -> Observable<[Trip]>
    func decodePolyline(encodedPolyline: String) -> [LocationCoordinate2D]?
}

class TripService: TripServiceProtocol {
    
    private let BASE_URL = "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/"
    
    func fetchTrips() -> Observable<[Trip]> {
        return fetch(endpointName: "trips.json")
    }
    
    func decodePolyline(encodedPolyline: String) -> [LocationCoordinate2D]? {
        return Polyline(encodedPolyline: encodedPolyline).coordinates
    }
    
    private func fetch<T: Decodable>(endpointName: String) -> Observable<[T]> {
        return Observable.create { observer in
            guard let url = URL(string: "\(self.BASE_URL)\(endpointName)") else {
                observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode([T].self, from: data)
                    observer.onNext(decodedData)
                    observer.onCompleted()
                }
                catch {
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    
    
    
    /*
    func fetchCommerces() async throws -> [Commerce] {
        guard let url = URL(string: "\(BASE_URL)commerces.json") else {
            throw NetworkError.invalidURL
        }
            
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
                
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
                
            guard httpResponse.statusCode == 200 else {
                throw NetworkError.invalidStatusCode(httpResponse.statusCode)
            }
            
            guard let commerces = try? JSONDecoder().decode([Commerce].self, from: data) else {
                throw NetworkError.decodeFailed
            }
            return commerces
        }
        catch {
            throw NetworkError.requestFailed(error)
        }
    }*/
}
