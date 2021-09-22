const sort_selection = async (delay) => {
  populateInfo();

  let bars = document.querySelectorAll(".bar");
  // Assign 0 to min_idx
  var min_idx = 0;
  for (let i = 0; i < bars.length; i += 1) {
    // Assign i to min_idx
    min_idx = i;

    bars[i].style.backgroundColor = "yellow";

    for (let j = i + 1; j < bars.length; j += 1) {
      bars[i].style.backgroundColor = "gold";
      bars[j].style.backgroundColor = "rgb(40, 120, 255)";
      bars[min_idx].style.backgroundColor = "rgb(0,50,255)";

      await setDelay(500);

      let val1 = Number(bars[j].childNodes[0].innerText);

      let val2 = Number(bars[min_idx].childNodes[0].innerText);

      if (val1 < val2) {
        bars[min_idx].style.backgroundColor = " #ffffff";

        min_idx = j;

        if (min_idx !== i) {
          bars[min_idx].style.backgroundColor = "  #ffffff";
        }
      } else {
        bars[j].style.backgroundColor = "  #ffffff";
      }
    }

    await swap(bars[min_idx], bars[i]);

    await setDelay(500);

    bars[min_idx].style.backgroundColor = " white";

    bars[i].style.backgroundColor = " rgb(24, 190, 255)";
    bars[i].classList.add("bar_selection_sorted");
    bars[i].childNodes[0].style.color = " rgb(24,190,255)";
    bars[i].childNodes[0].style.backgroundColor = " darkblue";
  }
};

const populateInfo = () => {
  const infoHtml = `<div class="info_wrapper">
  <div id="sort_info_container">
    <h1>Selection Sort</h1>

    <h2>Visualizer Legend</h2>
    <div class="legend_wrapper">
      <div class="color color_yellow">Array Boundry</div>
      <div class="color color_darkblue">Smallest Item</div>

      <div class="color color_lightblue">Sorted Section</div>
      <div class="color color_blue">Iterator</div>
    </div>
    <h2>Description</h2>
    <p>
    Selection sort is a simple sorting algorithm. This sorting algorithm is an in-place comparison-based algorithm in which the list is divided into two parts, the sorted part at the left end and the unsorted part at the right end. Initially, the sorted part is empty and the unsorted part is the entire list.

    The smallest element is selected from the unsorted array and swapped with the leftmost element, and that element becomes a part of the sorted array. This process continues moving unsorted array boundary by one element to the right.
    </p>
    <h2>Time Complexity:</h2>
    <span style="font-size: 2em; color: red">O(n<sup>2</sup>)</span>
    <p>Average and Worst</p>
    
  </div>
</div>`;
  const info = (document.getElementById("info_panel").innerHTML = infoHtml);
};
