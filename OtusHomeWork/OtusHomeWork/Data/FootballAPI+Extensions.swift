//
//  Database.swift
//  OtusHomeWork
//
//  Created by Igor Kravtcov on 15.12.2020.
//

import Foundation
import Networking

extension Competition: Identifiable {}

extension Team: Identifiable {}

let authHeaderName = "X-Auth-Token"
let authToken = "4aa74b1690b84365a971a1b7286fcb2e"

extension FootballAPI {

    static func getTeamsAuthorized(
        competitionId: Int,
        dateFrom: String? = nil,
        dateTo: String? = nil,
        stage: String? = nil,
        status: String? = nil,
        matchday: Int? = nil,
        group: String? = nil,
        season: Int? = nil,
        apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue,
        completion: @escaping ((_ data: InlineResponse2001?,_ error: Error?) -> Void)
    ) {
        var builder = getMatchesWithRequestBuilder(competitionId: competitionId, dateFrom: dateFrom, dateTo: dateTo, stage: stage, status: status, matchday: matchday, group: group, season: season)
        builder = builder.addHeader(name: authHeaderName, value: authToken)
        builder.execute(apiResponseQueue) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    static func getTeamsAuthorized(
        competitionId: Int,
        stage: String? = nil,
        season: Int? = nil,
        apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue,
        completion: @escaping ((_ data: InlineResponse2002?,_ error: Error?) -> Void)
    ) {
        var builder = getTeamsWithRequestBuilder(competitionId: competitionId, stage: stage, season: season)
        builder = builder.addHeader(name: authHeaderName, value: authToken)
        builder.execute(apiResponseQueue) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}

//final class FootballAPIMock: ObservableObject {
//
//    private static let competitions: [Competition] = [
//        Competition(
//            id: 2014,
//            name: "Primera Division",
//            area: "Spain",
//            currentSeason: Season(id: 635, startDate: Date(), endDate: Date(), currentMatchday: 1)
//        ),
//        Competition(
//            id: 2019,
//            name: "Serie A",
//            area: "Italy",
//            currentSeason: Season(id: 638, startDate: Date(), endDate: Date(), currentMatchday: 1)
//        ),
//    ]
//
//    private static let teams: [Int: [Team]] = [
//        2014: [
//            Team(id: 77, name: "Athletic Club", area: "Spain", venue: "San Mamés"),
//            Team(id: 78, name: "Club Atlético de Madrid", area: "Spain", venue: "Estadio Wanda Metropolitano"),
//            Team(id: 79, name: "CA Osasuna", area: "Spain", venue: "Estadio El Sadar"),
//            Team(id: 81, name: "FC Barcelona", area: "Spain", venue: "Camp Nou"),
//            Team(id: 82, name: "Getafe CF", area: "Spain", venue: "Coliseum Alfonso Pérez"),
//            Team(id: 86, name: "Real Madrid CF", area: "Spain", venue: "Estadio Alfredo Di Stéfano"),
//            Team(id: 95, name: "Valencia CF", area: "Spain", venue: "Estadio de Mestalla"),
//        ],
//        2019: [
//            Team(id: 98, name: "AC Milan", area: "Italy", venue: "Stadio Giuseppe Meazza"),
//            Team(id: 99, name: "ACF Fiorentin", area: "Italy", venue: "Stadio Artemio Franchi"),
//            Team(id: 100, name: "AS Roma", area: "Italy", venue: "Stadio Olimpico"),
//            Team(id: 102, name: "Atalanta BC", area: "Italy", venue: "Stadio Atleti Azzurri d'Italia"),
//            Team(id: 103, name: "Bologna FC 1909", area: "Italy", venue: "Stadio Renato Dall'Ara"),
//            Team(id: 108, name: "FC Internazionale Milano", area: "Italy", venue: "Stadio Giuseppe Meazza"),
//            Team(id: 109, name: "Juventus FC", area: "Italy", venue: "Allianz Stadium"),
//        ]
//    ]
//
//    static func getCompetitions() -> [Competition] {
//        competitions
//    }
//
//    static func getTeams(for competition: Competition) -> [Team] {
//        teams.first(where: { $0.key == competition.id })?.value ?? []
//    }
//}
