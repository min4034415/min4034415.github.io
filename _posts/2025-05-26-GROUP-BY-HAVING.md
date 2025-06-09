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

## ROLLUP

`GROUP BY ROLLUP`은 SQL에서 데이터를 다양한 수준으로 요약하고 집계하는 데 사용되는 강력한 기능입니다. 일반적인 `GROUP BY`는 지정된 컬럼들의 조합에 따라 데이터를 그룹화하고 각 그룹에 대한 집계 결과를 보여주지만, `ROLLUP`은 여기에 **소계(Subtotal)**와 **총계(Grand Total)**를 자동으로 추가해줍니다.


### `GROUP BY ROLLUP`의 작동 방식

`ROLLUP`은 `GROUP BY` 절에 나열된 컬럼들의 모든 가능한 계층적 조합에 대해 집계를 수행합니다. 예를 들어, `ROLLUP(A, B, C)`를 사용하면 다음과 같은 순서로 그룹화하여 결과를 생성합니다.

1.  `(A, B, C)`: 가장 세분화된 수준의 그룹 (일반적인 `GROUP BY A, B, C`와 동일)
2.  `(A, B)`: `C`에 대한 소계 (A와 B를 기준으로 그룹화, C는 NULL로 표시)
3.  `(A)`: `B`에 대한 소계 (A를 기준으로 그룹화, B와 C는 NULL로 표시)
4.  `()`: 전체 총계 (모든 컬럼이 NULL로 표시)

각 그룹 수준에서 `SUM`, `COUNT`, `AVG` 등의 집계 함수가 적용됩니다. `NULL` 값은 해당 그룹 수준에서 집계된 모든 데이터를 나타냅니다.

---

### `GROUP BY ROLLUP`의 주요 특징 및 장점

* **다단계 집계:** 단일 쿼리로 여러 수준의 집계 결과를 얻을 수 있어 여러 번의 `GROUP BY` 쿼리를 실행하거나 `UNION ALL`을 사용할 필요가 없어 쿼리를 단순화하고 성능을 향상시킵니다.
* **보고서 작성 용이:** 판매 보고서, 재고 보고서 등 다양한 계층적 요약 보고서를 작성할 때 매우 유용합니다. 예를 들어, 지역별-제품별 판매량, 지역별 총 판매량, 전체 총 판매량을 한 번에 확인할 수 있습니다.
* **NULL 활용:** `ROLLUP`이 생성하는 `NULL` 값은 실제 데이터의 `NULL`과는 다릅니다. 이는 해당 계층에서 집계된 전체 데이터를 나타내며, `GROUPING` 함수와 함께 사용하여 이 `NULL`이 `ROLLUP`에 의해 생성된 것인지 실제 데이터의 `NULL`인지 구분할 수 있습니다.

---

### 예시

다음 `Orders` 테이블이 있다고 가정해봅시다.

| Region | Product | Sales |
| :----- | :------ | :---- |
| East   | A       | 100   |
| East   | B       | 150   |
| West   | A       | 200   |
| West   | C       | 50    |

`GROUP BY ROLLUP(Region, Product)`를 사용하여 판매량을 집계하면 다음과 같은 결과를 얻을 수 있습니다.

```sql
SELECT
    Region,
    Product,
    SUM(Sales) AS TotalSales
FROM
    Orders
GROUP BY
    ROLLUP(Region, Product);
```

**결과:**

| Region | Product | TotalSales |
| :----- | :------ | :--------- |
| East   | A       | 100        |
| East   | B       | 150        |
| East   | NULL    | 250        | <- **Region 'East'의 소계**
| West   | A       | 200        |
| West   | C       | 50         |
| West   | NULL    | 250        | <- **Region 'West'의 소계**
| NULL   | NULL    | 500        | <- **전체 총계**

---

### `GROUPING` 함수

