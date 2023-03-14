/* eslint-disable */
declare module '*.vue' {
  import type { DefineComponent } from 'vue'
  const component: DefineComponent<{}, {}, any>
  import VueRouter, { Route } from 'vue-router'

  declare module 'vue/types/vue' {
    interface Vue {
      $router: VueRouter
    }
  }
  export default component
}
