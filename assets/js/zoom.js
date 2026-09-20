// Initialize medium zoom.
$(document).ready(function () {
  const mobileViewport = window.matchMedia("(max-width: 576px)");
  medium_zoom = mediumZoom("[data-zoomable]", {
    margin: mobileViewport.matches ? 20 : 48,
    background: "rgba(18, 22, 28, 0.88)",
  });
  mobileViewport.addEventListener("change", () => {
    medium_zoom.update({ margin: mobileViewport.matches ? 20 : 48 });
  });

  const closeButton = document.createElement("button");
  closeButton.className = "zoom-close";
  closeButton.type = "button";
  closeButton.setAttribute("aria-label", "Close enlarged image");
  closeButton.textContent = "×";
  closeButton.hidden = true;
  document.body.appendChild(closeButton);
  closeButton.addEventListener("click", () => medium_zoom.close());
  medium_zoom.on("open", () => {
    closeButton.hidden = false;
  });
  medium_zoom.on("close", () => {
    closeButton.hidden = true;
  });
});