`ROLLUP`으로 인해 생성된 `NULL` 값과 실제 데이터의 `NULL` 값을 구분해야 할 때 `GROUPING` 함수를 사용할 수 있습니다. `GROUPING(column)`은 해당 컬럼이 `ROLLUP`에 의해 생성된 소계/총계 그룹의 일부일 경우 `1`을 반환하고, 그렇지 않을 경우 `0`을 반환합니다.

```sql
SELECT
    Region,
    Product,
    SUM(Sales) AS TotalSales,
    GROUPING(Region) AS GroupingRegion,
    GROUPING(Product) AS GroupingProduct
FROM
    Orders
GROUP BY
    ROLLUP(Region, Product);
```

**결과 (일부):**

| Region | Product | TotalSales | GroupingRegion | GroupingProduct |
| :----- | :------ | :--------- | :------------- | :-------------- |
| East   | NULL    | 250        | 0              | 1               | <- `Product`가 `ROLLUP`에 의해 `NULL`로 처리됨
| NULL   | NULL    | 500        | 1              | 1               | <- `Region`, `Product` 모두 `ROLLUP`에 의해 `NULL`로 처리됨

`GROUPING` 함수를 사용하는 이유는 **`ROLLUP` (또는 `CUBE`, `GROUPING SETS`)에 의해 생성된 `NULL` 값과 원본 데이터에 실제로 존재하는 `NULL` 값을 구분하기 위해서**입니다.

---

### 왜 구분해야 할까요?

1.  **정확한 데이터 해석:**
    * `ROLLUP`으로 인해 `NULL`이 나타난 행은 "해당 컬럼의 모든 값에 대한 소계 또는 총계"를 의미합니다. 예를 들어, `Product` 컬럼이 `NULL`이고 `Region`이 'East'인 행은 "East 지역의 모든 제품 판매량 합계"를 나타냅니다.
    * 하지만 만약 원본 데이터에 실제로 `Product`가 `NULL`인 데이터가 있었다면, 이는 "어떤 제품인지 알 수 없는 East 지역의 판매량"을 의미합니다.
    * `GROUPING` 함수가 없으면 이 두 가지 `NULL`을 육안으로는 구분할 수 없어 데이터를 잘못 해석할 위험이 있습니다.

2.  **조건부 로직 처리:**
    * 보고서나 쿼리 결과에서 소계 또는 총계 행에만 특별한 레이블을 붙이거나, 특정 계산을 적용하고 싶을 때 `GROUPING` 함수가 유용합니다.
    * 예를 들어, `Product`가 `NULL`인 소계 행에는 '총합'이라는 레이블을 붙이고 싶을 수 있습니다.

    ```sql
    SELECT
        CASE WHEN GROUPING(Region) = 1 THEN '전체 총계' ELSE Region END AS Region_Label,
        CASE WHEN GROUPING(Product) = 1 THEN '지역 총계' ELSE Product END AS Product_Label,
        SUM(Sales) AS TotalSales
    FROM
        Orders
    GROUP BY
        ROLLUP(Region, Product);
    ```
    이 쿼리는 `GROUPING` 함수를 사용하여 `NULL` 값을 더 의미 있는 텍스트로 대체함으로써 보고서의 가독성을 높입니다.

3.  **데이터 무결성 확인:**
    * 때로는 원본 데이터에 `NULL`이 없어야 하는 컬럼에 `NULL`이 들어간 경우를 감지하거나 처리해야 할 때가 있습니다. `GROUPING` 함수를 사용하면 `ROLLUP`으로 생성된 `NULL`과 실제 데이터의 `NULL`을 구분하여 이러한 시나리오를 더 정교하게 다룰 수 있습니다.


### GROUPING SETS

`GROUPING SETS`는 `GROUP BY` 절에서 **명시적으로 여러 개의 그룹화 조건을 지정**할 때 사용합니다. 즉, 하나의 쿼리 내에서 여러 개의 `GROUP BY` 절을 `UNION ALL`로 연결한 것과 같은 효과를 낼 수 있습니다. 이를 통해 개별적인 집계 쿼리를 여러 번 작성하고 합칠 필요 없이 한 번에 원하는 여러 수준의 집계를 얻을 수 있습니다.

