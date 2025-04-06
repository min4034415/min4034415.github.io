---
title: "8장 컴포넌트 심화"
date: 2025-04-06
tags: []
author: "이의민"
---

# 8장 컴포넌트 심화

## 8.1 단일 파일 컴포넌트에서의 스타일

### 8.1.1 범위 CSS

```vue
<!-- MyComponent.vue -->
<template>
  <p class="text">Hello</p>
</template>
<style scoped>
.text { color: blue; }
</style>
```

`scoped` 속성은 CSS를 해당 컴포넌트에만 적용되도록 제한합니다.

### 8.1.2 CSS 모듈

```vue
<!-- MyComponent.vue -->
<template>
  <p :class="$style.text">Hello</p>
</template>
<style module>
.text { color: red; }
</style>
```

CSS 모듈은 스타일을 모듈화해 클래스 이름 충돌을 방지합니다.

## 8.2 슬롯

### 8.2.1 슬롯 사용 전의 컴포넌트

```vue
<!-- StaticComponent.vue -->
<template>
  <div>고정된 내용</div>
</template>
```

슬롯 없이 컴포넌트는 고정된 내용만 표시합니다.

### 8.2.2 슬롯의 기본 사용법

```vue
<!-- SlotComponent.vue -->
<template>
  <div><slot></slot></div>
</template>
<!-- 사용 -->
<SlotComponent>Hello World!</SlotComponent>
```

슬롯은 부모에서 자식 컴포넌트로 콘텐츠를 주입합니다.

### 8.2.3 명명된 슬롯

```vue
<!-- NamedSlot.vue -->
<template>
  <div><slot name="header"></slot></div>
</template>
<!-- 사용 -->
<NamedSlot><template #header>Header</template></NamedSlot>
```

명명된 슬롯은 특정 위치에 콘텐츠를 삽입할 수 있게 합니다.

### 8.2.4 범위 슬롯

```vue
<!-- ScopedSlot.vue -->
<template>
  <slot :data="item"></slot>
</template>
<script>
export default {
  data: () => ({ item: 'Scoped' })
}
</script>
<!-- 사용 -->
<ScopedSlot v-slot="{ data }">{{ data }}</ScopedSlot>
```

범위 슬롯은 자식 데이터를 부모에서 활용할 수 있게 합니다.

## 8.3 동적 컴포넌트

```vue
<!-- App.vue -->
<template>
  <component :is="currentComponent"></component>
</template>
<script>
import CompA from './CompA.vue'
export default {
  data: () => ({ currentComponent: CompA })
}
</script>
```

동적 컴포넌트는 `:is`로 런타임에 컴포넌트를 전환합니다.

## 8.4 컴포넌트에서의 v-model 디렉티브

```vue
<!-- InputComponent.vue -->
<template>
  <input v-model="inputValue" @input="$emit('update:modelValue', $event.target.value)">
</template>
<script>
export default {
  props: ['modelValue'],
  computed: {
    inputValue: {
      get() { return this.modelValue },
      set(value) { this.$emit('update:modelValue', value) }
    }
  }
}
</script>
```

`v-model`은 컴포넌트에서 양방향 데이터 바인딩을 지원합니다.

## 8.5 provide, inject를 이용한 공용데이터 사용

```vue
<!-- Parent.vue -->
<script>
export default {
  provide: { sharedData: '공유 데이터' }
}
</script>
<!-- Child.vue -->
<script>
export default {
  inject: ['sharedData']
}
</script>
```

`provide`와 `inject`는 컴포넌트 간 공용 데이터를 전달합니다.

## 8.6 텔레포트

```vue
<!-- TeleportComponent.vue -->
<template>
  <teleport to="body">
    <div>모달</div>
  </teleport>
</template>
```

텔레포트는 DOM의 다른 위치로 컴포넌트를 이동시킵니다.

## 8.7 비동기 컴포넌트

```vue
<!-- App.vue -->
<script>
import { defineAsyncComponent } from 'vue'
export default {
  components: {
    AsyncComp: defineAsyncComponent(() => import('./AsyncComp.vue'))
  }
}
</script>
```

비동기 컴포넌트는 필요할 때만 로드해 성능을 최적화합니다.

## 8.8 마무리

컴포넌트 심화 기능을 활용하면 Vue 애플리케이션을 더 유연하고 강력하게 만들 수 있습니다.