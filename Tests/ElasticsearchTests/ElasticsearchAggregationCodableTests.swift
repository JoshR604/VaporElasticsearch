import XCTest
@testable import Elasticsearch

final class ElasticsearchAggregationCodableTests: XCTestCase {
    var encoder: JSONEncoder!
    var decoder: JSONDecoder!
    
    override func setUp() {
        encoder = JSONEncoder()
        decoder = JSONDecoder()
    }   
    
    func testSingleValueResponse_response() throws {
        let json = """
        {"foo_avg":{"value": 7}}
        """
        let aggs = [AvgAggregation(name: "foo_avg", field: "bar", missing: 5)]
        decoder.setUserInfo(fromAggregations: aggs)
        let response = try decoder.decode([String: AnyAggregationResponse].self, from: json.data(using: .utf8)!)
        let aggResult = response["foo_avg"]?.base as! AggregationSingleValueResponse
        
        XCTAssertEqual(aggResult.name, "foo_avg")
        XCTAssertEqual(aggResult.value, 7)
    }

    
    func testAvgAggregation_encodesCorrectly() throws {
        let json = """
        {"aggs":{"foo":{"avg":{"field":"bar","missing":5}}}}
        """
        let queryContainer = SearchContainer(aggs: [AvgAggregation(name: "foo", field: "bar", missing: 5)])
        let encoded = try encoder.encodeToString(queryContainer)
        
        XCTAssertEqual(json, encoded)
    }
    
    func testCardinalityAggregation_encodesCorrectly() throws {
        let json = """
        {"aggs":{"foo":{"cardinality":{"field":"bar"}}}}
        """
        let queryContainer = SearchContainer(aggs: [CardinalityAggregation(name: "foo", field: "bar")])
        let encoded = try encoder.encodeToString(queryContainer)
        
        XCTAssertEqual(json, encoded)
    }
    
    func testExtendedStatsAggregation_encodesCorrectly() throws {
        let json = """
        {"aggs":{"foo":{"extended_stats":{"field":"bar"}}}}
        """
        let queryContainer = SearchContainer(aggs: [ExtendedStatsAggregation(name: "foo", field: "bar")])
        let encoded = try encoder.encodeToString(queryContainer)
        
        XCTAssertEqual(json, encoded)
    }
    
    func testGeoBoundsAggregation_encodesCorrectly() throws {
        let json = """
        {"aggs":{"foo":{"geo_bounds":{"field":"bar"}}}}
        """
        let queryContainer = SearchContainer(aggs: [GeoBoundsAggregation(name: "foo", field: "bar")])
        let encoded = try encoder.encodeToString(queryContainer)
        
        XCTAssertEqual(json, encoded)
    }
    
    func testGeoCentroidAggregation_encodesCorrectly() throws {
        let json = """
        {"aggs":{"foo":{"geo_centroid":{"field":"bar"}}}}
        """
        let queryContainer = SearchContainer(aggs: [GeoCentroidAggregation(name: "foo", field: "bar")])
        let encoded = try encoder.encodeToString(queryContainer)
        
        XCTAssertEqual(json, encoded)
    }
    
    func testMaxAggregation_encodesCorrectly() throws {
        let json = """
        {"aggs":{"foo":{"max":{"field":"bar"}}}}
        """
        let queryContainer = SearchContainer(aggs: [MaxAggregation(name: "foo", field: "bar")])
        let encoded = try encoder.encodeToString(queryContainer)
        
        XCTAssertEqual(json, encoded)
    }
    
    func testMinAggregation_encodesCorrectly() throws {
        let json = """
        {"aggs":{"foo":{"min":{"field":"bar"}}}}
        """
        let queryContainer = SearchContainer(aggs: [MinAggregation(name: "foo", field: "bar")])
        let encoded = try encoder.encodeToString(queryContainer)
        
        XCTAssertEqual(json, encoded)
    }
    
    func testTermsAggregation_encodesCorrectly() throws {
        let json = """
        {"aggs":{"foo":{"terms":{"field":"bar"}}}}
        """
        let queryContainer = SearchContainer(aggs: [TermsAggregation(name: "foo", field: "bar")])
        let encoded = try encoder.encodeToString(queryContainer)
        
        XCTAssertEqual(json, encoded)
    }
    
    func testLinuxTestSuiteIncludesAllTests() {
        #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
        let thisClass = type(of: self)
        let linuxCount = thisClass.allTests.count
        let darwinCount = Int(thisClass.defaultTestSuite.testCaseCount)
        XCTAssertEqual(linuxCount, darwinCount, "\(darwinCount - linuxCount) tests are missing from allTests")
        #endif
    }
    
    static var allTests = [
        ("testSingleValueResponse_response", testSingleValueResponse_response),
        ("testAvgAggregation_encodesCorrectly",     testAvgAggregation_encodesCorrectly),
        ("testCardinalityAggregation_encodesCorrectly", testCardinalityAggregation_encodesCorrectly),
        ("testExtendedStatsAggregation_encodesCorrectly", testExtendedStatsAggregation_encodesCorrectly),
        ("testGeoBoundsAggregation_encodesCorrectly", testGeoBoundsAggregation_encodesCorrectly),
        ("testGeoCentroidAggregation_encodesCorrectly", testGeoCentroidAggregation_encodesCorrectly),
        ("testMaxAggregation_encodesCorrectly", testMaxAggregation_encodesCorrectly),
        ("testMinAggregation_encodesCorrectly", testMinAggregation_encodesCorrectly),
        ("testTermsAggregation_encodesCorrectly", testTermsAggregation_encodesCorrectly),
        
        ("testLinuxTestSuiteIncludesAllTests",      testLinuxTestSuiteIncludesAllTests)
    ]
}
