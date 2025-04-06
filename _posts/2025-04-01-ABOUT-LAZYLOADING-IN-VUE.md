---
title: "뷰 레이지 로딩"
date: 2025-04-01
category: [Performance Optimization, Lazy Loading]
tags: [VUE]
author: "이의민"
---
Vue.js에서 지연 로딩(Lazy Loading)을 설명하겠습니다. `defineAsyncComponent`를 사용하는 방법과 `router.js`에서 다른 방식으로 구현하는 두 가지 주요 접근 방식을 중심으로 설명하겠습니다.

---

### 1. `defineAsyncComponent`를 사용한 지연 로딩
`defineAsyncComponent`는 Vue 3에서 제공하는 유틸리티로, 비동기적으로 로드되는 컴포넌트를 정의할 수 있게 해줍니다. 이는 애플리케이션을 더 작은 조각으로 나누어 초기 로드 시간을 개선하며, 컴포넌트가 필요할 때만 로드되도록 합니다.

#### 작동 방식
컴포넌트를 파일 상단에서 동기적으로 가져오는 대신, `defineAsyncComponent`를 사용하여 컴포넌트가 렌더링될 때만 가져오도록 정의합니다.

#### 예제
```javascript–
import { defineAsyncComponent } from 'vue';

// 비동기 컴포넌트 정의
const AsyncComponent = defineAsyncComponent(() =>
  import('./components/MyComponent.vue')
);

// 컴포넌트에 등록
export default {
  components: {
    AsyncComponent
  }
};
```

#### 로딩 및 오류 상태 추가
사용자 경험을 개선하기 위해 로딩 컴포넌트와 오류 컴포넌트를 추가할 수도 있습니다:
```javascript
const AsyncComponent = defineAsyncComponent({
  loader: () => import('./components/MyComponent.vue'),
  loadingComponent: LoadingSpinner, // 로딩 중일 때 표시
  errorComponent: ErrorDisplay,    // 로딩 실패 시 표시
  delay: 200,                      // 로딩 컴포넌트 표시 전 지연 시간 (ms)
  timeout: 3000                    // 로딩 타임아웃 (ms)
});
```

#### 사용 시점
- 즉시 필요하지 않은 컴포넌트(예: 모달, 탭, 드물게 사용되는 기능)에 적합.
- 초기 번들 크기를 줄이고 성능을 개선할 때 유용.

---

### 2. `router.js`에서 동적 임포트를 사용한 지연 로딩
Vue Router에서 지연 로딩은 경로 컴포넌트를 사용자가 해당 경로를 방문할 때만 로드하도록 하는 일반적인 방법입니다. 이는 JavaScript의 동적 `import()` 문법을 활용하며, Vue Router에서 기본적으로 지원됩니다.

#### 작동 방식
모든 경로 컴포넌트를 미리 가져오는 대신, 동적 임포트를 반환하는 함수로 컴포넌트를 정의합니다. 사용자가 해당 경로로 이동할 때만 브라우저가 컴포넌트 코드를 가져옵니다.

#### `router.js` 예제
```javascript
import { createRouter, createWebHistory } from 'vue-router';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('./views/Home.vue') // 지연 로딩
  },
  {
    path: '/about',
    name: 'About',
    component: () => import('./views/About.vue') // 지연 로딩
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
```

#### 정적 임포트와의 차이점
정적 임포트를 사용하면 모든 컴포넌트가 처음에 번들링되어 로드됩니다:
```javascript
import Home from './views/Home.vue';
import About from './views/About.vue';

const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/about', name: 'About', component: About }
];
```
이 방식은 초기 로드 시간을 늘립니다. 반면 동적 임포트(`() => import()`)를 사용하면 각 경로의 컴포넌트가 별도의 청크로 분리되어 필요할 때만 로드됩니다.

#### 장점
- 초기 번들 크기 감소.
- 첫 번째 경로 방문 시 페이지 로드 속도 향상.
- 많은 경로가 있는 대규모 애플리케이션의 성능 개선.

---

### 주요 차이점
| 기능                    | `defineAsyncComponent`                | `router.js`에서 지연 로딩           |
|-------------------------|---------------------------------------|-------------------------------------|
| **목적**                | 개별 컴포넌트를 지연 로딩             | 전체 경로 컴포넌트를 지연 로딩       |
| **적용 범위**           | 컴포넌트 정의 내에서 사용              | 라우팅 설정에서 사용                 |
| **세분화**              | 세밀한 수준(특정 컴포넌트)             | 경로 수준(전체 페이지/뷰)           |
| **로딩/오류 상태**      | 기본 지원                             | 수동 구현 필요                      |
| **사용 사례**           | 모달, 위젯, 선택적 UI 부분            | 경로에 연결된 전체 페이지           |

---

### 두 접근 방식 결합
실제 애플리케이션에서는 두 방법을 함께 사용할 수 있습니다:
- `defineAsyncComponent`를 사용해 페이지 내 무거운 컴포넌트(예: 차트 라이브러리)를 지연 로딩.
- `router.js`에서 경로를 지연 로딩하여 앱을 페이지 단위로 분리.

#### 결합 예제
```javascript
// router.js
const routes = [
  {
    path: '/dashboard',
    component: () => import('./views/Dashboard.vue') // 지연 로딩된 경로
  }
];

// Dashboard.vue
import { defineAsyncComponent } from 'vue';
export default {
  components: {
    Chart: defineAsyncComponent(() => import('./components/Chart.vue')) // 지연 로딩된 컴포넌트
  }
};
```

이렇게 하면 `Dashboard` 경로는 방문할 때만 로드되고, `Chart` 컴포넌트는 렌더링될 때만 로드됩니다.

---

두 방법 모두 Webpack이나 Vite 같은 도구를 통해 코드 분할(code-splitting)을 활용하여 별도의 JavaScript 청크를 생성합니다. 이는 초기 페이로드를 줄이고 Vue 앱의 성능을 향상시킵니다. 더 자세한 예제나 설명이 필요하면 말씀해주세요!
