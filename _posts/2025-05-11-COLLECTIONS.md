---
title: "15_컬렉션"
date: 2025-05-11
tags: []
author: "이의민"
---
# Java 컬렉션 자료구조

## 15.1 컬렉션 프레임워크

```java
import java.util.List;
import java.util.Set;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.HashMap;

public class CollectionFrameworkExample {
    public static void main(String[] args) {
        // 주요 컬렉션 인터페이스와 구현 클래스들
        List<String> list = new ArrayList<>();          // 순서 유지, 중복 허용
        Set<String> set = new HashSet<>();              // 순서 없음, 중복 불가
        Map<String, Integer> map = new HashMap<>();     // 키-값 쌍, 키는 중복 불가
    }
}
```
- 컬렉션 프레임워크는 데이터 그룹을 효과적으로 처리할 수 있는 표준화된 구조를 제공하는 라이브러리입니다.

## 15.2 List 컬렉션

```java
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class ListExample {
    public static void main(String[] args) {
        // ArrayList - 내부적으로 배열 사용 (검색 빠름)
        List<String> arrayList = new ArrayList<>();
        arrayList.add("Java");              // 요소 추가
        arrayList.add("Python");
        arrayList.add(1, "C++");            // 인덱스 지정 추가
        
        System.out.println(arrayList.get(0));  // "Java" - 인덱스로 접근
        arrayList.remove(1);                // "C++" 삭제
        System.out.println(arrayList.size());  // 2 - 크기 확인
        
        // LinkedList - 노드 연결 (삽입/삭제 빠름)
        List<String> linkedList = new LinkedList<>();
        linkedList.add("Spring");
        linkedList.add("Hibernate");
        
        // 리스트 순회
        for (String item : arrayList) {
            System.out.println(item);
        }
    }
}
```
- List는 순서가 있고 중복을 허용하는 컬렉션으로, ArrayList는 빠른 검색, LinkedList는 빠른 삽입/삭제에 적합합니다.

## 15.3 Set 컬렉션

```java
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.TreeSet;
import java.util.Set;

public class SetExample {
    public static void main(String[] args) {
        // HashSet - 가장 빠른 검색
        Set<String> hashSet = new HashSet<>();
        hashSet.add("Apple");
        hashSet.add("Banana");
        hashSet.add("Apple");  // 중복 무시
        System.out.println(hashSet.size());  // 2 - 중복이 제거됨
        
        // LinkedHashSet - 입력 순서 유지
        Set<String> linkedHashSet = new LinkedHashSet<>();
        linkedHashSet.add("C");
        linkedHashSet.add("A");
        linkedHashSet.add("B");
        // 출력: C, A, B (입력 순서대로)
        for (String item : linkedHashSet) {
            System.out.println(item);
        }
        
        // TreeSet - 정렬된 순서 유지
        Set<String> treeSet = new TreeSet<>();
        treeSet.add("C");
        treeSet.add("A");
        treeSet.add("B");
        // 출력: A, B, C (정렬됨)
        for (String item : treeSet) {
            System.out.println(item);
        }
    }
}
```
- Set은 중복을 허용하지 않는 컬렉션으로, HashSet은 빠른 검색, LinkedHashSet은 입력 순서 유지, TreeSet은 정렬 기능을 제공합니다.

## 15.4 Map 컬렉션

```java
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.TreeMap;
import java.util.Map;

public class MapExample {
    public static void main(String[] args) {
        // HashMap - 가장 빠른 키-값 검색
        Map<String, Integer> hashMap = new HashMap<>();
        hashMap.put("사과", 1000);            // 키-값 추가
        hashMap.put("바나나", 2000);
        
        System.out.println(hashMap.get("사과"));  // 1000 - 값 검색
        hashMap.remove("사과");                // 키-값 쌍 삭제
        
        // LinkedHashMap - 입력 순서 유지
        Map<String, Integer> linkedHashMap = new LinkedHashMap<>();
        linkedHashMap.put("C", 3);
        linkedHashMap.put("A", 1);
        linkedHashMap.put("B", 2);
        // 키 순회 (입력 순서대로 C, A, B)
        for (String key : linkedHashMap.keySet()) {
            System.out.println(key + ": " + linkedHashMap.get(key));
        }
        
        // TreeMap - 키 기준으로 정렬
        Map<String, Integer> treeMap = new TreeMap<>();
        treeMap.put("C", 3);
        treeMap.put("A", 1);
        treeMap.put("B", 2);
        // 키 순회 (정렬 순서대로 A, B, C)
        for (Map.Entry<String, Integer> entry : treeMap.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
    }
}
```
- Map은 키-값 쌍을 저장하는 컬렉션으로, HashMap은 빠른 검색, LinkedHashMap은 입력 순서 유지, TreeMap은 키 기준 정렬을 제공합니다.

## 15.5 검색 기능을 강화시킨 컬렉션

