import Combine
import Networking

public enum FootballError: Error {
    public struct Message {
        let code: Int
        let text: String?
    }
    case unknown
    case message(Message)
}

public class FootballService {

    private let competitionConverter = CompetitionConverter()
    private let matchConverter = MatchConverter()
    private let teamConverter = TeamConverter()

    public init() {
    }

    public func competitions() -> Future<[Competition], FootballError> {
        Future<[Competition], FootballError> { promise in
            FootballAPI.getCompetitionsAuthorized(
                areas: nil,
                plan: "TIER_ONE"
            ) { [weak self] (response, error) in
                guard let self = self, let competitions = response?.competitions else {
                    promise(.failure(.unknown))
                    return
                }
                promise(.success(competitions.map(self.competitionConverter.convert(from:))))
            }
        }
    }

    public func matches(
        competition: Competition,
        matchday: Int
    ) -> Future<[Match], FootballError> {
        Future<[Match], FootballError> { promise in
            FootballAPI.getMatchesAuthorized(
                competitionId: competition.id,
                dateFrom: nil,
                dateTo: nil,
                stage: nil,
                status: nil,
                matchday: matchday
            ) { [weak self] (response, error) in
                guard let self = self, let matches = response?.matches else {
                    promise(.failure(.unknown))
                    return
                }
                promise(.success(matches.map(self.matchConverter.convert(from:))))
            }
        }
    }

    public func teams(competition: Competition) -> Future<[Team], FootballError> {
        Future<[Team], FootballError> { promise in
            FootballAPI.getTeamsAuthorized(
                competitionId: competition.id
            ) { [weak self] response, error in
                guard let self = self, let teams = response?.teams else {
                    promise(.failure(.unknown))
                    return
                }
                promise(.success(teams.compactMap(self.teamConverter.convert(from:))))
            }
        }
    }
}
