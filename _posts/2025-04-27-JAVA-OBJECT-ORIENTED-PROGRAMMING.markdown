---
layout: post
title: "초급 개발자를 위한 자바 객체지향 프로그래밍 기초"
date: 2025-04-27 00:00:00 +0900
categories: Java Programming
---

# 초급 개발자를 위한 자바 객체지향 프로그래밍 기초

이 글은 초급 개발자를 위해 자바의 객체지향 프로그래밍(OOP) 기초를 다룹니다. 

## 1. 객체지향 프로그래밍
```java
// 객체지향 프로그래밍의 예
public class Car {
    String model;
    void drive() {
        System.out.println(model + "이(가) 달립니다.");
    }
}
```
**요약**: 객체지향 프로그래밍은 객체를 중심으로 데이터와 동작을 캡슐화하는 프로그래밍 패러다임이다.
실세계에 있는 사물을 모티브로 함
집합 관계 -> 완성품과 부품의 관계
사용 관계 -> 다른 객체의 필드를 읽고 변경하거나 메소드를 호출하는 관계
상속 관계 -> 부모와 자식 관계. 필드. 메소드를 물려받음

캡슐화, 상속등이 있음

캡슐화 -> 데이터, 동작을 하나로 묶고 실제 구현 내용을 외부로 감춤
상속 -> 자기 플드와 메소드를 자식에게 물려줌
다형성 polymorphism

## 2. 객체와 클래스
```java
public class Dog {
    String name;
    void bark() {
        System.out.println(name + ": 멍멍!");
    }
}
```
객체를 생성하려면 설계도에 해당하는 클래스가 필요
생성된 객체 -> 인스턴스
과정 -> 인스턴스화
여러 개의 인스턴스를 만들 수 있음

**요약**: 클래스는 객체의 설계도이며, 객체는 클래스의 인스턴스다.

## 3. 클래스 선언
```java
public class Student {
    String name;
    int grade;
}
```
**요약**: 클래스는 `class` 키워드로 선언하며, 객체의 속성과 동작을 정의한다.

## 4. 객체 생성과 클래스 변수
```java
Student s = new Student();
s.name = "철수";
```
**요약**: 객체는 `new` 키워드로 생성하며, 클래스 변수는 객체의 속성을 나타낸다.

## 5. 클래스의 구성 멤버
```java
public class Book {
    String title; // 필드
    Book(String t) { title = t; } // 생성자
    void read() { System.out.println("Reading " + title); } // 메소드
}
```
**요약**: 클래스는 필드, 생성자, 메소드로 구성된다.

필드 -> 객체의 데이터를 저장
생성자 -> 초기화 역할, 리턴 타입 없고 이름은 클래스 이름과 동일
메소드 -> 함수

## 6. 필드 선언과 사용
```java
public class Laptop {
    String brand;
    void setBrand(String b) { brand = b; }
}
```
**요약**: 필드는 객체의 데이터를 저장하며, 메소드를 통해 접근한다.

## 7. 생성자 선언과 호출
```java
public class Person {
    String name;
    Person(String n) { name = n; }
}
Person p = new Person("영희");
```
**요약**: 생성자는 객체 초기화를 위해 호출되는 특수 메소드다.

## 8. 메소드 선언과 호출
```java
public class Calculator {
    int add(int a, int b) { return a + b; }
}
Calculator calc = new Calculator();
int sum = calc.add(2, 3);
```
메소드 오버로딩이란 메소드 이름은 같되 매개변수의 타입, 개수, 순서가 다른 메소드를 여러 개 선언하는 것.
**요약**: 메소드는 객체의 동작을 정의하며, 호출을 통해 실행된다.

## 9. 인스턴스 멤버
```java
public class Bike {
    String color;
    void ride() { System.out.println(color + " 자전거를 탄다"); }
}
```
**요약**: 인스턴스 멤버는 객체에 속하며, 객체 생성 후 사용된다.

## 10. 정적 멤버
```java
public class Counter {
    static int count = 0;
    Counter() { count++; }
}
```
스태틱 사용해서 인스턴스 안 만들고도 쓸수 있음
메모리로 로딩될 때 자동으로 실행
여러개 선언되어 있을 경우에는 선언된 순서대로 실행
정적 필드는 생성 없이도 사용가능하여 생성자에서 초기화 작업을 안함

**요약**: 정적 멤버는 클래스에 속하며, 객체 없이 사용 가능하다.

## 11. final 필드와 상수
```java
public class Circle {
    final double PI = 3.14;
    double radius;
}
```
상수 선언하면 프로그램 실행 도중에 수정 못함
**요약**: `final` 필드는 변경 불가하며, 상수는 고정된 값을 가진다.

## 12. 패키지
```java
package com.example;
public class User {
    String id;
}
```
모두 소문자로 작성하라고 함
**요약**: 패키지는 클래스를 계층적으로 조직화하여 이름 충돌을 방지한다.

## 13. 접근 제한자
```java
public class Account {
    private int balance;
    public void deposit(int amount) { balance += amount; }
}
```
public -> 모두가 접근 가능
protected -> 같은 패키지이거나 자식 객체만 사용 가능
default -> 같은 패키지 내에 모두 가 사용 가능
private -> 객체 내부에서 사용 가능

**요약**: 접근 제한자는 클래스 멤버의 접근 범위를 제어한다.

## 14. Getter와 Setter
```java
public class Product {
    private String name;
    public String getName() { return name; }
    public void setName(String n) { name = n; }
}
```
외부에서 직접 접근하느 경우 잘못된 데이터 입력 가능
Setter 통해서 유효한 값만 필드에 저장 가능
**요약**: Getter와 Setter는 private 필드의 안전한 접근을 제공한다.

## 15. 싱글톤 패턴
```java
public class Singleton {
    private static Singleton instance = new Singleton();
    private Singleton() {}
    public static Singleton getInstance() { return instance; }
}
```
private 접근 제한하여 외부에서 new 연산자로 생성자를 호출 할 수 없음
다만 싱글톤 패턴이 제공하는 정적 메소드를 통해 간접적인 객체 얻기 가능
**요약**: 싱글톤 패턴은 클래스의 단일 인스턴스만 생성하도록 보장한다.

---
