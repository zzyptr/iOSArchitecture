import Infra

enum API {

    static func allNodes() -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/nodes/all.json",
            parameters: nil
        )
    }

    static func node(id: Int) -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/nodes/show.json",
            parameters: ["id": id]
        )
    }

    static func node(name: String) -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/nodes/show.json",
            parameters: ["name": name]
        )
    }

    static func topic(id: Int) -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/topics/show.json",
            parameters: ["id": id]
        )
    }

    static func hotTopics() -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/topics/hot.json",
            parameters: nil
        )
    }

    static func newTopics() -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/topics/latest.json",
            parameters: nil
        )
    }

    static func topics(userName: String) -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/topics/show.json",
            parameters: ["username": userName]
        )
    }

    static func topics(nodeID id: Int) -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/topics/show.json",
            parameters: ["node_id": id]
        )
    }

    static func topics(nodeName name: String) -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/topics/show.json",
            parameters: ["node_name": name]
        )
    }

    static func replies(topicID id: Int) -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/replies/show.json",
            parameters: ["topic_id": id]
            // page, page_size
        )
    }

    static func user(name: String) -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/members/show.json",
            parameters: ["username": name]
        )
    }

    static func user(id: String) -> HTTPRequest {
        return HTTPRequest(
            method: .get,
            path: "/api/members/show.json",
            parameters: ["id": id]
        )
    }
}
