import { createRouter, createWebHistory } from "vue-router";
import Menu from "../components/Menu.vue";
import Welcome from "../components/Welcome.vue";
import homepage from "../components/pages/Homepage.vue";
import rules from "../components/rules.vue";


const routes = [
  { path: '/', name: 'Welcome', component: Welcome },
  { path: '/menu', name: 'Menu', component: Menu },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});


export default router;