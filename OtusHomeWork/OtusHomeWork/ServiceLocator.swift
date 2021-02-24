import UIKit

final class ServiceLocator: ObservableObject {

    private var services: [String: Any] = [:]

    func register<T>(_ service: T) {
        let key = serviceKey(T.self)
        services[key] = service
    }

    func service<T>() -> T {
        let key = serviceKey(T.self)
        return services[key] as! T
    }

    private func serviceKey(_ service: Any) -> String {
        "\(type(of: service))"
    }
}
