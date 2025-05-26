---
title: "그룹 바이, 해빙, 집계함수"
date: 2025-05-26
tags: []
author: "이의민"
---

# GROUP BY, HAVING, 그리고 집계함수

데이터베이스에서 데이터를 분석할 때 자주 사용하는 **GROUP BY**, **HAVING**, 그리고 **집계함수**는 데이터를 효율적으로 요약하고 원하는 조건에 맞게 필터링하는데 사용됨. 


## 1. 집계함수 (Aggregate Functions)
집계함수는 여러 행의 데이터를 요약해서 하나의 값으로 변환하는 함수
주로 데이터를 분석하거나 통계 정보를 추출할 때 사용됨
대표적인 집계함수는 다음과 같음

- **COUNT()**: 행의 개수를 셈
- **SUM()**: 숫자 열의 합을 계산
- **AVG()**: 숫자 열의 평균을 구함
- **MAX()**: 열에서 최대값을 찾음
- **MIN()**: 열에서 최소값을 찾기

**예시**: 학생 테이블에서 나이 통계를 구하고 싶다고 해보죠.
```sql
SELECT COUNT(*) AS total_students, AVG(age) AS avg_age, MAX(age) AS max_age
FROM students;
```
이 쿼리는 학생 수, 평균 나이, 최고 나이를 한 번에 계산합니다. 결과는 단일 행으로 반환되며, 여러 행의 데이터를 요약한 값을 보여줍니다.

**핵심 포인트**: 집계함수는 보통 **여러 행**을 입력으로 받아 **하나의 결과**를 출력합니다. 그래서 데이터를 요약하거나 통계 데이터를 뽑아낼 때 유용하죠.

## 2. GROUP BY
`GROUP BY`는 데이터를 특정 열의 값에 따라 **그룹화**하는 역할을 합니다. 같은 값을 가진 행들을 묶어서 집계함수를 적용할 수 있게 해줍니다. 예를 들어, 학생 데이터를 학년별로 묶어서 각 학년의 평균 나이를 구하고 싶을 때 사용합니다.

**예시**: 학년별 학생 수와 평균 나이를 구하기
```sql
SELECT grade, COUNT(*) AS student_count, AVG(age) AS avg_age
FROM students
GROUP BY grade;
```
이 쿼리는 `students` 테이블에서 `grade` 열을 기준으로 데이터를 그룹화하고, 각 학년에 대해 학생 수와 평균 나이를 계산합니다. 결과는 각 학년별로 한 행씩 나타납니다.
보통 셀렉트 뒤에 나오는 것과 그룹 바이 나오는 것이 동일한 경우가 많음

**동작 방식**:
1. `grade` 열의 고유한 값(예: 1학년, 2학년, 3학년)을 기준으로 데이터를 나눕니다.
2. 각 그룹에 대해 `COUNT(*)`와 `AVG(age)`를 계산합니다.
3. 결과는 학년별 요약 정보로 반환됩니다.

**핵심 포인트**: `GROUP BY`는 집계함수와 함께 사용되어 데이터를 특정 기준으로 묶고 요약합니다. `SELECT` 절에 포함된 열은 `GROUP BY`에 명시되거나 집계함수로 처리되어야 합니다.

## 3. HAVING
`HAVING`은 `GROUP BY`로 그룹화한 결과에 조건을 적용할 때 사용합니다. 일반적인 `WHERE` 절은 개별 행에 조건을 적용하지만, `HAVING`은 **그룹화된 데이터**에 조건을 걸어 필터링합니다.

`HAVING`은 꼭 `GROUP BY`절 다음에 나와야 함 
조건을 제한하는 것이지만 집계 햠수에 대해서 조건을 제한함

**예시**: 학생 수가 5명 이상인 학년만 조회하기
```sql
SELECT grade, COUNT(*) AS student_count, AVG(age) AS avg_age
FROM students
GROUP BY grade
HAVING COUNT(*) >= 5;
```

