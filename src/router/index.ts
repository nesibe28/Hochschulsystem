import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import Home from '../views/Home.vue'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    name: 'Home',
    component: Home,
  },
  {
    path: '/login',
    name: 'Login',
    component: () =>
        import(/* webpackChunkName: "login" */ '../views/Login.vue'),
  },
  {
    path: '/modules',
    name: 'Modules',
    component: () =>
        import(/* webpackChunkName: "modules" */ '../views/Modules.vue'),
  },
  {
    path: '/semester-fees',
    name: 'SemesterFees',
    component: () =>
        import(/* webpackChunkName: "modules" */ '../views/SemesterFees.vue'),
  },
  {
    path: '/wave-me',
    name: 'WaveMe',
    component: () =>
      import(/* webpackChunkName: "wave" */ '../views/WaveMe.vue'),
  },
  {
    path: '/lucky-number',
    name: 'LuckyNumber',
    component: () =>
      import(/* webpackChunkName: "wave" */ '../views/LuckyNumber.vue'),
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ '../views/About.vue'),
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),

  routes,
})

export default router
