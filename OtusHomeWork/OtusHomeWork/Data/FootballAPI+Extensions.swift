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
extension Match: Identifiable {}

let authHeaderName = "X-Auth-Token"
let authToken = "4aa74b1690b84365a971a1b7286fcb2e"

extension FootballAPI {

    static func getCompetitionsAuthorized(
        areas: String? = nil,
        plan: String? = nil,
        apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue,
        completion: @escaping ((_ data: InlineResponse200?,_ error: Error?) -> Void)
    ) {
        var builder = getCompetitionsWithRequestBuilder(areas: areas, plan: plan)
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

    static func getMatchesAuthorized(
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
        var builder = getMatchesWithRequestBuilder(
            competitionId: competitionId,
            dateFrom: dateFrom,
            dateTo: dateTo,
            stage: stage,
            status: status,
            matchday: matchday,
            group: group,
            season: season
        )
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
