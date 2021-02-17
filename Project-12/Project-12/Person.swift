//
//  Person.swift
//  Project-12
//
//  Created by Innei on 2021/2/16.
//

import Foundation

class Person: NSObject, NSCoding, Identifiable, Codable {
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }

    public let name: String
    public let image: String
    public let uuid: String

    init(name: String, image: String, uuid id: String?) {
        self.name = name
        self.image = image
        uuid = id ?? UUID().uuidString
    }

    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        image = coder.decodeObject(forKey: "image") as? String ?? ""
        uuid = coder.decodeObject(forKey: "uuid") as? String ?? ""
    }
}

extension Person {
    func jsonEncode() -> Data? {
        let encoder = JSONEncoder()

        if let encode = try? encoder.encode(self) {
            return encode
        }
        return nil
    }

    func jsonDecode(data: Data) -> Self? {
        let decoder = JSONDecoder()

        guard let decode = try? decoder.decode(Self.self, from: data) else { return nil }
        return decode
    }

    func rawJSONString() -> String {
        guard let data = jsonEncode() else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
}
