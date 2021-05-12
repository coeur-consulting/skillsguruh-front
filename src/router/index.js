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
    beforeEnter: (to, from, next) => {
      let user = localStorage.getItem("typeOrg");
      if (!user) {
        next();
      } else {
        next("/organization");
      }
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
          typeOrg: true,
        },
      },
      {
        path: "admins",
        name: "organization admins",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationadmins" */ "@/components/Organization/admins.vue"
            ),
        },
        meta: {
          typeOrg: true,
        },
      },
      {
        path: "admin",
        name: "organization admin",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationadmin" */ "@/components/Organization/admin.vue"
            ),
        },
        meta: {
          typeOrg: true,
        },
      },
      {
        path: "facilitators",
        name: "organization facilitators",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationfacilitators" */ "@/components/Organization/facilitators.vue"
            ),
        },
        meta: {
          typeOrg: true,
        },
      },
      {
        path: "facilitator",
        name: "organization facilitator",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationfacilitator" */ "@/components/Organization/facilitator.vue"
            ),
        },
        meta: {
          typeOrg: true,
        },
      },
      {
        path: "learners",
        name: "organization learners",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationlearners" */ "@/components/Organization/learners.vue"
            ),
        },
        meta: {
          typeOrg: true,
        },
      },
      {
        path: "learner",
        name: "organization learner",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationlearner" */ "@/components/Organization/learner.vue"
            ),
        },
        meta: {
          typeOrg: true,
        },
      },
      {
        path: "schedule",
        name: "organization schedule",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationschedule" */ "@/components/Organization/schedule.vue"
            ),
        },
        meta: {
          typeOrg: true,
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
