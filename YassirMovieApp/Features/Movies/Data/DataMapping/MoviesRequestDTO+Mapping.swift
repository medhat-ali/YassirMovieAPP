import Foundation

struct MoviesRequestDTO: Encodable {
    let query: String
    let page: Int
    let include_adult: Bool = false
    let include_video: Bool = false
    let sort_by: String = "popularity.desc"
}
