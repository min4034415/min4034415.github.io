---
layout: post
title: "08 인터페이스"
date: 2025-04-27 00:00:00 +0900
categories: Java Programming
---

## 1. 인터페이스의 역할
```java
public interface Drivable {
    void drive();
}
```
**요약**: 인터페이스는 클래스가 따라야 할 계약을 정의하며, 다형성을 지원한다.

## 2. 인터페이스와 구현 클래스 선언
```java
public interface Printable {
    void print();
}
public class Document implements Printable {
    public void print() { System.out.println("문서를 출력합니다"); }
}
```
**요약**: 인터페이스는 `interface`로 선언하고, 클래스는 `implements`로 이를 구현한다.

## 3. 상수 필드
```java
public interface Config {
    int MAX_USERS = 100;
}
```
**요약**: 인터페이스의 필드는 `public static final`로, 상수로만 사용된다.

## 4. 추상 메소드
```java
public interface Movable {
    void move();
}
public class Robot implements Movable {
    public void move() { System.out.println("로봇이 이동합니다"); }
}
```
**요약**: 추상 메소드는 구현을 강제하며, 구현 클래스에서 정의된다.

## 5. 디폴트 메소드
```java
public interface Logger {
    default void log(String message) {
        System.out.println("Log: " + message);
    }
}
```
**요약**: 디폴트 메소드는 기본 구현을 제공하며, 구현 클래스에서 재정의 가능하다.

## 6. 정적 메소드
```java
public interface MathUtil {
    static int square(int x) { return x * x; }
}
```
**요약**: 정적 메소드는 인터페이스에 직접 정의된 유틸리티 메소드다.

## 7. private 메소드
```java
public interface Validator {
    private boolean isValid(String input) {
        return input != null && !input.isEmpty();
    }
    default void validate(String input) {
        if (isValid(input)) System.out.println("유효함");
    }
}
```
**요약**: `private` 메소드는 인터페이스 내부에서만 사용되는 헬퍼 메소드다.

## 8. 다중 인터페이스 구현
```java
public interface Flyable { void fly(); }
public interface Swimmable { void swim(); }
public class Duck implements Flyable, Swimmable {
    public void fly() { System.out.println("오리가 날아갑니다"); }
    public void swim() { System.out.println("오리가 수영합니다"); }
}
```
implements 뒤에 쉼표로 구부냏서 작성하여 여러개의 인터페이스가 가진 추상 메소드를 재정의 스위프트의 프로토콜과 같은 느낌
**요약**: 클래스는 여러 인터페이스를 구현하여 다중 동작을 지원할 수 있다.

## 9. 인터페이스 상속
```java
public interface Vehicle { void start(); }
public interface ElectricVehicle extends Vehicle { void charge(); }
```
인터페이스가 인터페이스를 상속할 수 있음
**요약**: 인터페이스는 `extends`를 사용해 다른 인터페이스를 상속받는다.

## 10. 타입 변환
```java
public interface Drawable { void draw(); }
Drawable d = new Circle();
Circle circle = (Circle) d;
```
**요약**: 인터페이스 타입은 구현 객체로 업캐스팅 또는 다운캐스팅될 수 있다.

## 11. 다형성
```java
public interface Playable { void play(); }
public class Guitar implements Playable {
    public void play() { System.out.println("기타를 연주합니다"); }
}
Playable p = new Guitar();
p.play();
```
**요약**: 다형성은 인터페이스 타입으로 구현 객체의 메소드를 호출하는 능력이다.

## 12. 객체 타입 확인
```java
public interface Eatable { void eat(); }
Object obj = new Apple();
if (obj instanceof Eatable) {
    ((Eatable) obj).eat();
}
```
**요약**: `instanceof`는 객체가 특정 인터페이스를 구현했는지 확인한다.
상속이랑 비슷한 개념인듯

## 13. 봉인된 인터페이스
```java
public sealed interface Service permits DatabaseService, WebService {
    void execute();
}
public final class DatabaseService implements Service {
    public void execute() { System.out.println("DB 서비스 실행"); }
}
```
**요약**: `sealed` 인터페이스는 구현 클래스를 특정 클래스로 제한한다.

---
