---
title: "FrontController"
date: 2025-06-09
tags: []
author: "이의민"
---

## FrontController (프론트 컨트롤러)

### FrontController

* **개념**: 모든 요청을 받고, 요청의 종류에 따라 작업을 분기하는 `Dispatcher Servlet` 입니다.
* **위치**: MVC 패턴에서 제일 앞 단에 위치합니다.

이 아키텍처는 클라이언트의 요청이 FrontController를 거쳐 Controller, Service, Dao, Database로 이어지는 흐름을 보여줍니다. 그리고 최종적으로 View를 통해 HTML 응답이 클라이언트로 전달됩니다.

### 사용자 요청 식별 방법

* **URL의 구성**: `http://서버IP번호:포트번호/context명/경로(식별값)`
    * 경로(식별값)는 수행해야 할 명령에 해당합니다.

### 식별값 추출하기

`HttpServletRequest` 객체의 `getRequestURI()`와 `getContextPath()` 메서드를 사용하여 요청 식별값을 추출할 수 있습니다.

```java
private String getCommandName(HttpServletRequest request) {
    String requestURI = req.getRequestURI();
    String contextPath = req.getContextPath();
    return requestURI.substring(contextPath.length());
}
```

### 요청별 처리 코드 찾기

* **Command 패턴 적용**:
    * `Map<String, Command>` 형태를 사용합니다.
    * **키(key)**: 요청 식별값 (예: `/create`, `/get`)
    * **값(value)**: `Command` 인터페이스의 구현체 (메서드 참조)
        * `/create` 요청은 `CreateCommand`로
        * `/get` 요청은 `GetCommand`로 매핑됩니다.
* 만약 `Map`에 요청 식별값이 없다면 404 에러를 반환합니다.

물론입니다! Front Controller 디자인 패턴은 웹 애플리케이션에서 자주 사용되는 아키텍처 패턴입니다. 이 패턴은 **모든 요청을 하나의 중앙 컨트롤러(Front Controller)**가 받아서 처리하게 하는 구조입니다.

⸻

📌 정의

Front Controller 패턴은 **클라이언트의 모든 요청을 단일 핸들러(컨트롤러)**가 먼저 받고, 그 요청을 적절한 처리기로 전달하거나 전처리/후처리를 담당하는 디자인 패턴입니다.

⸻

🧩 구조
  1.  Front Controller
  •  모든 요청의 진입점.
  •  예: DispatcherServlet (Spring MVC), index.php (Laravel), web.xml 서블릿 설정 등.
  2.  Dispatcher (전달자)
  •  요청을 어떤 컨트롤러로 보낼지 결정함.
  3.  Controller (처리기)
  •  실제 비즈니스 로직을 처리하는 컨트롤러들.
  4.  View
  •  응답 결과를 사용자에게 보여주는 부분.

⸻

💡 예시 (Spring MVC)

사용자 요청 → DispatcherServlet (Front Controller) → Controller → Service/Model → View


⸻

✅ 장점
  •  중앙 집중화
: 공통 처리(예: 인증, 로깅, 예외 처리)를 하나의 위치에서 처리 가능.
  •  유지보수 용이
: 요청 흐름이 명확하여 구조 이해가 쉬움.
  •  재사용성 증가
: 공통 코드(필터, 인터셉터 등)를 Front Controller에서 재사용 가능.

⸻

❌ 단점
  •  단일 지점 과부하
: 모든 요청이 한 곳으로 몰리므로 성능 문제가 발생할 수 있음.
  •  복잡도 증가
: 초기 설계가 어렵고 Dispatcher 설정이 복잡할 수 있음.

⸻

🔧 언제 사용하나?
  •  웹 애플리케이션에서 요청 처리를 중앙 집중화하고 싶을 때.
  •  MVC 아키텍처를 도입할 때 (거의 필수처럼 사용됨).

⸻

궁금한 부분이 있거나 예제 코드가 필요하면 알려주세요!