```java
import java.util.TreeSet;
import java.util.TreeMap;
import java.util.Comparator;

public class EnhancedSearchExample {
    public static void main(String[] args) {
        // TreeSet - 범위 검색
        TreeSet<Integer> scores = new TreeSet<>();
        scores.add(87);
        scores.add(98);
        scores.add(75);
        scores.add(95);
        scores.add(80);
        
        // 특정 값 이상의 가장 가까운 값
        System.out.println("90점 이상 중 최소값: " + scores.ceiling(90));  // 95
        // 80~90 사이의 값들
        System.out.println("80~90 사이 점수: " + scores.subSet(80, true, 90, false));  // [80, 87]
        
        // 사용자 정의 정렬 - 내림차순
        TreeSet<Integer> reverseScores = new TreeSet<>(Comparator.reverseOrder());
        reverseScores.add(87);
        reverseScores.add(98);
        reverseScores.add(75);
        // 출력: 98, 87, 75 (내림차순)
        for (Integer score : reverseScores) {
            System.out.println(score);
        }
        
        // TreeMap - 키 기준 검색
        TreeMap<String, Integer> users = new TreeMap<>();
        users.put("홍길동", 30);
        users.put("김철수", 25);
        users.put("이영희", 28);
        
        // 특정 키 이전의 항목
        Map.Entry<String, Integer> entry = users.lowerEntry("이영희");
        System.out.println("이영희 앞 사람: " + entry.getKey());  // 김철수
    }
}
```
- TreeSet과 TreeMap은 이진 검색 트리 구조로 정렬, 범위 검색, 특정 값에 가까운 항목 찾기 등 향상된 검색 기능을 제공합니다.

## 15.6 LIFO와 FIFO 컬렉션

```java
import java.util.Stack;
import java.util.Queue;
import java.util.LinkedList;

public class StackQueueExample {
    public static void main(String[] args) {
        // Stack - LIFO(Last In First Out)
        Stack<String> stack = new Stack<>();
        stack.push("A");
        stack.push("B");
        stack.push("C");
        
        System.out.println(stack.pop());  // "C" - 마지막에 넣은 것 먼저 꺼냄
        System.out.println(stack.peek());  // "B" - 꺼내지 않고 확인만
        
        // Queue - FIFO(First In First Out)
        Queue<String> queue = new LinkedList<>();
        queue.offer("A");
        queue.offer("B");
        queue.offer("C");
        
        System.out.println(queue.poll());  // "A" - 처음 넣은 것 먼저 꺼냄
        System.out.println(queue.peek());  // "B" - 꺼내지 않고 확인만
    }
}
```
- Stack은 후입선출(LIFO), Queue는 선입선출(FIFO) 구조를 가진 컬렉션으로 각각 다른 데이터 접근 방식을 제공합니다.

## 15.7 동기화된 컬렉션

```java
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;
import java.util.HashMap;
import java.util.concurrent.ConcurrentHashMap;

public class SynchronizedCollectionExample {
    public static void main(String[] args) {
        // 동기화된 List
        List<String> synchronizedList = Collections.synchronizedList(new ArrayList<>());
        
        // 멀티스레드 환경에서 안전하게 사용
        Runnable task = () -> {
            synchronizedList.add(Thread.currentThread().getName());
        };
        
        Thread t1 = new Thread(task);
        Thread t2 = new Thread(task);
        t1.start();
        t2.start();
        
        // 동기화된 Map
        Map<String, Integer> synchronizedMap = 
            Collections.synchronizedMap(new HashMap<>());
            
        // 병렬 처리에 최적화된 ConcurrentHashMap
        Map<String, Integer> concurrentMap = new ConcurrentHashMap<>();
        concurrentMap.put("A", 1);
        // 존재하는 경우에만 업데이트 (원자적 연산)
        concurrentMap.computeIfPresent("A", (key, value) -> value + 1);
    }
}
```
- 동기화된 컬렉션은 `Collections.synchronized*` 메소드나 `ConcurrentHashMap` 같은 클래스를 사용해 멀티스레드 환경에서 안전하게 데이터를 처리할 수 있습니다.

## 15.8 수정할 수 없는 컬렉션

```java
import java.util.List;
import java.util.Set;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.HashMap;
import java.util.Collections;
import java.util.Arrays;

public class UnmodifiableCollectionExample {
    public static void main(String[] args) {
        // 수정 불가능한 리스트
        List<String> unmodifiableList = Collections.unmodifiableList(
            Arrays.asList("A", "B", "C")
        );
        
        // Java 9 이상에서는 of() 메소드 사용 가능
        List<String> immutableList = List.of("A", "B", "C");
        Set<String> immutableSet = Set.of("X", "Y", "Z");
        Map<String, Integer> immutableMap = Map.of("A", 1, "B", 2);
        
        try {
            immutableList.add("D");  // UnsupportedOperationException 발생
        } catch (UnsupportedOperationException e) {
            System.out.println("수정할 수 없는 컬렉션입니다!");
        }
        
        // 기존 컬렉션으로부터 수정 불가능한 컬렉션 생성
        List<String> originalList = new ArrayList<>();
        originalList.add("데이터1");
        originalList.add("데이터2");
        
        List<String> readOnlyList = Collections.unmodifiableList(originalList);
        // readOnlyList.add("데이터3");  // 예외 발생
    }
}
```
- 수정할 수 없는 컬렉션은 `Collections.unmodifiable*` 메소드나 `List.of()`, `Set.of()`, `Map.of()` 등을 사용해 생성하며, 데이터 보호와 불변성 보장에 유용합니다.
