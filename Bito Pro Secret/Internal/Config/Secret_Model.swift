import SwiftUI

// MARK: - Secret
struct Secret: Codable {
    var bito: Bito
    var custom: [Custom]?
}

extension Secret {
    struct Bito: Codable {
        var monitor: Monitor
        var deployment: Deployment
        var database: Database
        var other: Other
    }
    
    struct Custom: Codable {
        
    }
}

// MARK: - Secret.Bito
extension Secret.Bito {
    struct Monitor: Codable {
        var k8s: K8S
        var other: Other
    }
    
    struct Deployment: Codable {
        var deployment: Linker
        var develop: Linker
        var allProject: Linker
        var apiGateway: Linker
        var configMap: Linker
        var pairDeploy: Linker
        var orderCheck: Linker
        var orderCancel: Linker
        
        enum CodingKeys: String, CodingKey {
            case deployment
            case develop
            case allProject = "all_project"
            case apiGateway = "api_gateway"
            case configMap = "config_map"
            case pairDeploy = "pair_deploy"
            case orderCheck = "order_check"
            case orderCancel = "order_cancel"
        }
    }
    
    struct Database: Codable {
        var mysql: MySQL
        var mongo: Mongo
        var redis: Redis
    }
    
    struct Other: Codable {
        var backendBigSecret: String
        var backendBigTresure: String
        var hr: String
        var seat: String
        var bitoLand: String
        var shareMeeting: String
        
        enum CodingKeys: String, CodingKey {
            case backendBigSecret = "backend_big_secret"
            case backendBigTresure = "backend_big_tresure"
            case hr
            case seat
            case bitoLand = "bito_land"
            case shareMeeting = "share_meeting"
        }
    }
}

// MARK: - Secret.Bito.Monitor
extension Secret.Bito.Monitor {
    struct K8S: Codable {
        var staging: Dashboard
        var production: Dashboard
    }
    
    struct Other: Codable {
        var metabase: String
        var grafana: String
        var openSearch: String
        var oneSignal: String
        var kafdrop: Site
        var admin: Site
        
        enum CodingKeys: String, CodingKey {
            case metabase
            case grafana
            case openSearch = "open_search"
            case oneSignal = "one_signal"
            case kafdrop
            case admin
        }
    }
    
    struct Dashboard: Codable {
        var url: String
        var username: String
        var password: String
        var token: String
    }
    
    struct Site: Codable {
        var staging: String
        var demo: String
        var hotfix: String
        var production: String
    }
}

// MARK: - Secret.Bito.Deployment
extension Secret.Bito.Deployment {
    struct Linker: Codable {
        var description: [String]
        var natu: String?
        var protopuf: String?
        var staging: String?
        var demo: String?
        var hotfix: String?
        var rc: String?
    }
}

// MARK: - Secret.Bito.Database
extension Secret.Bito.Database {
    struct MySQL: Codable {
        var staging: Container
        var demo: Container
        var hotfix: Container
    }
    
    struct Mongo: Codable {
        var staging: Container
    }
    
    struct Redis: Codable {
        var staging: String
        var demo: String
        var hotfix: String
    }
    
    struct  Container: Codable {
        var host: String
        var username: String
        var password: String
        var database: String
    }
}
