extension Node {

    static let mock = Node(
        avatar_large: "mock",
        avatar_normal: "mock",
        avatar_mini: "mock",
        id: 0,
        name: "mock",
        url: "mock",
        title: "mock",
        title_alternative: "mock",
        topics: 0,
        stars: 0,
        header: "mock",
        footer: "mock",
        root: false,
        parent_node_name: "mock"
    )
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
