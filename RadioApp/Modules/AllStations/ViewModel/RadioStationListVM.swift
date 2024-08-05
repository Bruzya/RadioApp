//
//  RadioStationListVM.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 30.07.2024.
//

import UIKit

class RadioStationListVM {
      var radioStation: [Station] = []
    
    var numberOfStations: Int {
//        return radioStation.count
        return radioStation.count
    }
    
    func getStations(_ link: String, complition: @escaping ()->(Void)) {
        NetworkService.shared.fetchData(from: link) { result in
            switch result {
            case .success(let data): 
                self.radioStation.append(contentsOf: data)
                complition()
            case .failure(let error):
                Swift.print("error \(error)")
            }
        }
    }
    

    
    func radioStationViewModel(at index: Int) -> RadioStationViewModel {
        return RadioStationViewModel(radioStation: radioStation[index])
    }
    
}
