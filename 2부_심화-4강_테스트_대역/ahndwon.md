# Test Double

### **테스트 대역의 종류**

- 테스트 대역(Test Double)
    - 테스트의 실행 목적을 나타내기 위해 실제 컴포넌트 대신 설치하는 객체나 컴포넌트
- 테스트 대역의 동작 방식 4가지
    - 더미 객체(Dummy Object)
        - SUT 인자로 넘겨주긴 하지만 실제로는 쓰이지 않는 객체
        - 자리 채움용
    - 테스트 스텁(Test Stub)
        - SUT가 의존하는 실제 컴포넌트를 대신해 테스트가 SUT의 간접 입력을 제어할 수 있게 해주는 객체
    - 테스트 스파이(Test Spy)
        - 테스트 스텁의 업그레이드 버전, SUT의 실행이 끝난 후 테스트가 자신을 검사해 SUT의 간접 출력을 검증할 수 있게 한다.
    - 모의 객체(Mock Object)
        - SUT가 의존하는 실제 컴포넌트를 대체해 테스트가 SUT의 간접 출력을 검증할 수 있게 한다.
    - 가짜 객체(Fake Object)
        - 실제 DOC의 기능을 다르게 구현해 대체한 객체

### **더미 객체**

- 테스트 대역이 퇴화된 형태
- 메소드에서 메소드로 주고받는 것 외에는 전혀 쓸모가 없다.
- 널 객체 와는 다르다
- SUT에서 쓰지 않으므로 더미 객체가 어떻게 동작하는지 걱정할 필요 없다.

```kotlin
if (isTrue) {
	logic // 테스트 대상
} else {
	logic using dependency(dummy) // 테스트 비대상
}
```

### **테스트 스텁**

- 자신의 메소드가 호출될 때 SUT로 간접 입력 값을 보내는 제어 위치로 사용되는 객체
- 응답기(Responder)
    - 메소드가 호출될 때 정상/비정상 간접 입력을 SUT로 보내주는 기본적인 테스트 스텁
- 훼방꾼(Saboteur)
    - 예외나 에러를 발생시켜 SUT에 비정상 간접 입력을 보내주는 특수 테스트 스텁

    ```kotlin
    class Car {
    	enum classDirection {
    		NORTH,SOUTH,EAST,WEST
    	}

    	enum classOutcome {
    		OK,FAIL
    	}

    	var isMoving = false

    // 응답기
    	fun drive(direction : Direction): Outcome {
    		isMoving = true
    		return Outcome.OK
    	}

    // 훼방꾼
    	fun brake(): Outcome {
    		if (isMoving == false) {
    			throw IllegalStateException()
    		}
    		isMoving = false
    		return Outcome.OK
      }

    }
    ```

### **테스트 스파이**

- SUT의 간접 출력에 대한 관찰 위치로 쓰이는 객체
- 테스트 스텁의 기능에 더해 테스트 스파이에서는 SUT가 자신의 메소드를 호출한 내역을 기록할 수 있다.
- 검증 단계에서는 테스트 스파이로부터 실제로 호출된 내역과 기대 호출 내역을 비교하는 절차형 동작 검증을 한다.

```kotlin
val car =spyk(Car())// or spyk<Car>() to call default constructor

car.drive(Direction.NORTH)// returns whatever real function of Car returns

verify { car.drive(Direction.NORTH) }

confirmVerified(car)
```

### **모의객체**

- SUT의 간접 출력에 대한 관찰 위치로 쓰이는 객체
- 테스트 스텁과 마찬가지로 메소드가 호출되면 정보를 리턴해야 함
- SUT가 자신을 어떻게 호출했는지 신경 씀

```java
public class SecurityCentralTest {
    Window windowMock = mock(Window.class);
    Door doorMock = mock(Door.class);

    @Test
    public void enabling_security_locks_windows_and_doors() {
        SecurityCentral securityCentral = new SecurityCentral(windowMock, doorMock);
        securityCentral.securityOn();
        verify(doorMock).close();
        verify(windowMock).close();
    }
}
```

- 테스트 스파이와 다른점
    - 미리 정의한 기대 값과 실제 호출을 단언문으로 비교해 문제가 있으면 테스트 메소드를 대신해 테스트를 실패 시킨다.
    - 모든 테스트에서 같은 모의 객체로 SUT의 간접 출력을 검증하는 로직을 재사용할 수 있다.
- 엄격한 모의 객체
    - 정상 호출이여도 명시된 것과 순서가 다르면 테스트 실패

    ```kotlin
    val car = mockk<Car>()

    every { car.drive(Direction.NORTH) } returns Outcome.OK

    car.drive(Direction.NORTH)// returns OK

    verify { car.drive(Direction.NORTH) }

    confirmVerified(car)
    ```

- 관대한 모의 객체
    - 호출 순서가 달라도 넘어감.
    - 실제로 호출된 메소드에 대해서만 그에 해당하는 기대 호출을 검증

    ```kotlin
    val car = mockk<Car>(relaxed = true)

    car.drive(Direction.NORTH) // returns null

    verify { car.drive(Direction.NORTH) }

    confirmVerified(car)
    ```

### **가짜 객체**

- 테스트에 의해 제어되지 않고 관찰되지도 않는다.
- 실제 DOC의 기능 중 전체나 일부를 단순하게 구현
- 가짜 객체 쓰는 이유
    - 너무 느리거나, 테스트 환경에서 쓸 수 없을 때

### 의문

- mock 라이브러리로 stub을 포함하는 개념인건가

[정말로 테스트 대역이 필요한가]([https://gyuwon.github.io/blog/2020/05/10/do-you-really-need-test-doubles.html](https://gyuwon.github.io/blog/2020/05/10/do-you-really-need-test-doubles.html))