extension Endpoint {
    static func items(in folderName: String?) -> Self {
        return Endpoint(path: String(format: "/items/%@", folderName ?? ""))
    }
}
