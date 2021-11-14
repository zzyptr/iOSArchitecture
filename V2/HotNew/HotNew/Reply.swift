extension Reply {

    public static let mock = Reply(
        member: .mock,
        created: 0,
        topic_id: 0,
        content: "",
        content_rendered: "",
        last_modified: 0,
        id: 0
    )
}

public struct Reply: Decodable {
    let member: Member
    let created: Int
    let topic_id: Int
    let content: String
    let content_rendered: String
    let last_modified: Int
    let id: Int
}
