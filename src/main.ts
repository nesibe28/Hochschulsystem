import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import mitt from 'mitt';
const emitter = mitt();

import './assets/css/style.css'

import { createPinia } from 'pinia'

const app = createApp(App);
app.config.globalProperties.emitter = emitter;

app.use(router).use(createPinia()).mount('#app')

