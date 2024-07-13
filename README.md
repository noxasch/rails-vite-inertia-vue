# Rails InertiaJs Vite Vue3 + tailwindcss
- Inertia is a javascript library that allows to use any front end framework with any backend. It support Laravel, Rails and JS framework, and other backend framework.

- Inertiajs replace hotwire (which transfer HTML) and transfer json and interact with front end framework. Thus allowing to wriate a modern SPA monolith without creating an API endpoints when it's not required/

## Installation
- Rails
- Vite Rails (gem)

```sh
rails new <PROJECT_NAME> --minimal -T
rails new <PROJECT_NAME> --minimal --skip-test
bundle add vite_rails inertia_rails inertia_rails-contrib
bundle exec vite install
bundle exec rails g inertia:install # this will create necessary file

pnpm add -D vite-plugin-full-reload @vitejs/plugin-vue typescript
pnpm add @inertiajs/vue3 @vue/server-renderer vue

pnpm add -D tailwindcss autoprefixer postcss
npx tailwindcss init -p
```

Setting up tailwindcssd
```js
// postcss.config.js
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}

// tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: ["./app/**/*.{html,vue}"],
  theme: {
    extend: {},
  },
  plugins: [],
}


```

create `frontend/entrypoints/application.css`
```css
/* frontend/entrypoints/application.css */
@tailwind base;
@tailwind components;
@tailwind utilities;

```

### Making sure vue and rails works with HMR

```js
// vite.config.js
import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from 'vite-plugin-full-reload'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    FullReload(['config/routes.rb', 'app/views/*/**', 'app/frontend/*/**'], { delay: 200}),
    vue(),
  ],
})
```


```jsonc
{
  "development": {
    "autoBuild": true,
    "host": "127.0.0.1", // make sure hot reload works
    "publicOutputDir": "vite-dev",
    "port": 3036
  },
}
```

### set tsconfig


```jsonc
// app/tscofig.json
{
  "compilerOptions": {
    "target": "ESNext",
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "isolatedModules": true,
    "removeComments": true,
    "esModuleInterop": true,
    "strictNullChecks": true,
    "allowSyntheticDefaultImports": true,
    "forceConsistentCasingInFileNames": true,
    "strictPropertyInitialization": true,
    "experimentalDecorators": true,
    "noImplicitAny": true,
    "strictBindCallApply": true,
    "strictFunctionTypes": true,
    "noImplicitThis": true,
    "skipLibCheck": true,
    "moduleResolution": "Bundler",
    "lib": ["DOM", "ESNext", "DOM.Iterable", "ES2020"],
    "types": ["vite/client"],
    "baseUrl": ".",
    "jsx": "preserve",
    "module": "ESNext",
    "jsxImportSource": "vue",
    "paths": {
      "~/*": ["./*"],
    },
  },
  "ts-node": {
    "swc": true
  },
  "include": ["./**/*.ts", "./**/*.vue"],
}

```

### Entrypoint

```ts
// frontend/entrypoints/app.ts
// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Example: Load Rails libraries in Vite.
//
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'

```


### base html
```html
<!DOCTYPE html>
<html>
  <head>
    <title>RailsInertiaVue</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <!--stylesheet_link_tag "application" -->
    <%= vite_client_tag %>
    <%= vite_typescript_tag 'inertia' %>

    <%= inertia_headers %>
    <!-- vite_javascript_tag 'application' -->
    <%= vite_typescript_tag 'app' %>
    <%= vite_stylesheet_tag 'app' %>
    <!--
      If using a TypeScript entrypoint file:
        vite_typescript_tag 'application'

      If using a .jsx or .tsx entrypoint, add the extension:
        vite_javascript_tag 'application.jsx'

      Visit the guide for more information: https://vite-ruby.netlify.app/guide/rails
    -->

  </head>

  <body>
    <%= yield %>
  </body>
</html>

```

## Development (SPA)
- in development mode, we need to run both rails and vite server

```sh
bundle exec rails s

bundle exec vite dev

# or use foreman - but cannot use rails debugger
foreman start -f Procfile.dev
```

## Deployment (SPA)

```sh
RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile
RAILS_ENV=production bundle exec rails s
```

## SSR

- currently will have issue when have window or document reference in SSR

### Deployment (SSR)
- deployment server must have nodejs and run the ssr server

```sh
bundle exec vite build --ssr

bundle exec vite ssr
```

## Project Structure
This is a monotlith monorepo project that utilized both ruby and javascript.

- InertiaJs exist on both side of the app which act as a glue between Rails and Vue.
- With InertiaJs means you don't need hotwire and send inertia json instead of HTML.

### Backend
- As any rails app, everything on backend is in the repo except for `app/frontend`.
- There is only 1 erb file in `app/views` folder which act as the entry point for inertia app.
- data can be shared using with the front end using the `inertia_share` function and `props` with `render inertia`.
- As any web app, the backend should handle the authentication and authorization.

### Front End
- use inertia `Link` component for navigation
- inertia handle CSRF token and session by default, hence there should no issue
- when using `fetch` make sure to use `same-origin` to make sure there are no CSRF mismatch or use `axios`
- for built in routing support, can utilize library such as [js-routes](https://github.com/railsware/js-routes), using shared data or even raw url.

### MailHog
Testing email locally in development

- require: golang

```sh
go install github.com/mailhog/MailHog@latest

go/bin/MailHog

# the UI should be available at:
# http://localhost:8025/
```
## TODO
- [x] CSRF handling - handle by default in inertia
- [x] routing - only some issue during sign in
- [x] session auth - devise - no issue with inertia
- [x] flash - via shared data
- [x] test with rspec
- [ ] user permission with cancancan
- [ ] Inertia error handling
 
## Reference
- [InertialJS Rails](https://inertia-rails.netlify.app)
- [Vite Ruby](https://vite-ruby.netlify.app/)
- [Vite Ruby](https://vite-ruby.netlify.app/)
- [InertiaJs](https://inertiajs.com/)
- [Inertia Rails](https://github.com/inertiajs/inertia-rails)
