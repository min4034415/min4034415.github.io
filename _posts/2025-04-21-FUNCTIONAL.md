---
title: "Functional Programming"
date: 2025-04-21
tags: []
author: "이의민"
---

함수형 프로그래밍은 상태 변화와 가변 데이터를 지양하고, 함수의 적용을 통해 계산하는 프로그래밍 패러다임입니다. Swift는 다중 패러다임 언어로서 함수형 프로그래밍 스타일을 지원하며, 특히 컬렉션을 다룰 때 유용하게 활용될 수 있는 여러 기능을 제공합니다. 다음은 Swift에서 함수형 프로그래밍의 주요 개념과 예시입니다.

**1. 일급 함수 (First-Class Functions)**

함수를 변수에 할당하거나 함수의 인자로 전달하고, 함수의 반환 값으로 사용할 수 있는 기능을 의미합니다. Swift의 클로저(Closure)는 일급 함수의 역할을 합니다.

```swift
// 함수를 변수에 할당
let add: (Int, Int) -> Int = { $0 + $1 }
let result = add(3, 5) // result는 8

// 함수를 다른 함수의 인자로 전달
func applyOperation(_ operation: (Int, Int) -> Int, to operand1: Int, operand2: Int) -> Int {
    return operation(operand1, operand2)
}

let multiply: (Int, Int) -> Int = { $0 * $1 }
let result2 = applyOperation(multiply, to: 4, operand2: 6) // result2는 24
```

**2. 고차 함수 (Higher-Order Functions)**

하나 이상의 함수를 인자로 받거나 함수를 결과로 반환하는 함수를 의미합니다. Swift의 `map`, `filter`, `reduce`, `sorted` 등이 대표적인 고차 함수입니다.

* **`map`**: 컬렉션의 각 요소에 변환(transform) 클로저를 적용하여 새로운 컬렉션을 반환합니다.

```swift
let numbers = [1, 2, 3, 4, 5]
let squaredNumbers = numbers.map { $0 * $0 }
// squaredNumbers는 [1, 4, 9, 16, 25]
```

* **`filter`**: 컬렉션의 각 요소를 조건(predicate) 클로저에 통과시켜 `true`를 반환하는 요소들로 구성된 새로운 컬렉션을 반환합니다.

```swift
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let evenNumbers = numbers.filter { $0 % 2 == 0 }
// evenNumbers는 [2, 4, 6, 8, 10]
```

* **`reduce`**: 컬렉션의 요소들을 하나의 값으로 결합합니다. 초기값과 결합 방식을 정의하는 클로저를 사용합니다.

```swift
let numbers = [1, 2, 3, 4, 5]
let sum = numbers.reduce(0) { $0 + $1 }
// sum은 15 (0 + 1 + 2 + 3 + 4 + 5)

let words = ["Hello", "Functional", "Programming"]
let combinedString = words.reduce("") { $0 + " " + $1 }.trimmingCharacters(in: .whitespaces)
// combinedString은 "Hello Functional Programming"
```

* **고차 함수 조합**: 여러 고차 함수를 연결하여 데이터를 효율적으로 처리할 수 있습니다.

```swift
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let evenSquaresSum = numbers
    .filter { $0 % 2 == 0 } // [2, 4, 6, 8, 10]
    .map { $0 * $0 }      // [4, 16, 36, 64, 100]
    .reduce(0, +)         // 220
// evenSquaresSum은 220
```

**3. 불변성 (Immutability)**

데이터가 생성된 후에는 변경되지 않음을 의미합니다. Swift에서는 `let` 키워드를 사용하여 불변 객체나 값을 선언하고, 구조체(struct)와 열거형(enum) 같은 값 타입(Value Type)은 기본적으로 불변성을 가집니다. 불변성을 활용하면 코드의 예측 가능성을 높이고 부작용(Side Effect)을 줄일 수 있습니다.

```swift
// 불변 배열 (let)
let immutableArray = [1, 2, 3]
// immutableArray.append(4) // 컴파일 오류 발생

// 가변 배열 (var)
var mutableArray = [1, 2, 3]
mutableArray.append(4) // 가능
```

함수형 프로그래밍에서는 데이터를 변경하는 대신, 기존 데이터를 기반으로 새로운 데이터를 생성하는 방식을 선호합니다. 위에서 살펴본 `map`, `filter` 등은 원본 컬렉션을 변경하지 않고 새로운 컬렉션을 반환하는 불변적인 연산의 예입니다.

**4. 순수 함수 (Pure Functions)**

