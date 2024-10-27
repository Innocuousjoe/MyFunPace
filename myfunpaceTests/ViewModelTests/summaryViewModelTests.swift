import XCTest
@testable import myfunpace

final class myfunpaceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoad() throws {
        let viewModel = StepSummaryViewModel(MockPedometer())
        
        var calledSnapshotUpdate: Bool = false
        viewModel.onSnapshotUpdate = { snapshot in
            XCTAssert(snapshot.sectionIdentifiers.count == 1)
            calledSnapshotUpdate = true
        }
        
        viewModel.viewDidLoad()
        
        XCTAssertTrue(calledSnapshotUpdate)
    }
}
