# Test Doubles 

## Dummy 

<img width="600" alt="스크린샷 2021-06-06 오후 4 53 25" src="https://user-images.githubusercontent.com/38216027/120917159-86ba4a00-c6e8-11eb-9f62-6da78d5cd6f9.png">

* Dummy 개체는 테스트에서 사용되지 않고 **PlaceHolder 역할**만 하는 객체입니다. **일반적으로 어떤 구현도 포함하지 않습니다.** 

## Fake 

* Fake 객체는 원래 클래스의 동작과 결과를 복제하지만 훨씬 더 간단한 방식으로 실제 구현이 있는 객체입니다.

## Stub

<img width="600" alt="스크린샷 2021-06-06 오후 4 52 42" src="https://user-images.githubusercontent.com/38216027/120917153-828e2c80-c6e8-11eb-89af-50e46910bf24.png">

* Stub 객체는 함수가 항상 미리 정의된 데이터 집합을 반환하는 객체입니다. **서버 오류 또는 네트워크 연결 오류와 같이 실제 생활에서 달성하기 매우 어려운 특정 조건을 시뮬레이션하려는 경우** 특히 유용합니다.

## Spy

<img width="600" alt="스크린샷 2021-06-06 오후 4 54 11" src="https://user-images.githubusercontent.com/38216027/120917161-87eb7700-c6e8-11eb-920d-19e7879ca20d.png">

* Spy 객체는 간접 출력 대역으로서 SUT의 간접 출력을 기록합니다.  

## Mock

<img width="600" alt="스크린샷 2021-06-06 오후 4 55 04" src="https://user-images.githubusercontent.com/38216027/120917164-87eb7700-c6e8-11eb-9ba1-e23ffac9ad5f.png">

* Mock 객체는 호출되는 메서드와 호출 횟수를 추적(track)하는 객체입니다. 또한 mock을 사용하여 클래스의 동작 및 데이터 흐름을 검사(inspect) 할 수도 있습니다.

# Test Double 관련 Swift 코드

