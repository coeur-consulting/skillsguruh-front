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
      if (localStorage.getItem("authLearner")) {
        let user = localStorage.getItem("authLearner");
        if (!user) {
          next();
        } else {
          next("/learner");
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
  },
  {
    path: "/explore",
    name: "Explore",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "about" */ "../views/Explore.vue"),
      footer: Footer,
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
    path: "/order",
    name: "Order",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "about" */ "@/components/order"),
      footer: Footer,
    },
  },
  {
    path: "/feeds",
    name: "Feeds",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "feeds" */ "../views/Feeds.vue"),
      footer: Footer,
    },
  },
  {
    path: "/events",
    name: "Events",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "events" */ "../views/Events.vue"),
      footer: Footer,
    },
  },
  {
    path: "/discussions",
    name: "Discussions",
    components: {
      header: Header,
      default: () =>
        import(
          /* webpackChunkName: "discussions" */ "../views/Discussions.vue"
        ),
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
    path: "/quiz",
    name: "Quiz",
    components: {
      header: Header,
      default: () => import(/* webpackChunkName: "quiz" */ "../views/Quiz.vue"),
      footer: Footer,
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
        },
      },

      {
        path: "modules",
        name: "Administrator modules",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratormodules" */ "@/components/Administrator/modules.vue"
            ),
        },
        meta: {
          typeAdmin: true,
        },
      },
      {
        path: "learners",
        name: "Administrator learners",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorlearners" */ "@/components/Administrator/learners.vue"
            ),
        },
        meta: {
          typeAdmin: true,
        },
      },
      {
        path: "learner",
        name: "Administrator learner",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Administratorlearner" */ "@/components/Administrator/learner.vue"
            ),
        },
        meta: {
          typeAdmin: true,
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
        },
      },

      {
        path: "modules",
        name: "facilitators modules",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitatorsmodules" */ "@/components/Facilitator/modules.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
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
        },
      },
      {
        path: "team",
        name: "Facilitator team",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitatorlearners" */ "@/components/Facilitator/team.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
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
        },
      },
      {
        path: "learners",
        name: "Facilitator learners",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "facilitatorlearners" */ "@/components/Facilitator/learners.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
        },
      },
      {
        path: "learner",
        name: "Facilitator learner",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Facilitatorlearner" */ "@/components/Facilitator/learner.vue"
            ),
        },
        meta: {
          typeFacilitator: true,
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
        },
      },
    ],
  },

  {
    path: "/learner",

    components: {
      default: () =>
        import(/* webpackChunkName: "Learner" */ "../views/Learner.vue"),
    },

    children: [
      {
        path: "",
        name: "Learner dashboard",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerdashboard" */ "@/components/Learner/home.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },

      {
        path: "facilitators",
        name: "Learner facilitators",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerfacilitators" */ "@/components/Learner/facilitators.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "assessments",
        name: "Learner assessments",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerassessments" */ "@/components/Learner/assessments.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "assessment/:type",
        name: "Learner assessment",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerassessment" */ "@/components/Learner/assessment.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "solve/assessment/quiz/:id",
        name: "Learner solve quiz",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnersolvequiz" */ "@/components/Learner/AnswerTemplates/quiz.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "solve/assessment/:id",
        name: "Learner solve assessment",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnersolveassessment " */ "@/components/Learner/AnswerTemplates/others.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "facilitator",
        name: "Learner facilitator",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerfacilitator" */ "@/components/Learner/facilitator.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "order",
        name: "Learner order",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerfacilitator" */ "@/components/Learner/order.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "transaction",
        name: "Learner transaction",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnertransaction" */ "@/components/Learner/transaction.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "questionnaire/:id",
        name: "Learner questionnaire",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerfacilitator" */ "@/components/Learner/viewQuestionnaire.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "learners",
        name: " learners",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "learners" */ "@/components/Learner/learners.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "learner",
        name: " learner",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "learner" */ "@/components/Learner/learner.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "schedule",
        name: "Learner schedule",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerschedule" */ "@/components/Learner/schedule.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "library",
        name: "Learner library",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerlibrary" */ "@/components/Learner/library.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "discussions",
        name: "Learner discussions",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerdiscussions" */ "@/components/Learner/discussions.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "discussion/:id",
        name: "Learner discussion",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerdiscussion" */ "@/components/Learner/discussion.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "feeds",
        name: "Learner feeds",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerfeeds" */ "@/components/Learner/feeds.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "courses",
        name: "Learner courses",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnercourses" */ "@/components/Learner/courses.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "course/:id",
        name: "Learner course",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnercourse" */ "@/components/Learner/course.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },

      {
        path: "outlines",
        name: "Learner outlines",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learneroutlines" */ "@/components/Learner/outlines.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "outline/:id",
        name: "Learner outline",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learneroutline" */ "@/components/Learner/outline.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "events",
        name: "Learner events",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerevents" */ "@/components/Learner/events.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "event/:id",
        name: "Learner event",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerevent" */ "@/components/Learner/event.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "connections",
        name: "Learner connections",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerconnections" */ "@/components/Learner/connections.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "referrals",
        name: "Learner referrals",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerreferrals" */ "@/components/Learner/referrals.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "insights",
        name: "Learner insights",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerinsights" */ "@/components/Learner/insights.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "bonuses",
        name: "Learner bonuses",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerbonuses" */ "@/components/Learner/bonuses.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "profile",
        name: "Learner profile",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerprofile" */ "@/components/Learner/profile.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "media/:id",
        name: "Learner media",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnermedia" */ "@/components/Learner/Media/index.vue"
            ),
        },
        meta: {
          typeLearner: true,
        },
      },
      {
        path: "view/:type/:id",
        name: "Learner viewprofile",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerview" */ "@/components/Learner/viewProfile.vue"
            ),
        },
        meta: {
          typeLearner: true,
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
  },
  {
    path: "/question",
    name: "question",
    components: {
      default: () =>
        import(
          /* webpackChunkName: "question" */ "@/components/Questionnaire/index.vue"
        ),
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
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
