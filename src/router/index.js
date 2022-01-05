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
    path: "/admin/login",
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
    path: "/forgot-password",
    name: "Forgot Password",
    components: {
      default: () =>
        import(
          /* webpackChunkName: "ForgotPassword" */ "../views/Auth/ForgotPassword.vue"
        ),
    },
    meta: {
      title: "Forgot Password | Nzukoor",
    },
  },
  {
    path: "/reset-password",
    name: "Reset Password",
    components: {
      default: () =>
        import(
          /* webpackChunkName: "ResetPassword" */ "../views/Auth/ResetPassword.vue"
        ),
    },
    meta: {
      title: "Reset Password | Nzukoor",
    },
  },
  {
    path: "/notification",
    name: "notification",
    components: {
      header: Header,
      default: () =>
        import(
          /* webpackChunkName: "notification" */ "../views/notification.vue"
        ),
      footer: Footer,
    },
    meta: {
      title: "notification | Nzukoor",
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
      title: "Explore Members | Nzukoor",
    },
  },
  {
    path: "/explore/tribes",
    name: "Explore Tribes",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "exploretribes" */ "../views/Tribes.vue"),
      footer: Footer,
    },
    meta: {
      title: "Explore Tribes | Nzukoor",
    },
  },
  {
    path: "/explore/courses",
    name: "Explore Courses",
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
    path: "/profile/:username",
    name: " User profile",
    components: {
      header: Header,
      default: () =>
        import(
          /* webpackChunkName: "userprofil" */ "@/components/guestfacilitator.vue"
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
        path: "reports",
        name: "organization reports",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationreports" */ "@/components/Organization/reports.vue"
            ),
        },
        meta: {
          typeOrg: true,
          title: "Reports - Organization",
        },
      },
      {
        path: "discussions",
        name: "organization discussions",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationdiscussions" */ "@/components/Organization/discussions.vue"
            ),
        },
        meta: {
          typeOrg: true,
          title: "Discussions - Organization",
        },
      },
      {
        path: "discussion/:id",
        name: "organization discussion",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationdiscussion" */ "@/components/Organization/discussion.vue"
            ),
        },
        meta: {
          typeOrg: true,
          title: "Discussion - Organization",
        },
      },
      {
        path: "events",
        name: "organization events",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationevents" */ "@/components/Organization/events.vue"
            ),
        },
        meta: {
          typeOrg: true,
          title: "Events - Organization",
        },
      },
      {
        path: "event/:id",
        name: "organization event",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationevent" */ "@/components/Organization/event.vue"
            ),
        },
        meta: {
          typeOrg: true,
          title: "Event - Organization",
        },
      },
      {
        path: "feed",
        name: "organization feeds",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationfeed" */ "@/components/Organization/feeds.vue"
            ),
        },
        meta: {
          typeOrg: true,
          title: "Feeds - Organization",
        },
      },
      {
        path: "feed/:id",
        name: "organization feed",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "organizationfeed" */ "@/components/Organization/feed.vue"
            ),
        },
        meta: {
          typeOrg: true,
          title: "View Feed - Organization",
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
    path: "/messages",

    components: {
      default: () =>
        import(/* webpackChunkName: "message" */ "../views/Messages/index.vue"),
    },
    meta: {
      typeMember: true,
      title: "Home | Messages",
    },
  },

  {
    path: "/member",

    components: {
      default: () =>
        import(/* webpackChunkName: "Member" */ "../views/Member.vue"),
    },

    children: [
      {
        path: "dashboard",
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
        path: "tribe",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberdashboard" */ "@/components/Member/Tribe/index.vue"
            ),
        },
        children: [
          {
            path: "feed/:tribe",
            name: "tribe feeds",
            components: {
              default: () =>
                import(
                  /* webpackChunkName: "tribefeeds" */ "@/components/Member/Tribe/feeds.vue"
                ),
            },
            meta: {
              routetype: "feeds",
              showtribe: true,
              typeMember: true,
            },
          },
          {
            path: "events/:tribe",
            name: "tribe events",
            components: {
              default: () =>
                import(
                  /* webpackChunkName: "tribeevents" */ "@/components/Member/Tribe/events.vue"
                ),
            },
            meta: {
              routetype: "tribeevents",
              showtribe: true,
              typeMember: true,
            },
          },
          {
            path: "event/:tribe/:id",
            name: "tribe event",
            components: {
              default: () =>
                import(
                  /* webpackChunkName: "tribeevent" */ "@/components/Member/Tribe/event.vue"
                ),
            },
            meta: {
              routetype: "tribeevent",
              showtribe: true,
              typeMember: true,
            },
          },
          {
            path: "discussions/:tribe",
            name: "tribe discussions",
            components: {
              default: () =>
                import(
                  /* webpackChunkName: "tribediscussions" */ "@/components/Member/Tribe/discussions.vue"
                ),
            },
            meta: {
              routetype: "tribediscussions",
              showtribe: true,
              typeMember: true,
            },
          },
          {
            path: "discussion/:id",
            name: "tribe discussion",
            components: {
              default: () =>
                import(
                  /* webpackChunkName: "tribediscussion" */ "@/components/Member/Tribe/discussion.vue"
                ),
            },
            meta: {
              routetype: "tribediscussion",
              showtribe: true,
              typeMember: true,
            },
          },

          {
            path: "courses/:tribe",
            name: "tribe courses",
            components: {
              default: () =>
                import(
                  /* webpackChunkName: "tribecourses" */ "@/components/Member/Tribe/courses.vue"
                ),
            },
            meta: {
              routetype: "courses",
              showtribe: true,
              typeMember: true,
            },
          },

          {
            path: "feeds",
            name: "member feeds",
            components: {
              default: () =>
                import(
                  /* webpackChunkName: "Memberdashboard" */ "@/components/Member/Tribe/feeds.vue"
                ),
            },
            meta: {
              routetype: "feeds",
              showtribe: true,
              typeMember: true,
            },
          },
          {
            path: "explore",
            name: "explore tribe",
            components: {
              default: () =>
                import(
                  /* webpackChunkName: "tribeexplore" */ "@/components/Member/Tribe/explore.vue"
                ),
            },
            meta: {
              routetype: "explore",
            },
          },
        ],
      },
      {
        path: "explore/discussions",
        name: "guest  discussions",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "tribeguestdiscussion" */ "@/components/Member/Tribe/guestdiscussions.vue"
            ),
        },
        meta: {
          routetype: "guest discussions",
        },
      },
      {
        path: "explore/discussion/:id",
        name: "guest discussions",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "tribeguestdiscussion" */ "@/components/Member/Tribe/guestdiscussion.vue"
            ),
        },
        meta: {
          routetype: "guest discussions",
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
          routetype: "feed",
        },
      },
      {
        path: "tribes",
        name: "Member tribes",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "membertribes" */ "@/components/Member/Tribe/tribes.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Tribes | Member",
          routetype: "mytribes",
        },
      },
      {
        path: "/explore/community",
        name: "Member community",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "membercommunity" */ "@/components/Member/Tribe/community.vue"
            ),
        },
        meta: {
          typeMember: false,
          title: "Tribes | Member",
          routetype: "community",
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
        path: "profile/:username",
        name: "Member profiles",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Memberprofile" */ "@/components/Member/facilitator.vue"
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
          routetype: "discussions",
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
          routetype: "discussion",
        },
      },
      {
        path: "",
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
          routetype: "feeds",
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
          routetype: "courses",
        },
      },
      {
        path: "course",
        name: "Member index",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Membercourses" */ "@/components/Member/Course/index.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Courses | Member",
          routetype: "courses",
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
          routetype: "course",
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
              /* webpackChunkName: "Memberevents" */ "@/components/Member/scheduler.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Events | Member",
          routetype: "events",
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
          routetype: "event",
        },
      },
      {
        path: "community",
        name: "Member connections",
        components: {
          default: () =>
            import(
              /* webpackChunkName: "Membercommunity" */ "@/components/Member/connections.vue"
            ),
        },
        meta: {
          typeMember: true,
          title: "Community | Member",
          routetype: "community",
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
          routeType:'profile',
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
    path: "/terms",
    name: "Terms",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "Terms" */ "../views/Terms.vue"),
      footer: Footer,
    },
    meta: {
      title: "Terms and Condiftions | Nzukoor",
    },
  },

  {
    path: "/policies",
    name: "Policy",
    components: {
      header: Header,
      default: () =>
        import(/* webpackChunkName: "Policies" */ "../views/Policy.vue"),
      footer: Footer,
    },
    meta: {
      title: "Privacy Policies | Nzukoor",
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
