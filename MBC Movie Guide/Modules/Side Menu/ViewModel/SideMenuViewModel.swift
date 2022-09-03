//
//  SideMenuViewModel.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 19/07/2022.
//

import Foundation

final class SideMenuViewModel {
    
    weak var coordinator: SideMenuCoordinator?
    
    var sideMenuModel: SideMenu?
    
    init() {
        mapModel()
    }
    
    func backToTimeline() {
        coordinator?.finish()
    }
    
    func goToLanding() {
        coordinator?.startLanding()
        coordinator?.finish()
    }
    
    func goToSettings() {
        coordinator?.startSettings()
    }
    
    private func mapModel() {
        sideMenuModel = SideMenu(section: [
            SideMenu.Section(rows: [
                SideMenu.Row(type: .userInfo, rowType: .account)
            ]),
            SideMenu.Section(rows: [
                SideMenu.Row(type: .settings, rowType: .timeline),
                SideMenu.Row(type: .settings, rowType: .genres),
                SideMenu.Row(type: .settings, rowType: .watchlist),
                SideMenu.Row(type: .settings, rowType: .quiz)
            ]),
            SideMenu.Section(rows: [
                SideMenu.Row(type: .settings, rowType: .settings),
                SideMenu.Row(type: .settings, rowType: .logout)
            ])
        ])
    }
}
