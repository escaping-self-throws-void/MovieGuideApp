//
//  SettingsViewModel.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 23/07/2022.
//

import Foundation

final class SettingsViewModel {
    
    weak var coordinator: SideMenuCoordinator?
        
    var settingsModel: SettingsUIModel?
    
    init() {
        mapModel()
    }
    
    func backToTimeline() {
        coordinator?.finish()
    }
    
    private func mapModel() {
        settingsModel = SettingsUIModel(rows: [
            .init(type: .language),
            .init(type: .notification),
            .init(type: .timeFormat),
            .init(type: .privacy)
        ])
    }
    
}
