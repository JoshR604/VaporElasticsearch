/*
 These structs define all of the types that Elasticsearch can store,
 how they map to Swift types and allows the user to configure what
 the mapping should be like in their index.
 
 The list of types in Elasticsearch can be found at:
 https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-types.html
 */


import Foundation

public struct MapGeoPoint: Mappable {
    static var typeKey = MapType.geoPoint

    let type = typeKey.rawValue

    var ignoreMalformed: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case type
        case ignoreMalformed = "ignore_malformed"
    }
}
