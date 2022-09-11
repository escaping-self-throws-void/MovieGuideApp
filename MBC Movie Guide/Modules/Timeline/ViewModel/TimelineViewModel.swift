//
//  TimelineViewModel.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 13/07/2022.
//

import Foundation
import RxSwift

protocol TimelineViewModelProtocol {
    var changed: BehaviorSubject<Bool> { get }
    var selectedDate: BehaviorSubject<Date> { get }
    var selectedRow: Int { get set }
    var indexPathsForAvailableNow: [IndexPath] { get }
    
    func createDays(_ number: Int, from date: Date) -> [Date]
    func getMovieData(from date: Date)
    func getNumberOfSections() -> Int
    func getNumberOfItems(in section: Int) -> Int
    func getModel(for indexPath: IndexPath) -> MovieItem
    
    func goToSideMenu(_ delegate: SideMenuDelegate?)
}


final class TimelineViewModel: TimelineViewModelProtocol {
    
    weak var coordinator: TimelineCoordinator?
    
    var indexPathsForAvailableNow: [IndexPath] = []
    
    var changed = BehaviorSubject<Bool>(value: false)
    
    // Adjustment for Mock data
    var selectedDate = BehaviorSubject<Date>(value: "2022-09-11T15:00:00.000Z".getDate)
//    var selectedDate = BehaviorSubject<Date>(value: Date())
    
    var selectedRow: Int = 0
    
    private var movieData: [MovieData] = [] {
        didSet {
            getIndexPathsForCurrentMovies()
            changed.onNext(true)
        }
    }

    private let apiService: APIService
    
    init(service: APIService) {
        apiService = service
    }
    
    func getModel(for indexPath: IndexPath) -> MovieItem {
        movieData[indexPath.section].movies[indexPath.item]
    }
    
    func getNumberOfSections() -> Int {
        movieData.count
    }
    
    func getNumberOfItems(in section: Int) -> Int {
        movieData[section].movies.count
    }
    
    func getMovieData(from date: Date) {
        let dateString = date.apiText
        
        apiService.fetchMovies(on: dateString) { [weak self] result in
            switch result {
            case .success(let fetchedData):
                self?.movieData = fetchedData
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createDays(_ number: Int, from date: Date) -> [Date] {
        var tempDate = date
        var days = [tempDate]
        
        for _ in 1..<number {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate) ?? Date()
            days.append(tempDate)
        }
        return days
    }
    
    func goToSideMenu(_ delegate: SideMenuDelegate?) {
        coordinator?.startSideMenu(delegate)
    }
    
    private func getIndexPathsForCurrentMovies() {
        var indexPaths: [IndexPath] = []
        
        let locAdjustment = LanguageService.shared.isEn ? 1 : 0
        
        movieData.forEach { md in
            // Adjustment for mock data
            if let row = md.movies.firstIndex(where: {
                $0.date == "2022-09-11T15:00:00.000Z" ||
                $0.date ==  "2022-09-11T16:00:00.000Z"
            }),
//            if let row = md.movies.firstIndex(where: { $0.date.getDate.isAvailableNow }),
            let section = movieData.firstIndex(where: { $0.id == md.id }) {
                let indexPath = IndexPath(row: row + locAdjustment, section: section)
                indexPaths.append(indexPath)
            }
        }
        
        indexPathsForAvailableNow = indexPaths
    }
}
