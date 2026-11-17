(function () {
  var menu = document.getElementById("menu");
  var toggle = document.querySelector(".site-header .menu-toggle");
  var close = menu && menu.querySelector(".menu-close");
  if (!menu || !toggle || !close) return;

  function setOpen(open) {
    menu.hidden = !open;
    toggle.setAttribute("aria-expanded", String(open));
    document.body.classList.toggle("menu-open", open);
    (open ? close : toggle).focus();
  }

  toggle.addEventListener("click", function () { setOpen(true); });
  close.addEventListener("click", function () { setOpen(false); });
  menu.addEventListener("click", function (e) {
    if (e.target.closest("a")) setOpen(false);
  });
  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape" && !menu.hidden) setOpen(false);
  });
  // Close if the viewport grows past the mobile breakpoint.
  window.matchMedia("(min-width: 720px)").addEventListener("change", function (e) {
    if (e.matches && !menu.hidden) setOpen(false);
  });
})();
