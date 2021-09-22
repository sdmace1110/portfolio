const sort_merge = async () => {
  mergeInfo();

  let bars = document.querySelectorAll(".bar");
  let left = 0;
  let right = Number(bars.length) - 1;

  await mergeSort(bars, left, right);
};

const mergeSort = async (bars, l, r) => {
  console.log("In mergeSort()");
  // If left is greater or equal to right then we're in the center
  if (l >= r) {
    return;
  }
  // Assign a middle element
  const m = l + Math.floor((r - l) / 2);
  console.log(`left=${l} mid=${m} right=${r}`, typeof m);

  // Divide array into two, then recursively continue to split until reaching middle
  await mergeSort(bars, l, m);
  await mergeSort(bars, m + 1, r);

  // Now we merge all the divisions
  await merge(bars, l, m, r);
};

const merge = async (bars, low, mid, high) => {
  // Calculate the size of the two arrays
  const sizeOfLeftArray = mid - low + 1;
  const sizeOfRightArray = high - mid;

  // Create the arrays
  let left = new Array(sizeOfLeftArray);
  let right = new Array(sizeOfRightArray);

  for (let i = 0; i < sizeOfLeftArray; i++) {
    await waitforme(delay);

    // Add color
    bars[low + i].style.background = "orange";
    left[i] = bars[low + i].style.height;
  }

  for (let i = 0; i < sizeOfRightArray; i++) {
    await setDelay(delay);

    // Add color
    bars[mid + 1 + i].style.background = "yellow";
    right[i] = bars[mid + 1 + i].style.height;
  }

  await setDelay(delay);

  let i = 0,
    j = 0,
    k = low;

  while (i < sizeOfLeftArray && j < sizeOfRightArray) {
    await waitforme(delay);

    // Add comparison colors
    if (parseInt(left[i]) <= parseInt(right[j])) {
      if (sizeOfLeftArray + sizeOfRightArray === bars.length) {
        bars[k].style.background = "green";
      } else {
        bars[k].style.background = "lightgreen";
      }

      bars[k].style.height = left[i];
      i++;
      k++;
    } else {
      if (sizeOfLeftArray + sizeOfRightArray === bars.length) {
        bars[k].style.background = "green";
      } else {
        bars[k].style.background = "lightgreen";
      }
      bars[k].style.height = right[j];

      j++;
      k++;
    }
  }
  while (i < sizeOfLeftArray) {
    await setDelay(delay);

    if (sizeOfLeftArray + sizeOfRightArray === bars.length) {
      bars[k].style.background = "green";
    } else {
      bars[k].style.background = "lightgreen";
    }
    bars[k].style.height = left[i];

    i++;
    k++;
  }
  while (j < sizeOfRightArray) {
    await setDelay(delay);

    if (sizeOfLeftArray + sizeOfRightArray === bars.length) {
      bars[k].style.background = "green";
    } else {
      bars[k].style.background = "lightgreen";
    }
    bars[k].style.height = right[j];

    j++;
    k++;
  }
};

const mergeInfo = () => {
  const infoHtml = `   <div class="info_wrapper">
  <div id="sort_info_container">
    <h1 class="font_yellow">Merge Sort</h1>

    <h2 class="font_orange">Visualizer Legend</h2>
    <div class="legend_wrapper">
      <div class="color color_lightyellow">Right-hand Division</div>

      <div class="color color_orange">Left-hand Division</div>
      <div class="color color_darkgreen">Complete Sorted Section</div>
      <div class="color color_lightgreen">Pre-Sorted by Division</div>
    </div>
    <h2 class="font_orange">Description</h2>
    <p>
      Merge sort is base on divide and conquer technique.  Merge sort first divides teh array into equal parts then combines them.
    </p>
    <h2 class="font_orange">Time Complexity:</h2>
    <span style="font-size: 2em; color: red">O(n log n)</span>
    <p>Average and Worst</p>
  </div>
</div>`;
  const info = (document.getElementById("info_panel").innerHTML = infoHtml);
};
