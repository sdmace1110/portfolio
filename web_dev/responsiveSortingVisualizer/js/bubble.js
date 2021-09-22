const sort_bubble = async (delay = 600) => {
  bubbleInfo();

  let blocks = document.querySelectorAll(".bar");

  const ele = document.querySelectorAll(".bar");
  for (let i = 0; i < ele.length - 1; i++) {
    for (let j = 0; j < ele.length - i - 1; j++) {
      // testing element
      ele[j].style.background = " darkgreen";
      // Sibling to test
      ele[j + 1].style.background = "lightgreen";
      if (parseInt(ele[j].style.height) > parseInt(ele[j + 1].style.height)) {
        await setDelay(delay);
        swap(ele[j], ele[j + 1]);
      }
      ele[j].style.background = "white";
      ele[j + 1].style.background = "yellow";
    }
    ele[ele.length - 1 - i].style.background = "#1cf539";

    ele[ele.length - 1 - i].classList.add("bar_bubble_sorted");
    ele[ele.length - 1 - i].childNodes[0].style.color = " lightgreen";
    ele[ele.length - 1 - i].childNodes[0].style.backgroundColor = " darkgreen";
  }
  ele[0].style.background = "#1cf539";

  ele[0].childNodes[0].style.color = " lightgreen";
  ele[0].childNodes[0].style.backgroundColor = " darkgreen";
};

const bubbleInfo = () => {
  const infoHtml = `<div class="info_wrapper">
  <div id="sort_info_container">
    <h1 class="font_green">Bubble Sort</h1>

    <h2 class="font_lightgreen">Visualizer Legend</h2>
    <div class="legend_wrapper">
      <div class="color color_darkgreen">Testing Element</div>

      <div class="color color_lightgreen">Tested Element</div>
      <div class="color color_green">Sorted Section</div>
    </div>
    <h2 class="font_lightgreen">Description</h2>
    <p>
      Bubble sort is a simple sorting algorithm. This sorting algorithm is
      comparison-based algorithm in which each pair of adjacent elements is
      compared and the elements are swapped if they are not in order. This
      algorithm is not suitable for large data sets.
    </p>
    <h2 class="font_lightgreen">Time Complexity:</h2>
    <span style="font-size: 2em; color: red">O(n<sup>2</sup>)</span>
    <p>Average and Worst</p>
  </div>
</div>`;
  const info = (document.getElementById("info_panel").innerHTML = infoHtml);
};
