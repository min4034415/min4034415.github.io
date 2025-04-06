---
title: "10장 vue-router"
date: 2025-04-06
tags: [VUE]
author: "이의민"
---

# 10장 vue-router를 이용한 라우팅

## 10.1 vue-router란?

vue-router는 Vue.js에서 페이지 간 이동을 관리하는 공식 라우팅 라이브러리입니다.

## 10.2 vue-router의 기본 사용법

```vue
<!-- main.js -->
import { createRouter, createWebHistory } from 'vue-router'
const router = createRouter({
  history: createWebHistory(),
  routes: [{ path: '/', component: () => import('./Home.vue') }]
})
```

vue-router를 설정해 기본 라우팅을 시작합니다.

## 10.3 router 객체와 currentRoute 객체

```vue
<script setup>
import { useRouter, useRoute } from 'vue-router'
const router = useRouter()
const route = useRoute()
console.log(route.path) // 현재 경로
</script>
```

`useRouter`와 `useRoute`로 라우팅 정보에 접근합니다.

## 10.4 동적 라우트

```vue
<!-- router/index.js -->
const routes = [{ path: '/user/:id', component: () => import('./User.vue') }]
<!-- User.vue -->
<template>
  <p>User ID: {{ $route.params.id }}</p>
</template>
```

동적 라우트는 URL 파라미터로 유연한 경로를 처리합니다.

## 10.5 중첩 라우트

```vue
<!-- router/index.js -->
const routes = [{
  path: '/parent',
  component: () => import('./Parent.vue'),
  children: [{ path: 'child', component: () => import('./Child.vue') }]
}]
```

중첩 라우트는 계층적 페이지 구조를 만듭니다.

## 10.6 명명된 라우트와 명명된 뷰

### 10.6.1 명명된 라우트

```vue
<!-- router/index.js -->
const routes = [{ path: '/home', name: 'home', component: () => import('./Home.vue') }]
<!-- 사용 -->
<router-link :to="{ name: 'home' }">Home</router-link>
```

명명된 라우트는 경로 이름을 사용해 이동합니다.

### 10.6.2 명명된 뷰

```vue
<!-- App.vue -->
<template>
  <router-view name="header"></router-view>
  <router-view></router-view>
</template>
<!-- router/index.js -->
const routes = [{
  path: '/',
  components: { default: () => import('./Main.vue'), header: () => import('./Header.vue') }
}]
```

명명된 뷰는 여러 뷰를 한 페이지에 렌더링합니다.

## 10.7 프로그래밍 방식의 라우팅 제어

### 10.7.1 라우터 객체의 메서드

```vue
<script setup>
import { useRouter } from 'vue-router'
const router = useRouter()
const goHome = () => router.push('/')
</script>
```

`router.push`로 프로그래밍 방식으로 경로를 이동합니다.

### 10.7.2 내비게이션 가드

```vue
<!-- router/index.js -->
router.beforeEach((to, from) => {
  if (to.path === '/admin') return '/login'
})
```

내비게이션 가드는 라우팅 전후 동작을 제어합니다.

### 10.7.3 내비게이션 가드 적용하기

```vue
<script>
export default {
  beforeRouteEnter(to, from, next) {
    next()
  }
}
</script>
```

컴포넌트 내 가드로 특정 경로 접근을 관리합니다.

## 10.8 히스토리 모드와 404 라우트

### 10.8.1 히스토리 모드

```vue
<!-- router/index.js -->
import { createRouter, createWebHistory } from 'vue-router'
const router = createRouter({ history: createWebHistory() })
```

히스토리 모드는 깔끔한 URL을 제공합니다.

### 10.8.2 404 라우트

```vue
<!-- router/index.js -->
const routes = [{ path: '/:pathMatch(.*)*', component: () => import('./NotFound.vue') }]
```

404 라우트는 정의되지 않은 경로를 처리합니다.

## 10.9 라우트 정보를 속성으로 연결하기

```vue
<!-- User.vue -->
<template>
  <p>User: {{ userId }}</p>
</template>
<script setup>
defineProps(['userId'])
</script>
<!-- router/index.js -->
const routes = [{ path: '/user/:userId', props: true, component: () => import('./User.vue') }]
```

라우트 파라미터를 속성으로 컴포넌트에 전달합니다.

## 10.10 지연 로딩

### 10.10.1 지연 로딩 적용하기

```vue
<!-- router/index.js -->
const routes = [{ path: '/', component: () => import('./Home.vue') }]
```

지연 로딩은 컴포넌트를 필요할 때만 로드합니다.

### 10.10.2 Suspense 컴포넌트

```vue
<template>
  <Suspense>
    <template #default><AsyncComp /></template>
    <template #fallback>Loading...</template>
  </Suspense>
</template>
```

`Suspense`는 비동기 컴포넌트 로딩 중 대체 UI를 표시합니다.

### 10.10.3 청크 스플릿팅

```vue
<!-- router/index.js -->
const routes = [{ path: '/', component: () => import(/* webpackChunkName: "home" */ './Home.vue') }]
```

청크 스플릿팅은 코드를 분할해 초기 로드 속도를 개선합니다.

## 10.11 라우팅과 인증 처리

### 10.11.1 토큰 기반 인증 개요

토큰 기반 인증은 사용자 인증을 위해 토큰을 활용합니다.

### 10.11.2 내비게이션 가드를 이용한 로그인 화면 전환

```vue
<!-- router/index.js -->
router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth && !localStorage.getItem('token')) next('/login')
  else next()
})
```

가드로 인증 여부를 확인해 로그인 화면으로 전환합니다.

## 10.12 마무리

vue-router를 활용하면 SPA에서 강력한 라우팅을 구현할 수 있습니다.