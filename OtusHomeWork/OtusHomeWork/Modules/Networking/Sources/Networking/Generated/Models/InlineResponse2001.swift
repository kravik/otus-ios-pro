//
// InlineResponse2001.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct InlineResponse2001: Codable {

    public var count: Int?
    public var matches: [Match]?
    public var competition: Competition?

    public init(count: Int? = nil, matches: [Match]? = nil, competition: Competition? = nil) {
        self.count = count
        self.matches = matches
        self.competition = competition
    }

}

