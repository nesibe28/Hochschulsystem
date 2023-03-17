import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import Login from '../views/Login.vue'


const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    name: 'Home',
    component: Login,
  },
  {
    path: '/register',
    name: 'Registration',
    component: () =>
        import(/* webpackChunkName: "modules" */ '../views/Registration.vue'),
  },
  {
    path: '/modules',
    name: 'Modules',
    component: () =>
        import(/* webpackChunkName: "modules" */ '../views/Modules.vue'),
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () =>
        import(/* webpackChunkName: "modules" */ '../views/Profile.vue'),
  },
  {
    path: '/semester-fees',
    name: 'SemesterFees',
    component: () =>
        import(/* webpackChunkName: "modules" */ '../views/SemesterFees.vue'),
  },
  {
    path: '/profs-page',
    name: 'ProfsPage',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ '../views/ProfsPage.vue'),
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),

  routes,
})

export default router
