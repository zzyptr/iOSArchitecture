extension Member {

    static let mock = Member(
        avatar_large: "mock",
        avatar_normal: "mock",
        avatar_mini: "mock",
        username: "mock",
        url: "mock",
        website: "mock",
        github: "mock",
        psn: "mock",
        bio: "mock",
        tagline: "mock",
        twitter: "mock",
        location: "mock",
        btc: "mock",
        created: 0,
        id: 0
    )
}

struct Member: Decodable {
    let avatar_large: String
    let avatar_normal: String
    let avatar_mini: String
    let username: String
    let url: String
    let website: String?
    let github: String?
    let psn: String?
    let bio: String?
    let tagline: String?
    let twitter: String?
    let location: String?
    let btc: String?
    let created: Int
    let id: Int
}
