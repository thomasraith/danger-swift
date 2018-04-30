import XCTest
@testable import Danger

class BitBucketServerTests: XCTestCase {
    static var allTests = [
        ("test_BitBucketServerUser_decode", test_BitBucketServerUser_decoder),
        ("test_BitBucketServerProject_decode", test_BitBucketServerProject_decoder),
        ("test_BitBucketServerRepo_decode", test_BitBucketServerRepo_decoder),
        ("test_BitBucketServerPullRequest_decode", test_BitBucketServerPullRequest_decoder)
    ]
    
    private var decoder: JSONDecoder!
    
    override func setUp() {
        decoder = JSONDecoder()
    }
    
    override func tearDown() {
        decoder = nil
    }
    
    func test_BitBucketServerUser_decoder() throws {
        guard let data = BitBucketServerUserJSON.data(using: .utf8) else {
            XCTFail("Could not generate data")
            return
        }
        
        let correctUser = BitBucketServerUser(id: 1, name: "tum-id", displayName: "Firstname Lastname", emailAddress: "user.name@tum.de", active: true, slug: "tum-id", type: "NORMAL")
        
        let testUser: BitBucketServerUser = try JSONDecoder().decode(BitBucketServerUser.self, from: data)
        
        XCTAssertEqual(testUser, correctUser)
    }
    
    func test_BitBucketServerProject_decoder() throws {
        guard let data = BitBucketServerProjectJSON.data(using: .utf8) else {
            XCTFail("Could not generate data")
            return
        }
        
        let correctProject = BitBucketServerProject(id: 1666, key: "IOSEXAMPLE", name: "iOS Example Projects", isPublic: false, type: "NORMAL")
        
        let testProject: BitBucketServerProject = try JSONDecoder().decode(BitBucketServerProject.self, from: data)
        
        XCTAssertEqual(testProject, correctProject)
    }
    
    func test_BitBucketServerRepo_decoder() throws {
        guard let data = BitBucketServerRepoJSON.data(using: .utf8) else {
            XCTFail("Could not generate data")
            return
        }
        
        let correctProject = BitBucketServerProject(id: 1666, key: "IOSEXAMPLE", name: "iOS Example Projects", isPublic: false, type: "NORMAL")
        
        let correctRepo = BitBucketServerRepo(name: "Example Client", slug: "example-client", scmId: "git", isPublic: false, forkable: true, project: correctProject)
        
        let testRepo: BitBucketServerRepo = try JSONDecoder().decode(BitBucketServerRepo.self, from: data)
        
        XCTAssertEqual(testRepo, correctRepo)
    }
    
    func test_BitBucketServerPullRequest_decoder() throws {
        guard let data = BitBucketServerPRJSON.data(using: .utf8) else {
            XCTFail("Could not generate data")
            return
        }
        
        let correctProject = BitBucketServerProject(id: 1666, key: "IOSEXAMPLE", name: "iOS Example Projects", isPublic: false, type: "NORMAL")
        
        let correctRepo = BitBucketServerRepo(name: "Example Client", slug: "example-client", scmId: "git", isPublic: false, forkable: true, project: correctProject)
        
        let correctFromRef = BitBucketServerMergeRef(id: "refs/heads/feature/danger-integration", displayId: "feature/danger-integration", latestCommit: "42ff0464d251dee3b520f8f594c306b5a22a7c2b", repository: correctRepo)
        
        let correctToRef = BitBucketServerMergeRef(id: "refs/heads/develop", displayId: "develop", latestCommit: "dbfe864cb516c7b884217e5e4d0ce18fcded4407", repository: correctRepo)
        
        let correctAuthor = BitBucketServerUserEncapsulation(user: BitBucketServerUser(id: 99999, name: "TUM-Kennung", displayName: "Thomas Raith", emailAddress: "example@tum.de", active: true, slug: "TUM-Kennung", type: "NORMAL"))
        
        let correctReviwer = BitBucketServerUserEncapsulation(user: BitBucketServerUser(id: 99998, name: "Danger", displayName: "Danger", emailAddress: "Danger.bot@tum.de", active: true, slug: "danger", type: "NORMAL"))
        
        let correctPullRequest = BitBucketServerPR(id: 40, version: 0, title: "Feature/danger-integration", description: "* Add: Dangerfile", state: "OPEN", open: true, closed: false, createdAt: 1525112845344, updatedAt: 1525112845344, fromRef: correctFromRef, toRef: correctToRef, isLocked: false, author: correctAuthor, reviewers: [correctReviwer], participants: [])
        
        let testPullRequest: BitBucketServerPR = try JSONDecoder().decode(BitBucketServerPR.self, from: data)
        
        XCTAssertEqual(testPullRequest, correctPullRequest)
    }
    
    
    
}
