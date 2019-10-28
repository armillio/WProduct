
import Foundation

struct ApplicationConstants {

    #if DEBUG // DEVELOPMENT
    static let endpoint: Environment = .development
    #elseif RELEASE // APPSTORE
    static let endpoint: Environment = .production
    #endif
    static let APIBaseURL = endpoint.baseURL
    static let APIVersion = endpoint.version
}
