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
    meta: {
      title: "Home | Nzukoor",
    },
  },

  {
    path: "/register",
    name: "Register",
    components: {
      default: () =>
        import(/* webpackChunkName: "Register" */ "../views/Auth/Register.vue"),
    },
    meta: {
      title: "Register | Nzukoor",
    },
  },
  {
    path: "/auth/:provider/callback",
    name: "Social login",
    components: {
      default: () =>
        import(
          /* webpackChunkName: "Register" */ "../views/Auth/SocialLogin.vue"
        ),
    },
  },
  {
    path: "/login",
    name: "Login",
    components: {
      default: () =>
        import(/* webpackChunkName: "Login" */ "../views/Auth/Login.vue"),
    },
    meta: {
      title: "Login | Nzukoor",
    },
    beforeEnter: (to, from, next) => {
      if (localStorage.getItem("authMember")) {
        let user = localStorage.getItem("authMember");
        if (!user) {
          next();
        } else {
          next("/member");
        }
      } else if (localStorage.getItem("authFacilitator")) {
        let user = localStorage.getItem("authFacilitator");
        if (!user) {
          next();
        } else {
          next("/facilitator");
        }
      } else if (localStorage.getItem("authAdmin")) {
        let user = localStorage.getItem("authAdmin");
        if (!user) {
          next();
        } else {
          next("/administrator");
        }
      } else if (localStorage.getItem("authOrg")) {
        let user = localStorage.getItem("authOrg");
        if (!user) {
          next();
        } else {
          next("/organization");
        }
      } else {
        next();
      }
    },
  },
  {
    path: "/Admin/login",
    name: "Admin Login",
    components: {
      default: () =>
        import(/* webpackChunkName: "Login" */ "../views/Auth/OrgLogin.vue"),
    },
    meta: {
      title: "Admin Login | Nzukoor",
    },
    beforeEnter: (to, from, next) => {
      if (localStorage.getItem("authAdmin")) {
        let user = localStorage.getItem("authAdmin");
        if (!user) {
          next();
        } else {
          next("/administrator");
        }
      } else if (localStorage.getItem("authOrg")) {
        let user = localStorage.getItem("authOrg");
        if (!user) {
          next();
        } else {
          next("/organization");
        }
      } else {
        next();
      }
    },
  },
  {
    path: "/transaction",
    name: " transaction",
    components: {
      header: Header,
      default: () =>
        import(
          /* webpackChunkName: "transaction" */ "@/components/transaction.vue"
        ),
      footer: Footer,
    },
    meta: {
      title: "Transaction | Nzukoor",
    },
  },
  {
    path: "/explore",
    name: "Explore",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "explore" */ "../views/Explore.vue"),
      footer: Footer,
    },
    meta: {
      title: "Explore | Nzukoor",
    },
  },
  {
    path: "/explore/facilitators",
    name: "Explore facilitators",
    components: {
      header: Header,
      default: () =>
        import(
          /* webpackChunkName: "explorefacilitators" */ "../views/Facilitators.vue"
        ),
      footer: Footer,
    },
    meta: {
      title: "Explore Facilitators| Nzukoor",
    },
  },
  {
    path: "/explore/members",
    name: "Explore Members",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "exploreMembers" */ "../views/Members.vue"),
      footer: Footer,
    },
    meta: {
      title: "Explore Members| Nzukoor",
    },
  },
  {
    path: "/explore/courses",
    name: "ExploreCourses",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "ExploreCourses" */ "../views/Courses.vue"),
      footer: Footer,
    },
    meta: {
      title: "Explore courses | Nzukoor",
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
    meta: {
      title: "About | Nzukoor",
    },
  },
  {
    path: "/explore/interests/:id",
    name: "Interest",
    components: {
      header: Header,
      default: () =>
        import(
          /* webpackChunkName: "interests" */ "../views/InterestContent.vue"
        ),
      footer: Footer,
    },
    meta: {
      title: "Interests | Nzukoor",
    },
  },
  {
    path: "/explore/feed/view/:id",
    name: "View Feed",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "viewfeed" */ "../views/viewfeed.vue"),
      footer: Footer,
    },
    meta: {
      title: "Feed | Nzukoor",
    },
  },
  {
    path: "/explore/discussion/:id",
    name: "Discussion",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "about" */ "../views/Discussion.vue"),
      footer: Footer,
    },
    meta: {
      title: "Discussion | Nzukoor",
    },
  },
  {
    path: "/explore/event/:id",
    name: "Event",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "about" */ "../views/Event.vue"),
      footer: Footer,
    },
    meta: {
      title: "Event | Nzukoor",
    },
  },
  {
    path: "/order",
    name: "Order",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "about" */ "@/components/order"),
      footer: Footer,
    },
    meta: {
      title: "Order | Nzukoor",
    },
  },
  {
    path: "/explore/feeds",
    name: "Feeds",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "feeds" */ "../views/Feeds.vue"),
      footer: Footer,
    },
    meta: {
      title: "Feeds | Nzukoor",
    },
  },
  {
    path: "/explore/feed/:interest",
    name: "Feed",
    components: {
      header: Header,
      default: () => import(/* webpackChunkName: "feed" */ "../views/Feed.vue"),
      footer: Footer,
    },
    meta: {
      title: "Feed | Nzukoor",
    },
  },
  {
    path: "/explore/events",
    name: "Events",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "events" */ "../views/Events.vue"),
      footer: Footer,
    },
    meta: {
      title: "Events | Nzukoor",
    },
  },
  {
    path: "/explore/discussions",
    name: "Discussions",
    components: {
      header: Header,
      default: () =>
        import(
          /* webpackChunkName: "discussions" */ "../views/Discussions.vue"
        ),
      footer: Footer,
    },
    meta: {
      title: "Discussion | Nzukoor",
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
    meta: {
      title: "Contact us | Nzukoor",
    },
  },
  {
    path: "/quiz",
    name: "Quiz",
    components: {
      header: Header,
      default: () => import(/* webpackChunkName: "quiz" */ "../views/Quiz.vue"),
      footer: Footer,
    },
    meta: {
      title: "Quiz | Nzukoor",
    },
  },
  {
    path: "/assessment",
    name: "Assessment",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "Assessment" */ "../views/Assessment.vue"),
      footer: Footer,
    },
    meta: {
      title: "Asseeement | Nzukoor",
    },
  },
  {
    path: "/auth/:provider/callback",
    name: "callback",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "callback" */ "../views/Auth.vue"),
      footer: Footer,
    },
    meta: {
      title: "Loading | Nzukoor",
    },
  },
  {
    path: "/profile/:user/:id",
    name: " User profiles",
    components: {
      header: Header,
      default: () =>
        import(
          /* webpackChunkName: "userprof" */ "@/components/guestfacilitator.vue"
        ),
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
          title: "Home - Organization",
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
          title: "Admins - Organization",
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
          title: "Admin - Organization",
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
          title: "Facilitators - Organization",
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
          title: "Facilitator - Organization",
        },
      },
      {
        path: "members",
        name: "organization members",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationmembers" */ "@/components/Organization/members.vue"
            ),
        },
        meta: {
          typeOrg: true,
          title: "Members - Organization",
        },
      },
      {
        path: "member",
        name: "organization member",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationmember" */ "@/components/Organization/member.vue"
            ),
        },
        meta: {
          typeOrg: true,
          title: "Member - Organization",
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
          title: "Schedule - Organization",
        },
      },
    ],
  },

  {
    path: "/administrator",

    components: {
      default: () =>
        import(
          /* webpackChunkName: "administrator" */ "../views/Administrator.vue"
        ),
    },

    children: [
      {
        path: "",
        name: "administrator dashboard",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratordashboard" */ "@/components/Administrator/home.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Home | Administrator",
        },
      },

      {
        path: "facilitators",
        name: "Administrator facilitators",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorfacilitators" */ "@/components/Administrator/facilitators.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Facilitators | Administrator",
        },
      },
      {
        path: "team",
        name: "Administrator team",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorteam" */ "@/components/Administrator/team.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Team | Administrator",
        },
      },
      {
        path: "question/templates",
        name: "Administrator questions",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorquestions" */ "@/components/Administrator/templates.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Templates | Administrator",
        },
      },
      {
        path: "question/template/:id",
        name: "Administrator template",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorquestionnaireview" */ "@/components/Administrator/Templates/view.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Template | Administrator",
        },
      },
      {
        path: "question/template/edit/:id",
        name: "Administrator templateedit",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratoreditt" */ "@/components/Administrator/Templates/edit.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Edit Template | Administrator",
        },
      },
      {
        path: "questionnaire",
        name: "Administrator questionnaire",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorquestionnaire" */ "@/components/Administrator/Questionnaire/create.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Questionnaire | Administrator",
        },
      },
      {
        path: "questionnaires",
        name: "Administrator questionnaires",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorquestionnaires" */ "@/components/Administrator/Questionnaire/index.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Questionnaires | Administrator",
        },
      },
      {
        path: "questionnaire/edit/:id",
        name: "Administrator questionnairesedit",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorquestionnaireedit" */ "@/components/Administrator/Questionnaire/edit.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Edit Questionnaire | Administrator",
        },
      },
      {
        path: "questionnaire/view/:id",
        name: "Administrator questionnairesview",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorquestionnaireview" */ "@/components/Administrator/Questionnaire/view.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "View Questionnaire | Administrator",
        },
      },
      {
        path: "facilitator",
        name: "Administrator facilitator",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorfacilitator" */ "@/components/Administrator/facilitator.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Facilitator | Administrator",
        },
      },

      {
        path: "modules/:id",
        name: "Administrator modules",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratormodules" */ "@/components/Administrator/modules.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Modules | Administrator",
        },
      },
      {
        path: "members",
        name: "Administrator members",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratormembers" */ "@/components/Administrator/members.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Members | Administrator",
        },
      },
      {
        path: "member",
        name: "Administrator member",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratormember" */ "@/components/Administrator/member.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Member | Administrator",
        },
      },
      {
        path: "schedule",
        name: "Administrator schedule",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorschedule" */ "@/components/Administrator/schedule.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Schedule | Administrator",
        },
      },
      {
        path: "discussions",
        name: "Administrator discussions",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratordiscussions" */ "@/components/Administrator/discussions.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Discussions | Administrator",
        },
      },
      {
        path: "discussion/:id",
        name: "Administrator discussion",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratordiscussion" */ "@/components/Administrator/discussion.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Discussion | Administrator",
        },
      },
      {
        path: "feeds",
        name: "Administrator feeds",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorfeeds" */ "@/components/Administrator/feeds.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Feeds | Administrator",
        },
      },
      {
        path: "courses",
        name: "Administrator courses",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorcourses" */ "@/components/Administrator/courses.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Courses | Administrator",
        },
      },
      {
        path: "outlines",
        name: "Administrator outlines",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratoroutlines" */ "@/components/Administrator/outlines.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Modules | Administrator",
        },
      },
      {
        path: "outline/:id",
        name: "Administrator outline",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratoroutline" */ "@/components/Administrator/outline.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Module | Administrator",
        },
      },
      {
        path: "events",
        name: "Administrator events",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorevents" */ "@/components/Administrator/events.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Events | Administrator",
        },
      },
      {
        path: "event/:id",
        name: "Administrator event",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorevent" */ "@/components/Administrator/event.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Event | Administrator",
        },
      },
      {
        path: "connections",
        name: "Administrator connections",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorconnections" */ "@/components/Administrator/connections.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Connections | Administrator",
        },
      },
      {
        path: "referrals",
        name: "Administrator referrals",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorreferrals" */ "@/components/Administrator/referrals.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Refferals | Administrator",
        },
      },
      {
        path: "insights",
        name: "Administrator insights",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorinsights" */ "@/components/Administrator/insights.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Insight | Administrator",
        },
      },
      {
        path: "bonuses",
        name: "Administrator bonuses",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorbonuses" */ "@/components/Administrator/bonuses.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Bonuses | Administrator",
        },
      },
      {
        path: "profile",
        name: "Administrator profile",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorprofile" */ "@/components/Administrator/profile.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "Profile | Administrator",
        },
      },
      {
        path: "view/:type/:id",
        name: "Administrator viewprofile",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorview" */ "@/components/Administrator/viewProfile.vue"
            ),
        },
        meta: {
          typeAdmin: true,
          title: "View profile | Administrator",
        },
      },
    ],
  },

  {
    path: "/facilitator",

    components: {
      default: () =>
        import(
          /* webpackChunkName: "facilitator" */ "../views/Facilitator.vue"
        ),
    },

    children: [
      {
        path: "",
        name: "facilitator dashboard",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitatordashboard" */ "@/components/Facilitator/home.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Home | Facilitator",
        },
      },
      {
        path: "feed/view/:id",
        name: "View single Feed",
        components: {
          header: Header,
          default: () =>
            import(
              /* webpackChunkName: "viewfeed" */ "@/components/Facilitator/viewfeed.vue"
            ),
          footer: Footer,
        },
        meta: {
          typeFacilitator: true,
          title: "Feed | Nzukoor",
        },
      },
      {
        path: "interests",
        name: "facilitator interests",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitatorinterest" */ "@/components/InterestComponent.vue"
            ),
        },
        props: { type: "facilitator" },
        meta: {
          typeFacilitator: true,
          title: "Interest | Facilitator",
        },
      },

      {
        path: "modules/:id",
        name: "facilitators modules",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitatorsmodules" */ "@/components/Facilitator/modules.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Modules | Facilitator",
        },
      },
      {
        path: "questionnaire",
        name: "Facilitator questionnaire",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorquestionnaire" */ "@/components/Facilitator/Questionnaire/create.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Questionnaire | Facilitator",
        },
      },
      {
        path: "question/templates",
        name: "Facilitator questions",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorquestions" */ "@/components/Facilitator/templates.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Templates | Facilitator",
        },
      },
      {
        path: "question/template/:id",
        name: "Facilitator template",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorquestionnaireview" */ "@/components/Facilitator/Templates/view.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Template | Facilitator",
        },
      },
      {
        path: "question/template/edit/:id",
        name: "Facilitator templateedit",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatoreditt" */ "@/components/Facilitator/Templates/edit.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Edit template | Facilitator",
        },
      },
      {
        path: "assessments",
        name: "Facilitator assessments",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorassessments" */ "@/components/Facilitator/assessments.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Assessments | Facilitator",
        },
      },
      {
        path: "assessment/:type",
        name: "Facilitator assessment",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorassessment" */ "@/components/Facilitator/assessment.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Assessment | Facilitator",
        },
      },
      {
        path: "assessment/list/:id",
        name: "Facilitator assessment list",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorassessmentlist" */ "@/components/Facilitator/assessmentList.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Assessment List | Facilitator",
        },
      },
      {
        path: "questionnaires",
        name: "Facilitator questionnaires",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorquestionnaires" */ "@/components/Facilitator/Questionnaire/index.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Questionnaire | Facilitator",
        },
      },
      {
        path: "questionnaire/edit/:id",
        name: "Facilitator questionnairesedit",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorquestionnaireedit" */ "@/components/Facilitator/Questionnaire/edit.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Edit questionnaire | Facilitator",
        },
      },
      {
        path: "questionnaire/view/:id",
        name: "Facilitators questionnairesview",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitatorsquestionnaireview" */ "@/components/Facilitator/Questionnaire/view.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "View Questionnaire | Facilitator",
        },
      },
      {
        path: "attendances",
        name: "facilitators attendances",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitatorsattendances" */ "@/components/Facilitator/attendances.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Attendance | Facilitator",
        },
      },
      {
        path: "team",
        name: "Facilitator team",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitatormembers" */ "@/components/Facilitator/team.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Team | Facilitator",
        },
      },
      {
        path: "facilitator",
        name: " facilitator",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitator" */ "@/components/Facilitator/facilitator.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Facilitator| Facilitator",
        },
      },
      {
        path: "profile/:user/:id",
        name: " facilitator profile",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitator" */ "@/components/Facilitator/facilitator.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "View profile | Facilitator",
        },
      },
      {
        path: "members",
        name: "Facilitator members",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitatormembers" */ "@/components/Facilitator/members.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "View Members | Facilitator",
        },
      },
      {
        path: "member",
        name: "Facilitator member",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatormember" */ "@/components/Facilitator/member.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "View Member | Facilitator",
        },
      },
      {
        path: "schedule",
        name: "Facilitator schedule",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorschedule" */ "@/components/Facilitator/schedule.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Schedule | Facilitator",
        },
      },
      {
        path: "discussions",
        name: "Facilitator discussions",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatordiscussions" */ "@/components/Facilitator/discussions.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Discussion | Facilitator",
        },
      },
      {
        path: "discussion/:id",
        name: "Facilitator discussion",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatordiscussion" */ "@/components/Facilitator/discussion.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Discussion | Facilitator",
        },
      },
      {
        path: "feeds",
        name: "Facilitator feeds",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorfeeds" */ "@/components/Facilitator/feeds.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Feeds | Facilitator",
        },
      },
      {
        path: "courses",
        name: "Facilitator courses",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorcourses" */ "@/components/Facilitator/courses.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Courses | Facilitator",
        },
      },
      {
        path: "course/:id",
        name: "Facilitator course",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorcourse" */ "@/components/Facilitator/course.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "View Course | Facilitator",
        },
      },

      {
        path: "outlines",
        name: "Facilitator outlines",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatoroutlines" */ "@/components/Facilitator/outlines.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Modules | Facilitator",
        },
      },
      {
        path: "outline/:id",
        name: "Facilitator outline",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatoroutline" */ "@/components/Facilitator/outline.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "View module | Facilitator",
        },
      },
      {
        path: "events",
        name: "Facilitator events",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorevents" */ "@/components/Facilitator/events.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "View Events | Facilitator",
        },
      },
      {
        path: "event/:id",
        name: "Facilitator event",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorevent" */ "@/components/Facilitator/event.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "View Event | Facilitator",
        },
      },
      {
        path: "connections",
        name: "Facilitator connections",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorconnections" */ "@/components/Facilitator/connections.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Connections | Facilitator",
        },
      },
      {
        path: "referrals",
        name: "Facilitator referrals",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorreferrals" */ "@/components/Facilitator/referrals.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Referrals| Facilitator",
        },
      },
      {
        path: "insights",
        name: "Facilitator insights",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorinsights" */ "@/components/Facilitator/insights.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Insight| Facilitator",
        },
      },
      {
        path: "bonuses",
        name: "Facilitator bonuses",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorbonuses" */ "@/components/Facilitator/bonuses.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "Bonuses | Facilitator",
        },
      },
      {
        path: "profile",
        name: "Facilitator profile",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorprofile" */ "@/components/Facilitator/profile.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "View Profile | Facilitator",
        },
      },
      {
        path: "view/:type/:id",
        name: "Facilitator viewprofile",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorview" */ "@/components/Facilitator/viewProfile.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
          title: "View Profile | Facilitator",
        },
      },
    ],
  },

  {
    path: "/member",

    components: {
      default: () =>
        import(/* webpackChunkName: "Member" */ "../views/Member.vue"),
    },

    children: [
      {
        path: "",
        name: "Member dashboard",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberdashboard" */ "@/components/Member/home.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Home | Member",
        },
      },
      {
        path: "feed/view/:id",
        name: "View member Feed",
        components: {
          header: Header,
          default: () =>
            import(
              /* webpackChunkName: "viewfeed" */ "@/components/Member/viewfeed.vue"
            ),
          footer: Footer,
        },
        meta: {
          typeMember: true,
          title: "Feed | Nzukoor",
        },
      },
      {
        path: "facilitators",
        name: "Member facilitators",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberfacilitators" */ "@/components/Member/facilitators.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "View Facilitators | Member",
        },
      },
      {
        path: "profile/:user/:id",
        name: "Member facilitatorprofile",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberfacilitators" */ "@/components/Member/facilitator.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "View Profile | Member",
        },
      },
      {
        path: "assessments",
        name: "Member assessments",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberassessments" */ "@/components/Member/assessments.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Assessments | Member",
        },
      },
      {
        path: "assessment/:type",
        name: "Member assessment",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberassessment" */ "@/components/Member/memberassessment.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Assessment | Member",
        },
      },
      {
        path: "solve/assessment/quiz/:id",
        name: "Member solve quiz",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Membersolvequiz" */ "@/components/Member/AnswerTemplates/quiz.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Solve Quiz | Member",
        },
      },
      {
        path: "solve/assessment/:id",
        name: "Member solve assessment",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Membersolveassessment " */ "@/components/Member/AnswerTemplates/others.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Solve Assessment | Member",
        },
      },
      {
        path: "facilitator",
        name: "Member facilitator",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberfacilitator" */ "@/components/Member/facilitator.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "View Facilitator | Member",
        },
      },
      {
        path: "order",
        name: "Member order",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberfacilitator" */ "@/components/Member/order.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Order | Member",
        },
      },
      {
        path: "transaction",
        name: "Member transaction",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Membertransaction" */ "@/components/Member/transaction.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Transaction | Member",
        },
      },
      {
        path: "questionnaire/:id/:module_id/:course_id",
        name: "Member questionnaire",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberfacilitator" */ "@/components/Member/viewQuestionnaire.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Questionnaire | Member",
        },
      },
      {
        path: "solve/template/:id/:module_id/:course_id",
        name: "Member template",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberfacilitator" */ "@/components/Member/viewQuestionnaire.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Solve | Member",
        },
      },
      {
        path: "members",
        name: " members",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "members" */ "@/components/Member/members.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "View Members | Member",
        },
      },
      {
        path: "member",
        name: " member",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "member" */ "@/components/Member/member.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "View Member | Member",
        },
      },
      {
        path: "schedule",
        name: "Member schedule",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberschedule" */ "@/components/Member/schedule.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Schedule | Member",
        },
      },
      {
        path: "library",
        name: "Member library",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberlibrary" */ "@/components/Member/library.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Library | Member",
        },
      },
      {
        path: "discussions",
        name: "Member discussions",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberdiscussions" */ "@/components/Member/discussions.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Discussions | Member",
        },
      },
      {
        path: "discussion/:id",
        name: "Member discussion",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberdiscussion" */ "@/components/Member/discussion.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Discussion | Member",
        },
      },
      {
        path: "feeds",
        name: "Member feeds",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberfeeds" */ "@/components/Member/feeds.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Feeds | Member",
        },
      },
      {
        path: "courses",
        name: "Member courses",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Membercourses" */ "@/components/Member/courses.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Courses | Member",
        },
      },
      {
        path: "course/:id",
        name: "Member course",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Membercourse" */ "@/components/Member/course.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Course | Member",
        },
      },

      {
        path: "outlines",
        name: "Member outlines",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberoutlines" */ "@/components/Member/outlines.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Modules | Member",
        },
      },
      {
        path: "outline/:id",
        name: "Member outline",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberoutline" */ "@/components/Member/outline.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Module | Member",
        },
      },
      {
        path: "events",
        name: "Member events",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberevents" */ "@/components/Member/events.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Events | Member",
        },
      },
      {
        path: "event/:id",
        name: "Member event",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberevent" */ "@/components/Member/event.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Event | Member",
        },
      },
      {
        path: "connections",
        name: "Member connections",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberconnections" */ "@/components/Member/connections.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Connections | Member",
        },
      },
      {
        path: "referrals",
        name: "Member referrals",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberreferrals" */ "@/components/Member/referrals.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Referrals | Member",
        },
      },
      {
        path: "insights",
        name: "Member insights",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberinsights" */ "@/components/Member/insights.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Insight | Member",
        },
      },
      {
        path: "bonuses",
        name: "Member bonuses",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberbonuses" */ "@/components/Member/bonuses.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Bonuses | Member",
        },
      },
      {
        path: "profile",
        name: "Member profile",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberprofile" */ "@/components/Member/profile.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Profile | Member",
        },
      },
      {
        path: "media/:id",
        name: "Member media",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Membermedia" */ "@/components/Member/Media/index.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Media | Member",
        },
      },
      {
        path: "view/:type/:id",
        name: "Member viewprofile",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberview" */ "@/components/Member/viewProfile.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "View Profile | Member",
        },
      },
    ],
  },
  {
    path: "/course/:id",
    name: "course",
    components: {
      default: () =>
        import(/* webpackChunkName: "course" */ "@/components/course.vue"),
    },
    meta: {
      title: "Course | Member",
    },
  },
  {
    path: "/question",
    name: "question",
    components: {
      default: () =>
        import(/* webpackChunkName: "question" */ "@/components/uploader.vue"),
    },
    meta: {
      title: "Questionnaire | Member",
    },
  },

  {
    path: "/invite/:code",
    name: "Invite",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "Invite" */ "../views/Invite.vue"),
      footer: Footer,
    },
    meta: {
      title: "Event | Nzukoor",
    },
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
    meta: {
      title: "Not Found | Nzukoor",
    },
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

router.beforeEach((to, from, next) => {
  // to and from are both route objects. must call `next`.
  window.document.title =
    to.meta && to.meta.title ? to.meta.title : "Home | Nzukoor";
  window.scrollTo(0, 0);
  next();
});

export default router;
