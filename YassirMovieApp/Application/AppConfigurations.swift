import Foundation

final class AppConfiguration {
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    lazy var imagesBaseURL: String = {
        guard let imageBaseURL = Bundle.main.object(forInfoDictionaryKey: "ImageBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return imageBaseURL
    }()
    
    lazy var EnableSSLPinning: Bool = {
        guard let EnableSSLPinning = Bundle.main.object(forInfoDictionaryKey: "EnableSSLPinning") as? Bool else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return EnableSSLPinning
    }()
    
    lazy var EncryptionKey: String = {
        guard let imageBaseURL = Bundle.main.object(forInfoDictionaryKey: "EncryptionKey") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return imageBaseURL
    }()
    
    lazy var CertificateName: String = {
        guard let CertificateName = Bundle.main.object(forInfoDictionaryKey: "CertificateName") as? String else {
            fatalError("CertificateName must not be empty in plist")
        }
        return CertificateName
    }()
    

}
