/* eslint-disable no-console */

import { register } from "register-service-worker";

if (process.env.NODE_ENV === "production") {
  register(`${process.env.BASE_URL}service-worker.js`, {
    ready() {
      console.log(
        "App is being served from cache by a service worker.\n" +
          "For more details, visit https://goo.gl/AFskqB"
      );
    },
    registered(registration) {
      console.log("Service worker has been registered.");

      // Routinely check for app updates by testing for a new service worker.
      setInterval(() => {
        registration.update();
      }, 1000 * 60 * 60); // hourly checks
    },
    cached() {
      console.log("Content has been cached for offline use.");
    },
    updated(registration) {
      console.log(
        "New content is available! We'll show a refresh button for the user to click on and refresh"
      );
      document.dispatchEvent(
        new CustomEvent("swUpdated", { detail: registration })
      );
    },
    offline() {
      console.log(
        "No internet connection found. App is running in offline mode."
      );
    },
    error(error) {
      console.error("Error during service worker registration:", error);
    },
  });
}