순수 함수는 다음과 같은 특징을 가집니다.

* **동일한 입력에 대해 항상 동일한 출력을 반환합니다.** (결정론적)
* **함수 외부의 상태를 변경하거나 외부 상태에 의존하지 않습니다.** (부작용 없음)

```swift
// 순수 함수 예시: 입력에만 의존하고 외부 상태를 변경하지 않음
func addPure(a: Int, b: Int) -> Int {
    return a + b
}

// 순수하지 않은 함수 예시: 전역 변수에 의존하고 변경함 (부작용 발생)
var globalValue = 10

func addImpure(a: Int) -> Int {
    globalValue += a // 외부 상태 변경 (부작용)
    return globalValue
}
```

순수 함수는 테스트하기 쉽고 병렬 처리에 안전하며 코드의 이해를 돕는다는 장점이 있습니다.

**5. 함수 조합 (Function Composition)**

여러 함수를 연결하여 하나의 새로운 함수를 만드는 기법입니다. Swift에서는 함수를 일급 객체로 다룰 수 있기 때문에 함수 조합이 자연스럽습니다.

```swift
// 두 함수를 조합하는 예시
func square(x: Int) -> Int {
    return x * x
}

func addOne(x: Int) -> Int {
    return x + 1
}

// square 후에 addOne을 적용하는 새로운 함수 생성
func squareThenAddOne(x: Int) -> Int {
    return addOne(x: square(x: x))
}

let result3 = squareThenAddOne(x: 3) // (3 * 3) + 1 = 10
```

Swift의 함수형 프로그래밍 스타일은 간결하고 가독성 높은 코드를 작성하는 데 도움을 주며, 데이터 변환 및 처리가 필요한 상황에서 특히 유용합니다. `map`, `filter`, `reduce`와 같은 고차 함수를 활용하고 불변성을 지향하는 것이 Swift에서 함수형 프로그래밍을 실천하는 핵심적인 방법입니다.


## 함수형 프로그래밍 (Functional Programming, FP)과 객체지향 프로그래밍 (Object-Oriented Programming, OOP) 비교

함수형 프로그래밍(FP)과 객체지향 프로그래밍(OOP)은 소프트웨어를 설계하고 구성하는 두 가지 주요 패러다임입니다. 두 접근 방식은 문제를 해결하고 코드를 구조화하는 방식에 있어 근본적인 차이를 보입니다.

### 1. 객체지향 프로그래밍 (Object-Oriented Programming, OOP)

OOP는 데이터를 **객체(Object)**라는 단위로 묶고, 이 객체들이 서로 상호작용하며 프로그램이 동작하도록 하는 패러다임입니다. 객체는 **상태(State, 데이터)**와 **행동(Behavior, 메서드)**을 함께 가집니다.

**주요 특징:**

* **캡슐화 (Encapsulation):** 데이터와 해당 데이터를 다루는 메서드를 하나의 객체 안에 묶고, 외부에서의 직접적인 접근을 제한하여 데이터의 무결성을 보호합니다.
* **상속 (Inheritance):** 부모 클래스의 속성과 행동을 자식 클래스가 물려받아 코드의 재사용성을 높이고 계층 구조를 만듭니다.
* **다형성 (Polymorphism):** 같은 이름의 메서드가 객체의 타입에 따라 다르게 동작하는 것을 의미합니다. 이를 통해 유연하고 확장 가능한 코드를 작성할 수 있습니다.
* **추상화 (Abstraction):** 복잡한 내부 구현을 숨기고 필요한 정보만 외부에 노출하여 인터페이스를 단순화합니다.
* **상태 변화 (Mutable State):** 객체 내부의 상태(데이터)는 메서드 호출 등을 통해 변경될 수 있습니다.

**장점:**

* 현실 세계의 문제를 객체 단위로 모델링하기 용이합니다.
* 코드 재사용성과 유지보수성이 좋습니다 (잘 설계된 경우).
* 대규모 프로젝트에서 코드 관리에 효과적일 수 있습니다.

**단점:**

* 상태 변화가 많을 경우 코드의 동작을 예측하기 어렵고 버그 발생 확률이 높아질 수 있습니다.
* 객체 간의 의존성이 복잡해지면 이해하고 테스트하기 어려워질 수 있습니다.
* 병렬/동시성 프로그래밍에서 공유되는 가변 상태 때문에 어려움이 발생할 수 있습니다 (Race Condition 등).

### 2. 함수형 프로그래밍 (Functional Programming, FP)

