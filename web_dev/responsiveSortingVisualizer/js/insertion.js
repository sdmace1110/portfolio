const sort_insertion = async (delay = 400) => {
  insertionInfo();

  let bars = document.querySelectorAll(".bar");

  // Provide purple color to 0th bar
  bars[0].style.backgroundColor = " #5539cc";

  for (var i = 1; i < bars.length; i += 1) {
    // Assign i-1 to j
    var j = i - 1;

    // To store the integer value of ith bar to key
    var key = Number(bars[i].childNodes[0].innerText);

    // To store the ith bar height to height
    var height = bars[i].style.height;

    //Provide darkblue color to the ith bar
    bars[i].style.backgroundColor = "#211554";

    // To pause the execution of code for 500 milliseconds
    await setDelay(500);

    // For placing selected element at its correct position
    while (j >= 0 && Number(bars[j].childNodes[0].innerText) > key) {
      // Provide darkblue color to the jth bar
      bars[j].style.backgroundColor = "#a393e3";

      // For placing jth element over (j+1)th element
      bars[j + 1].style.height = bars[j].style.height;
      bars[j + 1].childNodes[0].innerText = bars[j].childNodes[0].innerText;

      // Assign j-1 to j
      j = j - 1;

      await setDelay(500);

      for (var k = i; k >= 0; k--) {
        bars[k].style.backgroundColor = " #5539cc";
        bars[k].classList.add("bar_insertion_sorted");
        bars[k].childNodes[0].style.color = "#211554";
        bars[k].childNodes[0].style.backgroundColor = "#a393e3";
      }
    }

    // Placing the selected element to its correct position
    bars[j + 1].style.height = height;
    bars[j + 1].childNodes[0].innerText = key;

    await setDelay(500);

    // Provide light purple color to the ith bar
    bars[i].style.backgroundColor = "#dad4f4";
  }
  bars[bars.length - 1].style.backgroundColor = " #5539cc";
  bars[bars.length - 1].childNodes[0].style.color = " #211554";
  bars[bars.length - 1].childNodes[0].style.backgroundColor = "#a393e3";
};

const insertionInfo = () => {
  const infoHtml = `<div class="info_wrapper">
  <div id="sort_info_container">
    <h1 class="font_purple">Insertion Sort</h1>

    <h2 class="font_lightpurple">Visualizer Legend</h2>
    <div class="legend_wrapper">
      <div class="color color_darkpurple">Sorted Section</div>

      <div class="color color_lightpurple">Iterator</div>
      <div class="color color_purple">Element to be Inserted</div>
    </div>
    <h2 class="font_lightpurple">Description</h2>
    <p>
      This is an in-place comparison-based sorting algorithm. Here, a
      sub-list is maintained which is always sorted. For example, the lower
      part of an array is maintained to be sorted. An element which is to be
      'insert'ed in this sorted sub-list, has to find its appropriate place
      and then it has to be inserted there. Hence the name, insertion sort.
      The array is searched sequentially and unsorted items are moved and
      inserted into the sorted sub-list (in the same array)
    </p>
    <h2 class="font_lightpurple">Time Complexity:</h2>
    <span style="font-size: 2em; color: red">O(n<sup>2</sup>)</span>
    <p>Average and Worst</p>
  </div>
</div>`;
  const info = (document.getElementById("info_panel").innerHTML = infoHtml);
};
