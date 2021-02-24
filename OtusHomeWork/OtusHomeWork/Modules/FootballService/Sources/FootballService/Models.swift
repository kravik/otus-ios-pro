import Foundation

public struct Competition: Identifiable {
    public enum Plan {
        case free
    }

    public var id: Int
    public var name: String
    public var lastUpdated: Date
    public var plan: Plan
    public var area: Area?
    public var currentSeason: Season?
}

public struct Team: Identifiable {
    public var id: Int
    public var name: String
}

public struct Area {
    public var id: Int
    public var name: String
    public var countryCode: String?
}

public struct Match: Identifiable {
    public var id: Int
    public var season: Season
    public var utcDate: Date
    public var status: String
    public var matchday: Int?
    public var stage: String?
    public var group: String?
    public var lastUpdated: Date?
    public var homeTeam: Team?
    public var awayTeam: Team?
    public var referees: [Person]?
    public var score: Score?
}

public struct Person {
    public var id: Int
    public var name: String
    public var role: String
    public var nationality: String?
}

public struct Score {
    public var winner: String?
    public var duration: String?
    public var fullTime: ScoreResult?
    public var halfTime: ScoreResult?
    public var extraTime: ScoreResult?
    public var penalties: ScoreResult?
}

public struct ScoreResult {
    public var homeTeam: Int?
    public var awayTeam: Int?
}

public struct Season {
    public var id: Int
    public var startDate: String
    public var endDate: String
    public var currentMatchday: Int?
}