FP는 계산을 **상태 변화 없이 함수의 적용으로 대체**하려는 패러다임입니다. 수학적 함수와 유사하게, 함수는 입력 값을 받아 결과 값을 반환하며, 함수 호출은 외부에 어떤 부작용(Side Effect)도 일으키지 않습니다.

**주요 특징:**

* **일급 함수 (First-Class Functions):** 함수를 변수에 할당하고, 함수의 인자로 전달하거나 함수의 반환 값으로 사용할 수 있습니다. (Swift의 클로저)
* **불변성 (Immutability):** 데이터가 생성된 후에는 변경되지 않습니다. 데이터를 수정해야 할 경우 기존 데이터를 기반으로 새로운 데이터를 생성합니다.
* **순수 함수 (Pure Functions):**
    * 동일한 입력에 대해 항상 동일한 출력을 반환합니다.
    * 함수 외부의 상태를 변경하거나 외부 상태에 의존하지 않습니다 (부작용 없음).
* **고차 함수 (Higher-Order Functions):** 다른 함수를 인자로 받거나 함수를 결과로 반환하는 함수입니다. (`map`, `filter`, `reduce` 등)
* **함수 조합 (Function Composition):** 여러 함수를 조합하여 더 복잡한 함수를 만듭니다.
* **부작용 회피 (Avoiding Side Effects):** 프로그램의 동작이 함수 외부 상태의 변화에 의해 영향을 받거나, 함수가 외부 상태를 변경하는 것을 지양합니다.

**장점:**

* 순수 함수는 테스트하기 쉽고 예측 가능합니다.
* 불변성 덕분에 병렬/동시성 프로그래밍에서 안전성이 높습니다.
* 코드가 더 간결하고 수학적으로 추론하기 쉽습니다.
* 데이터 파이프라인 처리 및 변환에 매우 효과적입니다.

**단점:**

* 상태 변화가 필수적인 문제를 해결하기 위해서는 다른 접근 방식과의 조합이 필요할 수 있습니다.
* 초기 학습 곡선이 있을 수 있습니다 (특히 부작용 없는 사고방식).
* 모든 문제를 함수형 스타일로만 해결하기는 어려울 수 있습니다.

### 요약 비교

| 특징          | 객체지향 프로그래밍 (OOP)                     | 함수형 프로그래밍 (FP)                          |
| :------------ | :-------------------------------------------- | :---------------------------------------------- |
| **핵심 단위** | 객체 (데이터 + 행동)                            | 함수 (입력 -> 출력)                             |
| **상태 처리** | 가변 상태 (Mutable State), 객체 내부에서 관리     | 불변 상태 (Immutable State), 새로운 데이터 생성   |
| **사고 방식** | 객체 간 메시지 전달 및 상태 변화를 통한 동작      | 데이터 변환 및 함수 적용을 통한 결과 도출         |
| **코드 스타일** | 명령형 (Imperative) - *어떻게* 할 것인가에 집중 | 선언형 (Declarative) - *무엇을* 얻을 것인가에 집중 |
| **부작용** | 객체의 메서드를 통한 상태 변경 등 부작용 발생 가능 | 순수 함수를 통해 부작용 회피 또는 최소화        |
| **주요 개념** | 캡슐화, 상속, 다형성, 추상화, 객체, 클래스      | 일급 함수, 불변성, 순수 함수, 고차 함수, 조합     |
| **병렬 처리** | 공유 가변 상태로 인해 어려움 발생 가능          | 불변성 덕분에 비교적 용이                       |
| **테스트** | 상태 의존성 때문에 복잡해질 수 있음             | 순수 함수의 예측 가능성으로 용이                  |

### Swift에서의 활용

Swift는 OOP와 FP의 특징을 모두 지원하는 다중 패러다임 언어입니다. 클래스를 사용한 객체지향 설계와 함께, 구조체/열거형의 값 타입 특성을 활용한 불변성, 클로저를 활용한 일급 함수, 그리고 `map`, `filter`, `reduce`와 같은 강력한 고차 함수들을 통해 함수형 프로그래밍 스타일을 적용할 수 있습니다. 실제 개발에서는 두 패러다임의 장점을 적절히 조합하여 사용하는 경우가 많습니다. 예를 들어, UI 요소는 객체로 모델링하고, 데이터 처리 로직은 함수형 스타일로 작성하는 방식입니다.