**작동 방식:**
`GROUPING SETS`는 괄호 안에 여러 개의 그룹화 조건을 쉼표로 구분하여 나열합니다. 각 그룹화 조건은 컬럼들의 튜플(묶음)이 될 수 있습니다.

**예시:**

```sql
SELECT
    Region,
    Product,
    SUM(Sales) AS TotalSales
FROM
    Orders
GROUP BY
    GROUPING SETS (
        (Region, Product), -- Region과 Product별 집계
        (Region),          -- Region별 집계
        (Product),         -- Product별 집계
        ()                 -- 전체 총계
    );
```

이 쿼리는 다음과 같은 4가지 그룹화 조합에 대한 결과를 생성합니다.

1.  `Region`, `Product`별 판매량 (`GROUP BY Region, Product`와 동일)
2.  `Region`별 판매량 (`GROUP BY Region`와 동일, `Product`는 `NULL`로 표시)
3.  `Product`별 판매량 (`GROUP BY Product`와 동일, `Region`은 `NULL`로 표시)
4.  전체 총 판매량 (`GROUP BY` 없는 전체 집계와 동일, `Region`, `Product` 모두 `NULL`로 표시)

**주요 특징 및 장점:**

* **유연성:** `ROLLUP`이나 `CUBE`로는 표현하기 어려운 **특정 그룹화 조합만 선택적으로 집계**할 수 있습니다. 예를 들어, 지역별 총계와 제품별 총계만 보고 싶고, 지역+제품별 상세 집계는 필요 없는 경우 `GROUPING SETS((Region), (Product))`와 같이 사용할 수 있습니다.
* **쿼리 단순화:** 여러 `UNION ALL` 문을 하나의 `GROUP BY` 절로 통합하여 쿼리를 간결하게 만듭니다.
* **성능:** 데이터베이스는 여러 그룹화 집합을 한 번의 스캔으로 처리하려고 시도하여 여러 개의 개별 쿼리보다 효율적일 수 있습니다.

---

### CUBE

`CUBE`는 `ROLLUP`보다 더 포괄적인 집계 기능을 제공합니다. `GROUP BY` 절에 지정된 **모든 컬럼의 가능한 모든 조합에 대한 소계 및 총계를 생성**합니다. 마치 데이터 큐브의 모든 측면을 보는 것과 같습니다.

**작동 방식:**
`CUBE(컬럼1, 컬럼2, ..., 컬럼N)` 형식으로 사용합니다. `N`개의 컬럼이 주어지면, `2^N`개의 그룹화 집합을 생성합니다.

**예시:**
위의 `Orders` 테이블에 `CUBE(Region, Product)`를 적용하면:

```sql
SELECT
    Region,
    Product,
    SUM(Sales) AS TotalSales
FROM
    Orders
GROUP BY
    CUBE(Region, Product);
```

이 쿼리는 다음과 같은 그룹화 조합에 대한 결과를 생성합니다 (2개의 컬럼이므로 $2^2 = 4$가지 조합):

1.  `(Region, Product)`: 가장 세분화된 그룹
2.  `(Region)`: `Region`별 소계 (`Product`는 `NULL`)
3.  `(Product)`: `Product`별 소계 (`Region`은 `NULL`)
4.  `()`: 전체 총계 (`Region`, `Product` 모두 `NULL`)

**결과 (예시):**

| Region | Product | TotalSales |
| :----- | :------ | :--------- |
| East   | A       | 100        |
| East   | B       | 150        |
| West   | A       | 200        |
| West   | C       | 50         |
| East   | NULL    | 250        | <- Region별 소계
| West   | NULL    | 250        | <- Region별 소계
| NULL   | A       | 300        | <- Product별 소계
| NULL   | B       | 150        | <- Product별 소계
| NULL   | C       | 50         | <- Product별 소계
| NULL   | NULL    | 500        | <- 전체 총계

