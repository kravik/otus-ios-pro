//
//  File.swift
//  
//
//  Created by Igor Kravtcov on 29.01.2021.
//

import Foundation
import Networking

final class CompetitionConverter {
    let seasonConverter = SeasonConverter()

    func convert(from result: Networking.Competition) -> Competition {
        .init(
            id: result.id,
            name: result.name,
            lastUpdated: result.lastUpdated,
            plan: .free,
            area: area(from: result.area),
            currentSeason: result.currentSeason.map(seasonConverter.convert(from:))
        )
    }

    private func area(from result: Networking.Area?) -> Area? {
        guard let result = result else {
            return nil
        }
        return Area(id: result.id, name: result.name, countryCode: result.countryCode)
    }
}

final class MatchConverter {
    let teamConverter = TeamConverter()

    func convert(from result: Networking.Match) -> Match {
        let referees = result.referees?.compactMap(self.person(from:))
        return Match(
            id: result.id,
            season: SeasonConverter().convert(from: result.season),
            utcDate: result.utcDate,
            status: result.status,
            matchday: result.matchday,
            stage: result.stage,
            group: result.group,
            lastUpdated: result.lastUpdated,
            homeTeam: teamConverter.convert(from: result.homeTeam),
            awayTeam: teamConverter.convert(from: result.awayTeam),
            referees: referees,
            score: score(from: result.score)
        )
    }

    private func score(from result: Networking.Score?) -> Score? {
        guard let result = result else {
            return nil
        }
        return Score(
            winner: result.winner,
            duration: result.duration,
            fullTime: scoreResult(from: result.fullTime),
            halfTime: scoreResult(from: result.halfTime),
            extraTime: scoreResult(from: result.extraTime),
            penalties: scoreResult(from: result.penalties)
        )
    }

    private func scoreResult(from result: Networking.ScoreResult?) -> ScoreResult? {
        guard let result = result else {
            return nil
        }
        return ScoreResult(homeTeam: result.homeTeam, awayTeam: result.awayTeam)
    }

    private func person(from result: Networking.Person?) -> Person? {
        guard let result = result else {
            return nil
        }
        return Person(id: result.id, name: result.name, role: result.role, nationality: result.nationality)
    }
}

final class SeasonConverter {
    func convert(from result: Networking.Season) -> Season {
        .init(
            id: result.id,
            startDate: result.startDate,
            endDate: result.endDate,
            currentMatchday: result.currentMatchday
        )
    }
}

final class TeamConverter {
    func convert(from result: Networking.Team?) -> Team? {
        guard let result = result else {
            return nil
        }
        return Team(id: result.id, name: result.name)
    }
}
