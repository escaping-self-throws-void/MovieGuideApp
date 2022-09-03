//
//  ReminderMenuViewModel.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 22/07/2022.
//

import Foundation

final class ReminderMenuViewModel {

    var reminderMenuModel: ReminderMenuUIModel?
    
    init() {
        mapModel()
    }
    
    private func mapModel() {
        reminderMenuModel = ReminderMenuUIModel(rows: [
            ReminderMenuUIModel.Row(type: .watch),
            ReminderMenuUIModel.Row(type: .reminder),
            ReminderMenuUIModel.Row(type: .share)
        ])
    }

}