* 해당 내용은 이 [블로그](https://swiftsenpai.com/testing/test-doubles-in-swift/)의 내용과 글을 참고하였습니다. 사실 거의 번역했습니다. 😅

```swift
class TelevisionWarehouse {

    private let emailServiceHelper: EmailServiceHelper
    private let databaseReader: DatabaseReader

    private let minStockCount = 3
    private var stocks: [Television]

    // Failable initializer
    // Inject dependencies: DatabaseReader, EmailServiceHelper
    // Initializer will fail when not able to read stocks information from database
    init?(_ databaseReader: DatabaseReader, emailServiceHelper: EmailServiceHelper) {

        self.emailServiceHelper = emailServiceHelper
        self.databaseReader = databaseReader

        // 1
        let result = databaseReader.getAllStock()

        switch result {
        case .success(let stocks):
            self.stocks = stocks
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
    
    var stockCount: Int {
        return stocks.count
    }

    // 2
    // Add televisions to warehouse
    func add(_ newStocks: [Television]) {
        stocks.append(contentsOf: newStocks)
    }
    
    // 3
    // Remove televisions from warehouse
    func remove(_ count: Int) {
        
        if count <= stockCount {
            stocks.removeLast(count)
        } else {
            stocks.removeAll()
        }

        // 4
        // When stock less than minimum threshold, send email to manager
        if stocks.count < minStockCount {
            emailServiceHelper.sendEmail(to: "manager@email.com")
        }
    }
}

struct Television {
    let brand: String
    let price: Double
}
```

```swift
protocol DatabaseReader {
    func getAllStock() -> Result<[Television], Error>
}

class RealDatabaseReader: DatabaseReader {

    init() {
        // Make database connection
        // Perfrom nessesary configuration
        // ...
        // ...
    }

    func getAllStock() -> Result<[Television], Error> {

        // Construct database query
        // Perform database query
        // ...
        // ...
        
        if let error = error {
            // When error occurred
            return .failure(error)
        }

        // Successfully query database
        return .success(result)
    }
}
```

```swift
protocol EmailServiceHelper {
    func sendEmail(to address: String)
}

class RealEmailServiceHelper: EmailServiceHelper {
    func sendEmail(to address: String) {
        // Compose email content
        // Connect to email server
        // ...
        // ...
        // Send out email
    }
}
```

## Dummy 객체

```swift
class StubSuccessDatabaseReader: DatabaseReader {
    func getAllStock() -> Result<[Television], Error> {
        return .success([])
    }
}

// Dummy EmailServiceHelper
class DummyEmailServiceHelper: EmailServiceHelper {
    func sendEmail(to address: String) {}
}
```

```swift
func testWarehouseInitSuccess() {

    // Create dummies
    let stubSuccessReader = StubSuccessDatabaseReader()
    let dummyEmailService = DummyEmailServiceHelper()
    
    // Initialize TelevisionWarehouse
    let warehouse = TelevisionWarehouse(stubSuccessReader, emailServiceHelper: dummyEmailService)
    
    // Verify warehouse init successful
    XCTAssertNotNil(warehouse)
}
```
=> DummyEmailServiceHelper()는 TelevisionWarehouse 객체가 not nil인 검사하는 테스트에 사용되지 않는데 꼭 필요한 가짜 객체이므로 Dummy 이다. 

## Fake 객체

```swift
class FakeDatabaseReader: DatabaseReader {

    func getAllStock() -> Result<[Television], Error> {
        // Read JSON file
        let filePath = Bundle.main.path(forResource: "stock_sample", ofType: "json") // Note that stock_sample.json contains 3 television objects.
        let data = FileManager.default.contents(atPath: filePath!)
        
        // Parse JSON to object
        let decoder = JSONDecoder()
        let result = try! decoder.decode([Television].self, from: data!)

        return .success(result)
    }
}

// Conform Television to Decodable protocol for JSON parsing
extension Television: Decodable {
    
}
```

```swift
func testWarehouseAddRemoveStock() {
    
    let fakeReader = FakeDatabaseReader()
    let dummyEmailService = DummyEmailServiceHelper()
    
    let warehouse = TelevisionWarehouse(fakeReader, emailServiceHelper: dummyEmailService)!
    
    // Add 2 televisions to warehouse
    warehouse.add([
        Television(brand: "Toshiba", price: 199),
        Television(brand: "Toshiba", price: 199)
    ])
    
    // Remove 4 televisions from warehouse
    warehouse.remove(4)
    
    // Verify stock count is correct
    XCTAssertEqual(warehouse.stockCount, 1)
    
    // Remove amount more than stock count
    warehouse.remove(100)
    
    // Verify that stock count is 0
    XCTAssertEqual(warehouse.stockCount, 0)
}
```
=> 현재 Fake 객체는 DB를 사용하는 대신 JSON 파일의 데이터값을 읽어온다.
FakeDataBaseReader를 사용하여 데이터베이스에 연결하는 느린 프로세스를 피할 수 있습니다. 또한 테스트에 로드되는 데이터를 제어하는 ​​것도 훨씬 쉽습니다.

## Stub 객체

```swift
class StubDatabaseReader: DatabaseReader {
    
    enum StubDatabaseReaderError: Error {
        case someError
    }

    func getAllStock() -> Result<[Television], Error> {
        return .failure(StubDatabaseReaderError.someError)
    }
}
```

```swift
func testWarehouseInitFail() {
    
    let stubReader = StubDatabaseReader()
    let dummyEmailService = DummyEmailServiceHelper()
    
    let warehouse = TelevisionWarehouse(stubReader, emailServiceHelper: dummyEmailService)
        
    // Verify warehouse object is nil
    XCTAssertNil(warehouse)
}
```
=> 현재 Stub 객체는 실패라는 정해진 값을 가지고 있고 해당 Stub객체를 통해 TelevisionWarehouse 객체가 nil임을 테스트할 수 있게 되었습니다. 정해진 값 및 행동을 가진 Stub! 

## Stub vs Fake

이 단계까지 Stub과 Fake 사이에 몇 가지 유사점이 있음을 알아차렸을 것입니다. 사실, Television 객체의 배열을 반환하는 Stub의 getAllStock()을 이용해 Fake객체의 getAllStock()과 동일한 결과를 실제로 얻을 수 있습니다.

그러나 엄청난 양의 데이터 (1 만 개의 텔레비전 개체)를 로드해야 하는 상황에서는 Fake 객체를 사용하는 것이 여전히 선호되는 해결책입니다.

=> 내가 보기에는 그냥 Fake 객체는 json 파일로 불러오는 객체일때 Fake 객체라고 부르는 것 같다. 

## Mock 객체 

```swift
class MockEmailServiceHelper: EmailServiceHelper {
    
    var sendEmailCalled = false
    var emailCounter = 0
    var emailAddress = ""

    func sendEmail(to address: String) {
        sendEmailCalled = true
        emailCounter += 1
        emailAddress = address
    }
}
```

```swift
func testWarehouseSendEmail() {
    
    // FakeDatabaseReader will load 3 televisions
    let fakeReader = FakeDatabaseReader()
    let mockEmailService = MockEmailServiceHelper()
    
    let warehouse = TelevisionWarehouse(fakeReader, emailServiceHelper: mockEmailService)!
    
    // Remove warehouse's stocks to trigger notification email
    warehouse.remove(3)
    
    // Verify sendEmail(to:) called
    XCTAssertTrue(mockEmailService.sendEmailCalled)
    
    // Verify only 1 email being sent
    XCTAssertEqual(mockEmailService.emailCounter, 1)
    
    // Verify the email's recipient
    XCTAssertEqual(mockEmailService.emailAddress, "manager@email.com")
}
```
=> MockEmailServiceHelper 객체가 준비되면 이메일 전송 동작을 테스트할 수 있습니다.


## Spy 객체 : 다른 예제 코드 

```swift
final class SignupTextableViewSpy: UIView, SignupTextableView {
    var isCorrect: Bool = false
    var text: String? = nil
    var message: String? = nil
    
    func setWrongCase(message: String) {
        self.message = message
    }
    
    func setCorrectCase(message: String) {
        self.message = message
    }
}
```

```swift
final class SignupPresenterTests: XCTestCase {
    private var presenter: SignupPresenter!
    private var spy: SignupTextableViewSpy!
    
    override func setUp() {
        spy = SignupTextableViewSpy()
        spy.text = ""
        presenter = SignupPresenter(signupTextableView: spy)
    }

    override func tearDown() {
        presenter = nil
        spy = nil
    }
    
    func test_validateText_텍스트_길이가_0일때() throws {
        //when
        presenter.validateText()
        //then
        let result = try XCTUnwrap(spy.message)
        XCTAssertEqual(result, "필수 항목입니다.")
    }
}
```

=> Spy라는 말 그대로 간접 출력 결과를 담아내는 객체로서 해당 출력 결과를 테스트하면 됩니다. 