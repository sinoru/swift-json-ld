//
//  JSONLDTests.swift
//  swift-json-ld
//
//  Created by Jaehong Kang on 10/27/24.
//

import Testing
@testable import JSONLD
import Foundation

@JSONLD(context: "https://json-ld.org/contexts/person.jsonld")
struct Test {
    let id: URL
    let name: String
    let born: String
    let spouse: URL
}

@Test func example() async throws {
    let test = """
    {
      "@context": "https://json-ld.org/contexts/person.jsonld",
      "@id": "http://dbpedia.org/resource/John_Lennon",
      "name": "John Lennon",
      "born": "1940-10-09",
      "spouse": "http://dbpedia.org/resource/Cynthia_Lennon"
    }
    """

    let value = try JSONLDDecoder().decode(Test.self, from: Data(test.utf8))

    #expect(value.id == URL(string: "http://dbpedia.org/resource/John_Lennon"))
    #expect(value.name == "John Lennon")
    #expect(value.born == "1940-10-09")
    #expect(value.spouse == URL(string: "http://dbpedia.org/resource/Cynthia_Lennon"))
}
