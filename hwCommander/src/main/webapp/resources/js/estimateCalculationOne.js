window.addEventListener("load", ()=>{
	let donut = document.querySelector(".donut-container");
      let donutNum = document.querySelector(".donut-fill");
      let progress = 0;

      function animateBackgroundColor() {
        let gradient = `conic-gradient(#df22ee 0% ${progress}%, #f2f2f2 100% 0%)`;
        donut.style.background = gradient;

        if (progress < 100) {
          progress += 1;
          setTimeout(animateBackgroundColor, 20);
        } else {
          goToZero();
        }
      }

      function goToZero() {
        let gradient = `conic-gradient(#df22ee 0% ${progress}%, #f2f2f2 100% 0%)`;
        donut.style.background = gradient;
        donutNum.innerHTML = "2";
        progress -= 3;
        if (progress > 0) {
          setTimeout(goToZero, 20);
        }
      }

      animateBackgroundColor();
})