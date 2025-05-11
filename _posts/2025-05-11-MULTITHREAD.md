---
title: "14_멀티스레드"
date: 2025-05-11
tags: []
author: "이의민"
---
# Java 멀티 스레드 

## 14.1 멀티 스레드 개념

```java
// 멀티 스레드 개념 예시
public class MultiThreadExample {
    public static void main(String[] args) {
        // 두 개의 작업을 동시에 실행
        Thread task1 = new Thread(() -> {
            for (int i = 0; i < 5; i++) {
                System.out.println("작업 1 실행 중...");
                try { Thread.sleep(500); } catch (Exception e) {}
            }
        });
        
        task1.start();  // 새로운 스레드에서 실행
        
        // 메인 스레드는 별도로 계속 실행
        for (int i = 0; i < 5; i++) {
            System.out.println("메인 작업 실행 중...");
            try { Thread.sleep(500); } catch (Exception e) {}
        }
    }
}
```
- 멀티 스레드는 하나의 프로그램에서 여러 작업을 동시에 실행할 수 있게 해주는 기술입니다.

## 14.2 메인 스레드

```java
public class MainThreadExample {
    public static void main(String[] args) {
        // 현재 실행 중인 메인 스레드 정보 출력
        Thread mainThread = Thread.currentThread();
        System.out.println("프로그램 시작 스레드 이름: " + mainThread.getName());
        System.out.println("우선순위: " + mainThread.getPriority());
    }
}
```
- 메인 스레드는 `main()` 메소드를 실행하는 스레드로, JVM이 시작할 때 자동으로 생성됩니다.

## 14.3 작업 스레드 생성과 실행

```java
// 방법 1: Thread 클래스 상속
class MyThread extends Thread {
    @Override
    public void run() {
        System.out.println("Thread 상속받은 작업 스레드 실행");
    }
}

// 방법 2: Runnable 인터페이스 구현
class MyRunnable implements Runnable {
    @Override
    public void run() {
        System.out.println("Runnable 구현한 작업 스레드 실행");
    }
}

// 사용 예시
public class ThreadExample {
    public static void main(String[] args) {
        // Thread 상속 방식
        MyThread thread1 = new MyThread();
        thread1.start();
        
        // Runnable 구현 방식
        Thread thread2 = new Thread(new MyRunnable());
        thread2.start();
        
        // 람다식 사용
        Thread thread3 = new Thread(() -> {
            System.out.println("람다식으로 구현한 작업 스레드 실행");
        });
        thread3.start();
    }
}
```
- 작업 스레드는 Thread 클래스를 상속하거나 Runnable 인터페이스를 구현하여 생성하고, `start()` 메소드로 실행합니다.

## 14.4 스레드 이름

```java
public class ThreadNameExample {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            System.out.println("현재 스레드 이름: " + Thread.currentThread().getName());
        });
        
        thread.setName("작업스레드1");  // 스레드 이름 설정
        thread.start();
        
        System.out.println("메인 스레드 이름: " + Thread.currentThread().getName());
    }
}
```
- 스레드 이름은 `setName()` 메소드로 설정하고 `getName()` 메소드로 조회할 수 있으며, 디버깅 시 유용합니다.

## 14.5 스레드 상태

```java
public class ThreadStateExample {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            try {
                Thread.sleep(3000);  // 3초간 일시 정지
            } catch (InterruptedException e) {}
        });
        
        System.out.println("스레드 시작 전 상태: " + thread.getState());  // NEW
        
        thread.start();
        System.out.println("스레드 시작 후 상태: " + thread.getState());  // RUNNABLE
        
        try { Thread.sleep(500); } catch (Exception e) {}
        System.out.println("스레드 일시 정지 상태: " + thread.getState());  // TIMED_WAITING
        
        try { thread.join(); } catch (Exception e) {}
        System.out.println("스레드 종료 후 상태: " + thread.getState());  // TERMINATED
    }
}
```
- 스레드 상태는 NEW, RUNNABLE, BLOCKED, WAITING, TIMED_WAITING, TERMINATED 등으로 분류되며 `getState()` 메소드로 확인할 수 있습니다.

## 14.6 스레드 동기화

```java
public class SynchronizedExample {
    private static int counter = 0;
    
    // 동기화 메소드
    public synchronized static void increment() {
        counter++;
    }
    
    // 동기화 블록
    public static void incrementBlock() {
        synchronized(SynchronizedExample.class) {
            counter++;
        }
    }
    
    public static void main(String[] args) throws Exception {
        Thread t1 = new Thread(() -> {
            for (int i = 0; i < 10000; i++) {
                increment();
            }
        });
        
        Thread t2 = new Thread(() -> {
            for (int i = 0; i < 10000; i++) {
                increment();
            }
        });
        
        t1.start();
        t2.start();
        
        t1.join();
        t2.join();
        
        System.out.println("최종 카운터 값: " + counter);  // 20000이 나와야 함
    }
}
```
- 스레드 동기화는 `synchronized` 키워드를 사용하여 여러 스레드가 공유 자원에 동시에 접근하는 문제를 해결합니다.

## 14.7 스레드 안전 종료

```java
public class SafeStopExample {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            while (!Thread.interrupted()) {  // 인터럽트 확인
                System.out.println("작업 실행 중...");
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    // InterruptedException 발생 시 스레드 종료
                    System.out.println("인터럽트 발생, 스레드 종료");
                    break;
                }
            }
            System.out.println("작업 종료");
        });
        
        thread.start();
        
        try { Thread.sleep(3000); } catch (Exception e) {}  // 3초 동안 실행
        
        thread.interrupt();  // 스레드 안전하게 종료 요청
    }
}
```
- 스레드 안전 종료는 `interrupt()` 메소드와 `interrupted()` 확인을 통해 스레드를 안전하게 종료할 수 있게 합니다.

## 14.8 데몬 스레드

```java
public class DaemonThreadExample {
    public static void main(String[] args) {
        Thread daemon = new Thread(() -> {
            while (true) {
                System.out.println("데몬 스레드 실행 중...");
                try { Thread.sleep(1000); } catch (Exception e) {}
            }
        });
        
        daemon.setDaemon(true);  // 데몬 스레드로 설정
        daemon.start();
        
        try { Thread.sleep(3000); } catch (Exception e) {}
        System.out.println("메인 스레드 종료");
        // 메인 스레드 종료 시 데몬 스레드도 자동 종료
    }
}
```
- 데몬 스레드는 `setDaemon(true)`로 설정하며, 주 스레드가 종료되면 함께 종료되는 백그라ун드 작업용 스레드입니다.

## 14.9 스레드풀

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ThreadPoolExample {
    public static void main(String[] args) {
        // 고정 크기 스레드풀 생성 (최대 2개 스레드)
        ExecutorService executor = Executors.newFixedThreadPool(2);
        
        // 작업 제출
        for (int i = 0; i < 5; i++) {
            final int taskNum = i;
            executor.execute(() -> {
                System.out.println("작업 " + taskNum + " 실행 중, 스레드: " + 
                                   Thread.currentThread().getName());
                try { Thread.sleep(1000); } catch (Exception e) {}
            });
        }
        
        // 스레드풀 종료
        executor.shutdown();
    }
}
```
- 스레드풀은 `ExecutorService`를 통해 생성하며, 작업량이 많을 때 스레드 생성 비용을 줄이고 자원을 효율적으로 관리합니다.
