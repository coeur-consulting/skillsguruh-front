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
      title: "Home | SkillsGuruh",
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
      title: "Register | SkillsGuruh",
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
      title: "Login | SkillsGuruh",
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
    path: "/Admin/login",
    name: "Admin Login",
    components: {
      default: () =>
        import(/* webpackChunkName: "Login" */ "../views/Auth/OrgLogin.vue"),
    },
    meta: {
      title: "Admin Login | SkillsGuruh",
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
      title: "Transaction | SkillsGuruh",
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
    meta: {
      title: "Explore | SkillsGuruh",
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
      title: "Explore courses | SkillsGuruh",
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
      title: "About | SkillsGuruh",
    },
  },
  {
    path: "/interests/:interest",
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
      title: "Interests | SkillsGuruh",
    },
  },
  {
    path: "/discussion/:id",
    name: "Discussion",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "about" */ "../views/Discussion.vue"),
      footer: Footer,
    },
    meta: {
      title: "Discussion | SkillsGuruh",
    },
  },
  {
    path: "/event/:id",
    name: "Event",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "about" */ "../views/Event.vue"),
      footer: Footer,
    },
    meta: {
      title: "Event | SkillsGuruh",
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
      title: "Order | SkillsGuruh",
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
    meta: {
      title: "Feeds | SkillsGuruh",
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
    meta: {
      title: "Events | SkillsGuruh",
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
    meta: {
      title: "Discussion | SkillsGuruh",
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
      title: "Contact us | SkillsGuruh",
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
      title: "Quiz | SkillsGuruh",
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
      title: "Asseeement | SkillsGuruh",
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
      title: "Loading | SkillsGuruh",
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
          title: "Admins - Organization",
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
          title: "Learners - Organization",
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
          title: "Learner - Organization",
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
          title: "Learners | Administrator",
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
          title: "Learner | Administrator",
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
              /* webpackChunkName: "facilitatorlearners" */ "@/components/Facilitator/team.vue"
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
        path: ":user/:id",
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
          title: "View Learners | Facilitator",
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
          title: "View Learner | Facilitator",
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
          title: "Home | Learner",
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
          title: "View Facilitators | Learner",
        },
      },
      {
        path: ":user/:id",
        name: "Learner facilitatorprofile",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerfacilitators" */ "@/components/Learner/facilitator.vue"
            ),
        },
        meta: {
          typeLearner: true,
          title: "View Profile | Learner",
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
          title: "Assessments | Learner",
        },
      },
      {
        path: "assessment/:type",
        name: "Learner assessment",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerassessment" */ "@/components/Learner/learnerassessment.vue"
            ),
        },
        meta: {
          typeLearner: true,
          title: "Assessment | Learner",
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
          title: "Solve Quiz | Learner",
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
          title: "Solve Assessment | Learner",
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
          title: "View Facilitator | Learner",
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
          title: "Order | Learner",
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
          title: "Transaction | Learner",
        },
      },
      {
        path: "questionnaire/:id/:module_id/:course_id",
        name: "Learner questionnaire",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerfacilitator" */ "@/components/Learner/viewQuestionnaire.vue"
            ),
        },
        meta: {
          typeLearner: true,
          title: "Questionnaire | Learner",
        },
      },
      {
        path: "solve/template/:id/:module_id/:course_id",
        name: "Learner template",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Learnerfacilitator" */ "@/components/Learner/viewQuestionnaire.vue"
            ),
        },
        meta: {
          typeLearner: true,
          title: "Solve | Learner",
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
          title: "View Learners | Learner",
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
          title: "View Learner | Learner",
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
          title: "Schedule | Learner",
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
          title: "Library | Learner",
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
          title: "Discussions | Learner",
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
          title: "Discussion | Learner",
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
          title: "Feeds | Learner",
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
          title: "Courses | Learner",
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
          title: "Course | Learner",
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
          title: "Modules | Learner",
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
          title: "Module | Learner",
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
          title: "Events | Learner",
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
          title: "Event | Learner",
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
          title: "Connections | Learner",
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
          title: "Referrals | Learner",
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
          title: "Insight | Learner",
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
          title: "Bonuses | Learner",
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
          title: "Profile | Learner",
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
          title: "Media | Learner",
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
          title: "View Profile | Learner",
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
      title: "Course | Learner",
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
    meta: {
      title: "Questionnaire | Learner",
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
      title: "Event | SkillsGuruh",
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
      title: "Not Found | SkillsGuruh",
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
    to.meta && to.meta.title ? to.meta.title : "Home | SkillsGuruh";
  next();
});

export default router;
