
const collapseToggle = () => {
  const collapse = document.getElementById("collapse-link");
  collapse.addEventListener("click", () => {
    const toggler = document.getElementById("trip-toggle");
      setTimeout(() => {
        if (toggler.innerHTML.includes('down')){
          toggler.innerHTML = "<i class='fas fa-caret-up display-4 text-white-50'></i>"
        } else {
          toggler.innerHTML = "<i class='fas fa-caret-down display-4 text-white-50'></i>"
        }
      }, 200);
  });
};
export { collapseToggle };
