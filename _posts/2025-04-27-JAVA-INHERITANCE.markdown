---
layout: post
title: "초급 개발자를 위한 자바 상속 기초"
date: 2025-04-27 00:00:00 +0900
categories: Java Programming
---


## 1. 상속 개념
```java
public class Animal {
    String name;
    void eat() { System.out.println(name + "이(가) 밥을 먹는다"); }
}
public class Dog extends Animal {
}
```
**요약**: 상속은 부모 클래스의 속성과 동작을 자식 클래스가 물려받는 메커니즘이다.
개발된 클래스를 재사용하면서 중복 코드를 줄임
클래스 수정을 최소화

## 2. 클래스 상속
```java
public class Vehicle {
    String brand;
}
public class Car extends Vehicle {
    int wheels = 4;
}
```
**요약**: `extends` 키워드를 사용해 부모 클래스를 상속받아 자식 클래스를 정의한다.

## 3. 부모 생성자 호출
```java
public class Person {
    String name;
    Person(String name) { this.name = name; }
}
public class Student extends Person {
    Student(String name) { super(name); }
}
```
**요약**: 자식 클래스는 `super()`를 사용해 부모 클래스의 생성자를 호출한다.
super() 생성할 경우 부모 객체가 먼저 생성된 다음에 자식 객체가 생성

## 4. 메소드 재정의
```java
public class Bird {
    void fly() { System.out.println("날아간다"); }
}
public class Eagle extends Bird {
    @Override
    void fly() { System.out.println("독수리가 높이 날아간다"); }
}
```
메소드 오버라이딩 -> 상속된 메소드를 자식이 재정의함
해당 부모 메소드는 숨겨지고, 자식 메소드가 우선적으로 사용
선언부가 동일해야됨
**요약**: `@Override`를 사용해 부모 클래스의 메소드를 자식 클래스에서 재정의한다.
오버라이드 함으로 오버라이딩이 되었는지 체크해줌

## 5. final 클래스와 final 메소드
```java
public final class Immutable {
    final void cannotOverride() { System.out.println("고정된 메소드"); }
}
```
**요약**: `final` 클래스는 상속을, `final` 메소드는 재정의를 막는다.
오버라이딩을 막는법

## 6. protected 접근 제한자
```java
public class Appliance {
    protected String model;
}
public class TV extends Appliance {
    void setModel(String m) { model = m; }
}
```
**요약**: `protected`는 같은 패키지 또는 자식 클래스에서 접근 가능한 제한자다.
패키지에서만 접근 가능

## 7. 타입 변환
```java
Animal animal = new Cat(); // 업캐스팅
Cat cat = (Cat) animal;   // 다운캐스팅
```
**요약**: 타입 변환은 부모-자식 클래스 간 객체를 서로 다른 타입으로 참조하는 것이다.
자식 객체가 부모 타입으로 자동 변환하면 부모 타입에 선언된 필드와 메소드만 사용 가능

## 8. 다형성
```java
public class Shape {
    void draw() { System.out.println("도형 그리기"); }
}
public class Circle extends Shape {
    @Override
    void draw() { System.out.println("원 그리기"); }
}
Shape s = new Circle();
s.draw();
```
**요약**: 다형성은 부모 타입 참조로 자식 객체의 동작을 호출하는 능력이다.

## 9. 객체 타입 확인
```java
Object obj = new Dog();
if (obj instanceof Dog) {
    Dog dog = (Dog) obj;
}
```
true or false  반환
**요약**: `instanceof` 연산자는 객체의 실제 타입을 확인한다.

## 10. 추상 클래스
```java
public abstract class Animal {
    abstract void sound();
}
public class Cow extends Animal {
    void sound() { System.out.println("음메"); }
}
```

상속을 통해서 인스턴스 생성 가능
**요약**: 추상 클래스는 구현되지 않은 메소드를 포함하며, 상속받아 구현해야 한다.

## 11. 봉인된 클래스
```java
public sealed class Vehicle permits Car, Truck {
    String type;
}
public final class Car extends Vehicle {
}
```
**요약**: `sealed` 클래스는 상속을 특정 클래스들로 제한한다.
파이널에 비해는 유도리 있는 친구

---
