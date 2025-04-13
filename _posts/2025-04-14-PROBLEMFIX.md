---
title: "고쳤다 드디어 그리고 ESLINT 설치"
date: 2025-04-14
tags: []
author: "이의민"
---
그게 말이다 프로젝트 진행중에 데이터 저장시에 웹사이트가 재로딩되는 이슈가 있었는데 바로 db.json 문제였다. vite.config.js 파일에 

```javascript
import eslint from "vite-plugin-eslint"
import path from 'path'; 

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue(),  tailwindcss(), eslint()],
  server: {
    watch: {
      // Ignore the db.json file
      ignored: [
        // Use an absolute path or a relative path from the project root
        path.resolve(__dirname, 'db.json'),
        // Or if db.json is in the root:
        // '**/db.json'
      ],
    },
  },
})
```
이리 했었어야 했는데 안해서 그랬던 것 같다.
db.json 문제가 아니라 바뀐거 계속 체크해서 아니면 리프레쉬 되기 때문에 watch가 문제였는지 뷰 프로젝트 자체가 문제였는지는 잘 모르겠다.

그리고 npm init @eslint/config  이거하면 설치할 수 있다. 콘솔에도 에러 로그가 보인다.
