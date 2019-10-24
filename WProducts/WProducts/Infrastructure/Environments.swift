
import Foundation

enum Environment {
    case development
    case production

    var description: String {
        switch self {
        case .development:
            return "Development"
        case .production:
            return "Production"
        }
    }

    var baseURL: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }

    var version: String {
        return "2019.1"
    }

    var publicKey: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }

    var secretKey: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }
}