struct Topic: Decodable {
    let node: Node
    let member: Member
    let title: String
    let last_reply_by: String
    let last_modified: Int
    let last_touched: Int
    let url: String
    let created: Int
    let content: String
    let content_rendered: String
    let replies: Int
    let id: Int
}

struct Node: Decodable {
    let avatar_large: String
    let avatar_normal: String
    let avatar_mini: String
    let id: Int
    let name: String
    let url: String
    let title: String
    let title_alternative: String
    let topics: Int
    let stars: Int
    let header: String?
    let footer: String?
    let root: Bool
    let parent_node_name: String?
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