**주요 특징 및 장점:**

* **포괄적 집계:** 모든 가능한 조합에 대한 집계를 제공하므로 다차원 분석에 매우 적합합니다. 예를 들어, "지역별-제품별", "지역별", "제품별", "전체" 판매량 등 모든 관점에서 데이터를 볼 수 있습니다.
* **탐색적 분석:** 데이터의 모든 가능한 집계 수준을 한 번에 확인하고 싶을 때 유용합니다.
* `ROLLUP`과 달리 컬럼의 순서에 영향을 받지 않습니다. `CUBE(A, B)`와 `CUBE(B, A)`는 동일한 결과를 생성합니다.

---

### ROLLUP, CUBE, GROUPING SETS 비교

| 특징           | ROLLUP(A, B, C)                                                | CUBE(A, B, C)                                                            | GROUPING SETS((A, B), (A), (C))                                         |
| :------------- | :------------------------------------------------------------- | :----------------------------------------------------------------------- | :---------------------------------------------------------------------- |
| **목적** | 계층적 집계 (소계, 총계)                                       | 모든 가능한 조합의 집계 (다차원 분석)                                    | 특정 그룹화 조합의 선택적 집계                                          |
| **생성 조합** | $(A, B, C), (A, B), (A), ()$                                   | $(A, B, C), (A, B), (A, C), (B, C), (A), (B), (C), ()$                    | $(A, B), (A), (C)$ (사용자가 명시한 조합만)                           |
| **컬럼 순서** | 중요 (순서에 따라 계층이 결정됨)                               | 중요하지 않음                                                            | 명시적으로 지정한 조합에 따라 다름                                      |
| **예상 결과 수** | $N+1$ (N은 컬럼 수)                                            | $2^N$ (N은 컬럼 수)                                                      | 사용자가 명시한 그룹화 집합의 수                                        |
| **활용 시나리오** | 조직 구조, 시간(년, 월, 일), 지리적 계층 등 **계층적 데이터** 분석 | 제품-지역-시간 등 **다차원적이고 상호 독립적인 차원** 간의 분석         | 특정 보고서에 필요한 **정확한 집계 수준**만 필요할 때                   |

---

### 그 외의 GROUP BY 확장 기능

SQL 표준에는 `ROLLUP`, `CUBE`, `GROUPING SETS`가 가장 널리 사용되는 `GROUP BY` 확장 기능입니다. 특정 데이터베이스 시스템에서는 추가적인 기능을 제공할 수도 있지만, 이 세 가지가 대부분의 분석 및 보고서 요구 사항을 충족합니다.

* **`GROUPING_ID()` (SQL Server, Oracle 등):**
    `GROUPING()` 함수와 유사하지만, 여러 컬럼에 대한 `GROUPING` 값들을 비트마스크 형태로 조합하여 하나의 정수로 반환합니다. 어떤 컬럼들이 소계/총계 그룹에 포함되었는지(`1`) 또는 실제 데이터 그룹인지(`0`)를 더 쉽게 식별할 수 있도록 해줍니다.

    예를 들어, `GROUPING_ID(Region, Product)`는:
    * `(Region, Product)` 그룹: `00` (이진수) -> `0` (십진수)
    * `(Region)` 소계 그룹: `01` (이진수) -> `1` (십진수) (Product가 롤업됨)
    * `(Product)` 소계 그룹: `10` (이진수) -> `2` (십진수) (Region이 롤업됨)
    * `()` 총계 그룹: `11` (이진수) -> `3` (십진수) (둘 다 롤업됨)

이러한 `GROUP BY` 확장 기능들은 데이터 분석가가 복잡한 집계 쿼리를 작성하는 데 드는 시간과 노력을 크게 줄여주고, 효율적인 방식으로 다양한 수준의 요약 정보를 얻을 수 있도록 돕습니다. 어떤 기능을 사용할지는 분석 목표와 데이터의 특성에 따라 결정됩니다.