결론적으로 OOP는 상태를 가진 객체를 중심으로 상호작용을 통해 문제를 해결하는 반면, FP는 상태 변화 없는 함수들을 조합하여 데이터를 변환하고 결과를 도출하는 방식입니다. 각 패러다임은 장단점이 있으며, 해결하려는 문제의 성격에 따라 적합한 접근 방식을 선택하거나 두 가지를 혼합하여 사용할 수 있습니다.



## Swift에서 자주 사용되는 함수형 프로그래밍 관련 함수 (고차 함수)

Swift에서 함수형 프로그래밍 스타일로 데이터를 다룰 때 자주 사용되는 주요 함수들은 주로 컬렉션 타입(Array, Dictionary, Set 등)의 메서드로 제공됩니다. 이 함수들은 컬렉션의 요소를 변환, 필터링 또는 결합하는 데 사용되며 클로저를 인자로 받습니다.

1.  **`map`**:
    * 컬렉션의 각 요소에 주어진 클로저를 적용하여 변환된 값으로 구성된 새로운 컬렉션을 생성합니다.
    * 원본 컬렉션의 요소 타입을 다른 타입으로 변환할 때 유용합니다.
    * 예시:
        ```swift
        let numbers = [1, 2, 3]
        let squaredNumbers = numbers.map { $0 * $0 }
        // squaredNumbers는 [1, 4, 9]
        ```

2.  **`filter`**:
    * 컬렉션의 각 요소에 주어진 클로저(조건)를 적용하여, 클로저가 `true`를 반환하는 요소들만으로 구성된 새로운 컬렉션을 생성합니다.
    * 원본 컬렉션에서 특정 조건을 만족하는 요소만 걸러낼 때 사용합니다.
    * 예시:
        ```swift
        let numbers = [1, 2, 3, 4, 5]
        let evenNumbers = numbers.filter { $0 % 2 == 0 }
        // evenNumbers는 [2, 4]
        ```

3.  **`reduce`**:
    * 컬렉션의 모든 요소를 주어진 클로저를 사용하여 단일 값으로 결합합니다. 초기값(Initial Value)을 제공해야 합니다.
    * 컬렉션의 합계, 평균, 최대/최소 값 계산 등 요소를 집계할 때 사용합니다.
    * 예시:
        ```swift
        let numbers = [1, 2, 3, 4, 5]
        let sum = numbers.reduce(0) { $0 + $1 } // 또는 numbers.reduce(0, +)
        // sum은 15 (0 + 1 + 2 + 3 + 4 + 5)
        ```
    * 예시 (문자열 결합):
        ```swift
        let words = ["Hello", "World"]
        let combinedString = words.reduce("") { $0 == "" ? $1 : $0 + " " + $1 }.trimmingCharacters(in: .whitespaces)
        // combinedString은 "Hello World"
        ```

4.  **`compactMap`**:
    * `map`과 유사하지만, 클로저가 반환하는 Optional 값 중에서 `nil`이 아닌 값들만 모아 새로운 컬렉션을 생성합니다. 결과 컬렉션은 Optional을 포함하지 않습니다.
    * Optional 값을 처리하거나, 변환 과정에서 `nil`이 발생할 수 있는 경우에 유용합니다.
    * 예시:
        ```swift
        let strings = ["1", "2", "abc", "4"]
        let integers = strings.compactMap { Int($0) }
        // integers는 [1, 2, 4] ("abc"는 Int 변환 시 nil이 되어 제외됨)
        ```

5.  **`flatMap`**:
    * 컬렉션의 각 요소에 클로저를 적용한 결과를 이어 붙인(flattened) 새로운 컬렉션을 생성합니다.
    * 중첩된 컬렉션(`[[1, 2], [3, 4]]`)을 평탄화하거나, 각 요소가 여러 값을 생성하는 경우에 사용됩니다. (Swift 4.1부터 시퀀스에 대한 `flatMap`은 Optional 시퀀스에서 `compactMap`으로 이름이 변경되었습니다. 다른 문맥에서의 `flatMap`은 여전히 사용됩니다.)
    * 예시 (중첩 배열 평탄화):
        ```swift
        let nestedNumbers = [[1, 2], [3, 4]]
        let flatNumbers = nestedNumbers.flatMap { $0 }
        // flatNumbers는 [1, 2, 3, 4]
        ```

6.  **`sorted(by:)`**:
    * 컬렉션의 요소를 주어진 비교 클로저에 따라 정렬된 새로운 배열을 반환합니다. 원본 컬렉션은 변경되지 않습니다.
    * 정렬 기준을 사용자 정의할 때 사용합니다.
    * 예시:
        ```swift
        let numbers = [3, 1, 4, 2]
        let sortedNumbers = numbers.sorted { $0 < $1 } // 또는 numbers.sorted() (Comparable 프로토콜 채택 시)
        // sortedNumbers는 [1, 2, 3, 4] (오름차순)
        ```

