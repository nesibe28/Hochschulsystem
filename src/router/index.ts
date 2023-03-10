import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import Home from '../views/Home.vue'
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

  // TODO: for 404 errors
  // {
  //   path: '/:catchAll(.*)',
  //   component: NotFoundComponent,
  //   name: 'NotFound',
  // },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),

  routes,
})

export default router
