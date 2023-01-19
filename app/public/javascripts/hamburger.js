(function () {
  "use strict";

  const hamburger = document.querySelector("#hamburger");
  hamburger.addEventListener("click", () => {
    if (hamburger.dataset.active === "true") hamburger.dataset.active = "false";
    else hamburger.dataset.active = "true";
  });
})();
