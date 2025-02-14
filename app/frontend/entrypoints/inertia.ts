import './app.css'
import { createInertiaApp } from '@inertiajs/vue3'
import { createApp,  h } from 'vue'
import type { DefineComponent } from 'vue'
import DefaultLayout from '~/layouts/DefaultLayout.vue'

createInertiaApp({
  // Set default page title
  // see https://inertia-rails.netlify.app/guide/title-and-meta
  //
  // title: title => title ? `${title} - App` : 'App',

  // Disable progress bar
  //
  // see https://inertia-rails.netlify.app/guide/progress-indicators
  // progress: false,

  resolve: (name) => {
    const pages = import.meta.glob<DefineComponent>('../pages/**/*.vue', { eager: true })
    // return pages[`../pages/${name}.vue`]

    // To use a default layout, import the Layout component
    // and use the following lines.
    // see https://inertia-rails.netlify.app/guide/pages#default-layouts
    //
    const page = pages[`../pages/${name}.vue`]
    // page.default.layout ||= (page) => createElement(Layout, null, page)
    page.default.layout = page.default.layout || DefaultLayout
    return page
  },

  setup({ el, App, props, plugin }) {
    createApp({ render: () => h(App, props) })
      .use(plugin)
      .mount(el)
  },
})
