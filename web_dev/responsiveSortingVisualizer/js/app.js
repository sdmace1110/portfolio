const container = document.querySelector("#sort_container");
const numberOfBars = 12;
const delay = 500;

const createBars = (numBars) => {
  for (let i = 0; i < numBars; i++) {
    // full screen bar height
    let barHeightScaler = 7.5;
    // Generate a random number (1-100)
    const value = Math.floor(Math.random() * 100) + 1;
    if (window.innerWidth < 800) {
      // mobile bar height
      barHeightScaler = 4.5;
    }
    // create a bar with "value"
    // Begin with a new blank div
    const barEle = document.createElement("div");
    // Add class "bar" (predefined class in CSS) to the div
    barEle.classList.add("bar");
    // Give barEle a height representing its value
    barEle.style.height = `${value * barHeightScaler}px`;
    // Position on X-axis
    barEle.style.transform = `translateX(${(i + 0.2) * 35}px)`;

    // Create a label containing the value
    const barLabel = document.createElement("label");
    // Give label CSS props
    barLabel.classList.add("bar_id");
    // Assign value
    barLabel.innerText = value;
    // Add to barEle
    barEle.appendChild(barLabel);

    // Add barEle to the HTML root (container)
    container.appendChild(barEle);
  }
};

const shuffle = () => {
  window.location.reload();
};

// Promise to swap two blocks
function swap(el1, el2) {
  return new Promise((resolve) => {
    // For exchanging styles of two blocks
    let temp1 = el1.style.height;
    let temp2 = el1.childNodes[0].innerText;
    el1.style.height = el2.style.height;
    el2.style.height = temp1;
    el1.childNodes[0].innerText = el2.childNodes[0].innerText;
    el2.childNodes[0].innerText = temp2;

    window.requestAnimationFrame(function () {
      // For waiting for .25 sec
      setTimeout(() => {
        container.insertBefore(el2, el1);
        resolve();
      }, 250);
    });
  });
}

// Used in async function so that we can so animations of sorting, takes input time in ms (1000 = 1s)
function setDelay(milisec) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve("");
    }, milisec);
  });
}

// DRIVER SECTION
createBars(numberOfBars);
// sort_selection(delay);
