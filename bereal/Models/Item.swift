extension Models.Service {
    struct Item: Decodable {
        let id: String
        let name: String?
        let parentId: String?
        let isDir: Bool
        let contentType: String?
        let size: Int?
        let modificationDate: String?

        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case parentId = "parentId"
            case isDir = "isDir"
            case contentType = "contentType"
            case size = "size"
            case modificationDate = "modificationDate"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decode(String?.self, forKey: .name)
            self.parentId = try container.decode(String?.self, forKey: .parentId)
            self.isDir = try container.decode(Bool.self, forKey: .isDir)
            self.contentType = try container.decode(String?.self, forKey: .contentType)
            self.size = try container.decode(Int?.self, forKey: .size)
            self.modificationDate = try container.decode(String?.self, forKey: .modificationDate)
        }
    }
}
