import Foundation

final class UserDefaultsMoviesQueriesStorage {
    private let maxStorageLimit: Int
    private let recentsMoviesQueriesKey = "recentsMoviesQueries"
    private var userDefaults: UserDefaults
    private let backgroundQueue: DispatchQueueType
    
    init(
        maxStorageLimit: Int,
        userDefaults: UserDefaults = UserDefaults.standard,
        backgroundQueue: DispatchQueueType = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.maxStorageLimit = maxStorageLimit
        self.userDefaults = userDefaults
        self.backgroundQueue = backgroundQueue
    }

  
}

