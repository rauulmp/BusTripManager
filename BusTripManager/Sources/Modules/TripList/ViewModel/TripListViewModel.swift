//
//  TripListViewModel.swift
//  BusTripManager
//
//  Created by Raul Montoya Perez on 20/6/24.
//

import Foundation
import RxSwift

class TripListViewModel : ObservableObject {
    
    private let tripService: TripServiceProtocol
    private let disposeBag = DisposeBag()
    
    @Published var trips: [Trip] = []
    @Published var errorMessage: String?
    
    init(tripService: TripServiceProtocol) {
        self.tripService = tripService
    }
    
    func fetchTrips() {
        tripService.fetchTrips()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] trips in
                    self?.trips = trips
                },
                onError: { [weak self] error in
                    self?.errorMessage = error.localizedDescription
                }
            )
            .disposed(by: disposeBag)
    }
}
