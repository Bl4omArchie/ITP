import { createRouter, createWebHistory } from "vue-router";
import Menu from "../components/Menu.vue";
import Welcome from "../components/Welcome.vue";


const routes = [
  { path: '/', name: 'Welcome', component: Welcome },
  { path: '/menu', name: 'Menu', component: Menu },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});


export default router;