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
    func fetchStops() -> Observable<StopInfo>
    func decodePolyline(encodedPolyline: String) -> [LocationCoordinate2D]?
}

class TripService: TripServiceProtocol {
    
    private let BASE_URL = "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/"
    
    func fetchTrips() -> Observable<[Trip]> {
        return fetch(endpointName: "trips.json", responseType: [Trip].self)
    }
    
    func fetchStops() -> Observable<StopInfo> {
        //It should return a list but the stops.json returns just an item
        return fetch(endpointName: "stops.json", responseType: StopInfo.self)
    }
    
    func decodePolyline(encodedPolyline: String) -> [LocationCoordinate2D]? {
        return Polyline(encodedPolyline: encodedPolyline).coordinates
    }
    
    private func fetch<T: Decodable>(endpointName: String, responseType: T.Type) -> Observable<T> {
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
                    let decodedData = try JSONDecoder().decode(responseType, from: data)
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
    
}