7.  **`forEach`**:
    * 컬렉션의 각 요소에 대해 주어진 클로저를 실행합니다. 주로 부작용(Side Effect)을 위해 사용됩니다 (예: 각 요소를 출력).
    * **주의:** `forEach`는 값을 반환하지 않으며, 루프 중간에 중단할 수 없습니다 (`break` 불가). 값을 변환하거나 새로운 컬렉션을 만들 때는 `map`, `filter` 등을 사용하는 것이 함수형 스타일에 더 적합합니다.
    * 예시:
        ```swift
        let numbers = [1, 2, 3]
        numbers.forEach { print($0) } // 1, 2, 3을 각각 출력
        ```

8.  **`contains(where:)`**:
    * 컬렉션에 특정 조건을 만족하는 요소가 하나라도 있는지 확인할 때 사용합니다. 조건을 만족하는 요소를 찾으면 즉시 검색을 중단하고 `true`를 반환합니다.
    * 예시:
        ```swift
        let numbers = [1, 2, 3, 4]
        let hasNumberGreaterThan3 = numbers.contains(where: { $0 > 3 })
        // hasNumberGreaterThan3는 true
        ```

9.  **`first(where:)`**:
    * 컬렉션에서 주어진 클로저 조건을 만족하는 첫 번째 요소를 찾아 Optional 값으로 반환합니다. 조건을 만족하는 요소가 없으면 `nil`을 반환합니다.
    * 예시:
        ```swift
        let numbers = [1, 2, 3, 4]
        let firstEvenNumber = numbers.first(where: { $0 % 2 == 0 })
        // firstEvenNumber는 Optional(2)
        ```

10. **`allSatisfy(_:)`**:
    * 컬렉션의 모든 요소가 주어진 클로저 조건을 만족하는지 확인합니다. 모든 요소가 조건을 만족하면 `true`, 하나라도 만족하지 않으면 `false`를 반환합니다.
    * 예시:
        ```swift
        let evenNumbers = [2, 4, 6]
        let areAllEven = evenNumbers.allSatisfy { $0 % 2 == 0 }
        // areAllEven은 true

        let mixedNumbers = [1, 2, 3]
        let areAllEvenMixed = mixedNumbers.allSatisfy { $0 % 2 == 0 }
        // areAllEvenMixed는 false
        ```

---

### 함수형 스타일의 장점

Swift에서 위와 같은 함수들을 활용하여 함수형 프로그래밍 스타일로 코드를 작성할 때 얻을 수 있는 장점은 다음과 같습니다.

* **코드가 간결하고 가독성이 높아집니다:** 반복문과 임시 변수 사용을 줄이고 데이터 변환 과정을 명확하게 표현할 수 있습니다.
* **불변성(immutability)을 지키기 쉬워, 버그가 줄어듭니다:** 데이터를 변경하는 대신 새로운 데이터를 생성하므로 예상치 못한 부작용 발생 가능성이 줄어듭니다.
* **병렬 처리 등 최적화에 유리합니다:** 불변 데이터를 사용하고 함수들이 독립적으로 동작하므로 병렬 처리를 구현하거나 컴파일러가 코드를 최적화하기가 더 용이합니다.
* **테스트 용이성:** 순수 함수는 입력에만 의존하고 부작용이 없으므로 테스트 케이스 작성이 간단하고 결과를 예측하기 쉽습니다.

---

### 참고

* Swift의 고차 함수들은 대부분 `Array`, `Dictionary`, `Set` 등 표준 컬렉션 타입에서 사용할 수 있습니다.
* Swift의 클로저 문법은 후행 클로저, 단축 인자 이름 ($0, $1 등), 암시적 반환 등을 활용하여 매우 간결하게 작성할 수 있습니다. 익숙해지면 코드가 훨씬 짧아지고 표현력이 풍부해집니다.

함수형 스타일은 모든 상황에 만능은 아니지만, 특히 데이터 처리 파이프라인을 구축하거나 복잡한 변환 로직을 구현할 때 코드를 더 효율적이고 안전하게 만들 수 있습니다. 특정 상황에 맞는 함수형 코드 변환이나 더 궁금한 함수의 사용법이 필요하시면 언제든 말씀해 주세요! 😊
