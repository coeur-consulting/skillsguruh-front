import Vue from "vue";
import VueRouter from "vue-router";
import Landing from "../views/Landing.vue";
import Header from "../components/Navigation/AppHeader.vue";
import Footer from "../components/Navigation/AppFooter.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Landing",
    components: {
      header: Header,
      default: Landing,
      footer: Footer,
    },
  },
  {
    path: "/register",
    name: "Register",
    components: {
      default: () =>
        import(/* webpackChunkName: "Register" */ "../views/Auth/Register.vue"),
    },
  },
  {
    path: "/login",
    name: "Login",
    components: {
      default: () =>
        import(/* webpackChunkName: "Login" */ "../views/Auth/Login.vue"),
    },
  },
  {
    path: "/about",
    name: "About",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "about" */ "../views/About.vue"),
      footer: Footer,
    },
  },
  {
    path: "/contact",
    name: "Contact",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "contact" */ "../views/Contact.vue"),
      footer: Footer,
    },
  },

  {
    path: "/organization",

    components: {
      default: () =>
        import(
          /* webpackChunkName: "organization" */ "../views/Organization.vue"
        ),
    },

    children: [
      {
        path: "",
        name: "organization dashboard",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationdashboard" */ "@/components/Organization/home.vue"
            ),
        },
        meta: {
          authOrg: true,
        },
      },
    ],
  },

  {
    path: "*",
    name: "Not Found",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "404pages" */ "../views/NotFound.vue"),
      footer: Footer,
    },
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
