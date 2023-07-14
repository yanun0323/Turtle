import SwiftUI
import Ditto

struct VersionManager {
    static let infoUrl = "https://develop.yanunyang.com/api/file/turtle/info"
    static let fileUrl = "https://develop.yanunyang.com/api/file/turtle"
    
    static func Check(_ current: String) -> FileInfo? {
        guard let res = SendRequest(toUrl: infoUrl, type: FileInfo.self, action: { request in
            return request
        }) else { return nil }
        
        return res
    }
    
    static func SendRequest<T>(_ method: Http.Method = .GET, toUrl path: String, type: T.Type, action: @escaping (URLRequest) -> URLRequest) -> T? where T: Decodable {
        guard let url = URL(string: path) else {
            print("failed to generate url from string: \(path)")
            return nil
        }
        let channel = DispatchSemaphore(value: 0)
        var result: T? = nil
        
        var request = URLRequest(url: url, timeoutInterval: 30)
        request = action(request)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            defer { channel.signal() }
            guard
                let data = data,
                error == nil ,
                let responce = responce as? HTTPURLResponse,
                responce.statusCode == 200 else {
                print("Failed to download data")
                return
            }
            guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                return
            }
            result = decoded
            
        }.resume()
        channel.wait()
        return result
    }
}

struct FileInfo {
    var Name: String
    var Version: String
    var Description: String
    var Size: Int64
    var UpdateAt: Int64
}

extension FileInfo: Codable {}

//{
//    "Name":"turtle",
//    "Version":"0.5.2",
//    "Description":"新增自動確認新版本功能\n新增下載新版本功能",
//    "Size":2356027,
//    "UpdateAt":1679087950352
//
//}
