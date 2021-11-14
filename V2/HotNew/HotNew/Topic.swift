extension Topic {

    public static let mock = Topic(
        node: .mock,
        member: .mock,
        title: "mock",
        last_reply_by: "mock",
        last_modified: 0,
        last_touched: 0,
        url: "mock",
        created: 0,
        content: "mock",
        content_rendered: "mock",
        replies: 0,
        id: 0
    )
}

public struct Topic: Decodable {
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
