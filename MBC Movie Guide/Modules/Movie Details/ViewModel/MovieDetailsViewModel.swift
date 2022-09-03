//
//  MovieDetailsViewModel.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 20/07/2022.
//

import Foundation
import RxSwift

final class MovieDetailsViewModel {
    
    // MARK: - RX Vars
    let hasLoaded: PublishSubject<Bool> = PublishSubject()
    private let movieId: String
    
    // MARK: - Vars
    var movieToShare: MovieToShare?
    
    var movieUIModel: MovieDetailsUIModel? {
        didSet {
            hasLoaded.onNext(true)
        }
    }
    
    private var movieDetail: MovieDetail? {
        didSet {
            mapModel()
        }
    }
    
    private let apiService: APIService
    
    init(service: APIService, id: String) {
        apiService = service
        movieId = id
    }
    
    func getMovieDetail() {
        apiService.fetchDetail(for: movieId) { [weak self] result in
            switch result {
            case .success(let fetchedData):
                self?.movieDetail = fetchedData
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func mapModel() {
        movieUIModel = movieDetail.map { md in
            MovieDetailsUIModel(sections: [
                MovieDetailsUIModel.Section(type: .synopsis, rows: [
                    .init(text: md.synopsisEn, textAr: md.synopsisAr, type: .synopsis)
                ]),
                MovieDetailsUIModel.Section(type: .cast, rows:
//                    md.actors.map { MovieDetailsUIModel.Row(text: $0.name, image: $0.image, type: .cast) }
                                            [.init(text: "Brad Pitt", type: .cast),
                                             .init(text: "Jeniffer Lawrance", type: .cast),
                                             .init(text: "Emma Stone", type: .cast),
                                             .init(text: "Lady Gaga", type: .cast),
                                             .init(text: "Robert De Niro", type: .cast),
                                             .init(text: "Jack Nicholson", type: .cast),
                                             .init(text: "Marlon Brando", type: .cast),
                                             .init(text: "Denzel Washington", type: .cast),
                                             .init(text: "Katharine Hepburn", type: .cast),
                                             .init(text: "Meryl Streep", type: .cast),
                                            ]
                ),
                MovieDetailsUIModel.Section(type: .directors, rows:
//                    md.directors.map { MovieDetailsUIModel.Row(text: $0.name, type: .directors) }
                                            [.init(text: "Lorene Scarfia", type: .directors),
                                             .init(text: "Martin Scorsese", type: .directors),
                                             .init(text: "Akira Kurosawa", type: .directors),
                                             .init(text: "Alfred Hitchcock", type: .directors),
                                             .init(text: "Avi Langarde", type: .directors),
                                             .init(text: "Orson Welles", type: .directors),
                                             .init(text: "Howard Hawks", type: .directors),
                                             .init(text: "Buster Keaton", type: .directors),
                                             .init(text: "Paul Rudd", type: .directors),
                                            ]
                ),
                MovieDetailsUIModel.Section(type: .genres, rows:
//                    md.genres.map { MovieDetailsUIModel.Row(text: $0.nameEn, type: .genres) }
                                            [.init(text: "Action", type: .genres),
                                             .init(text: "Horror", type: .genres),
                                             .init(text: "Western", type: .genres),
                                             .init(text: "Thriller", type: .genres),
                                             .init(text: "Drama", type: .genres),
                                             .init(text: "Romance", type: .genres),
                                             .init(text: "Comedy", type: .genres),
                                             .init(text: "Fantasy", type: .genres),
                                             .init(text: "Fiction", type: .genres),
                                             .init(text: "Animation", type: .genres),
                                            ]
                                           ),
            ],
            header: MovieDetailsUIModel.Header(poster: md.poster, channel: md.channel, titleEn: md.titleEn, titleAr: md.titleAr, date: md.date, duration: md.duration, movieRelease: md.movieRelease))
        }
    }

}