이 쿼리는 학년별로 학생 수와 평균 나이를 계산한 뒤, 학생 수가 5명 이상인 학년만 보여줍니다.

```sql
SELECT last_name, gender, COUNT(*) AS count
FROM employees
GROUP BY last_name, gender
HAVING (gender = 'M' AND COUNT(*) > 140)
    OR (gender = 'F' AND COUNT(*) > 98);
```
가족 이름과 성별을 체크한 후 남자일 때는 140 이상 여자일 경우 98 이상인 친구들ㅇ의 개수를 개시

이런식으로 하면 

**`WHERE`와의 차이점**:
- `WHERE`: 개별 행에 조건을 적용 (그룹화 전에 필터링).
- `HAVING`: 그룹화된 결과에 조건을 적용 (그룹화 후 필터링).

**예시로 비교**:
```sql
SELECT grade, COUNT(*) AS student_count
FROM students
WHERE age > 18
GROUP BY grade
HAVING COUNT(*) >= 5;
```
- `WHERE age > 18`: 18세 초과인 학생들만 먼저 필터링.
- `GROUP BY grade`: 필터링된 데이터를 학년별로 그룹화.
- `HAVING COUNT(*) >= 5`: 그룹화된 결과 중 학생 수가 5명 이상인 학년만 출력.

## 실제 예시로 이해하기
`students` 테이블이 아래와 같다고 가정해봅시다:

| id | name     | age | grade |
|----|----------|-----|-------|
| 1  | 홍길동   | 20  | 1     |
| 2  | 김영희   | 19  | 1     |
| 3  | 이철수   | 21  | 2     |
| 4  | 박민수   | 18  | 1     |
| 5  | 최지영   | 20  | 2     |
| 6  | 정수진   | 22  | 3     |

다음 쿼리를 실행한다고 해보죠:
```sql
SELECT grade, COUNT(*) AS student_count, AVG(age) AS avg_age
FROM students
GROUP BY grade
HAVING COUNT(*) > 1
ORDER BY grade;
```

**결과**:
| grade | student_count | avg_age |
|-------|---------------|---------|
| 1     | 3             | 19.0    |
| 2     | 2             | 20.5    |

**설명**:
- `GROUP BY grade`: 데이터를 학년별로 묶음 (1학년: 3명, 2학년: 2명, 3학년: 1명).
- `COUNT(*)`와 `AVG(age)`: 각 학년의 학생 수와 평균 나이를 계산.
- `HAVING COUNT(*) > 1`: 학생 수가 1명을 초과하는 학년(1학년, 2학년)만 출력.
- `ORDER BY grade`: 결과를 학년 순으로 정렬.

## 주의사항
1. **SELECT 절의 열**: `GROUP BY`를 사용할 때는 `SELECT`에 포함된 열이 `GROUP BY`에 명시되거나 집계함수로 처리되어야 합니다. 예를 들어, `SELECT name, COUNT(*)`는 에러를 일으킵니다(`name`은 그룹화 기준이 아니므로).
2. **HAVING은 GROUP BY 뒤에**: `HAVING`은 반드시 `GROUP BY`와 함께 사용되며, 그룹화된 결과에만 적용됩니다.
3. **성능 고려**: 대량의 데이터에서 `GROUP BY`와 `HAVING`은 계산 비용이 클 수 있으니, 가능하면 `WHERE`로 미리 데이터를 필터링하는 것이 좋습니다.

## 마무리
`GROUP BY`, `HAVING`, 그리고 집계함수는 데이터베이스에서 데이터를 요약하고 분석하는 강력한 도구입니다. **집계함수**로 데이터를 요약하고, **GROUP BY**로 원하는 기준으로 묶고, **HAVING**으로 조건에 맞는 그룹만 골라내면 됩니다. 이 세 가지를 조합하면 복잡한 데이터 분석도 쉽게 처리할 수 있습니다.

궁금한 점이나 더 자세한 예제가 필요하면 언제든 말해주세요! 차트로 시각화하고 싶다면 요청 주시면 바로 만들어드릴게요.
