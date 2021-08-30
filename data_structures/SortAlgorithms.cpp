#include <iostream>
#include <vector>
#include <stdlib.h>
#include <bits/stdc++.h>
#include <typeinfo>

using namespace std;

// Function Protoypes
void quickSort(vector<int>&,int, int);
int partitioner(vector<int>&, int, int);
void mergeSort(vector<int>&, int, int);
void merger(vector<int>&, int, int, int);
void insertionSort(vector<int>&, int);
void populateRand(vector<int>&, int);
void printVector(vector<int>&, int);
void heapSort(vector<int>&, int);
void heapify(vector<int>&, int, int);

// Main driver
int main()
{
    // Declare variables used throughout
    // mLow, mHigh used in mergeSort, selection used as menu controller
    int mLow, mHigh, selection;
    // Boolean to exit program
    bool readyToExit = false;
    // Vectors used hold integers to be sorted
    vector<int> A, B, C, D;
    // Starting vector element
    int p=0;
    // Size of the vector
    int q=25;
    // Size of vector used in heapSort
    int n = 25;

    // Main Menu
    do{
        cout << "________________________________________________________________________________________________________" << endl;
        cout << "__MAIN MENU_____________________________________________________________________________________________" << endl;
        cout << "\n --------> 0 - Exit | 1 - Quick Sort | 2 - Merge Sort | 3 - Heap Sort | 4 - Insertion Sort   <---------" << endl;
        cout << "________________________________________________________________________________________________________" << endl;
        cout << "________________________________________________________________________________________SORTING IN C++__" << endl;
        cout << "\nMake your choice: ";
        // Get user selection
        cin >> selection;

        switch(selection){
            case 0:
                readyToExit = true;
                cout << "Thank you and good night.";
                break;
            case 1:
                populateRand(A,q);
                // Print vector
                cout << "\n\n Here is the initial unsorted vector: " << endl;
                printVector(A, q);
                //Run sort
                quickSort(A, p, q);
                // Print results
                cout << "\n+++++ Printing QUICK sorted vector +++++" << endl;
                printVector(A, q);
                // Clear vector
                A.clear();
                cout << "\n\n";
                break;
            case 2:

                populateRand(B,q);

                cout << "\n\n Here is the initial unsorted vector: " << endl;
                printVector(B, q);

                mLow = 0;
                mHigh = B.size() - 1;
                n = B.size() / 2;

                mergeSort(B, mLow, mHigh);

                cout << "\n+++++ Printing MERGE sorted vector +++++" << endl;
                printVector(B, q);

                B.clear();

                cout << "\n\n";
                break;

            case 3:
                populateRand(C, n);
                cout << "\n\n Here is the initial unsorted vector: " << endl;
                printVector(C, n);

                heapSort(C, n);

                cout << "+++++ Printing HEAP sorted vector +++++" << endl;
                printVector(C, n);

                cout << "\n\n";
                C.clear();
                break;
            case 4:
                populateRand(D, n);
                cout << "\n\n Here is the initial unsorted vector: " << endl;
                printVector(D, n);

                insertionSort(D, n);

                cout << "+++++ Printing INSERTION sorted vector +++++" << endl;
                printVector(D, n);
                cout << "\n\n";

                D.clear();
                break;


            default:
                cout << "I do not understand what you're asking of me.  You typed: ::" << selection << ":: which cannot be computed.  Please try again." << endl;
                break;
        }

    }while(!readyToExit);

    return 0;
}


// Function declarations
// Prints vector
void printVector(vector<int>& A, int q){
    for (int i=0; i < q; i++){
        cout << A.at(i) << " ";
    }
    cout << endl;
}

// Quick Sort:
// Choose a pivots then divide-and-conquer both side of pivot
void quickSort(vector<int>& A, int p,int q){
    int pivotLoc;

    if(p<q){
        pivotLoc=partitioner(A, p,q);
        quickSort(A,p,pivotLoc);
        quickSort(A,pivotLoc+1,q);
    }
}

// Helper function for quickSort that returns leftWall (lowest ele)
int partitioner(vector<int>& A, int low,int hi){
    int pivot = A[low];
    int leftWall = low;
    int lowPlusOne;

    for(lowPlusOne=low+1; lowPlusOne < hi; lowPlusOne++){
        if(A[lowPlusOne] <= pivot){
            leftWall = leftWall + 1;
            swap(A[lowPlusOne],A[leftWall]);
        }
    }

    swap(A[low],A[leftWall]);
    return leftWall;
}

// Merge Sorting implementation
void merger(vector<int>& a, int low, int high, int mid, int reps){
    reps++;

	int temp[high - low + 1];
	int idxLow = low;
	int counter = 0;
	int midPlusOne = mid + 1;

	// Merge the two parts into temp[].
	while (idxLow <= mid && midPlusOne <= high){
		if (a[idxLow] < a[midPlusOne]){
			temp[counter] = a[idxLow];
			counter++;
			idxLow++;
		}else{
			temp[counter] = a[midPlusOne];
			counter++;
			midPlusOne++;
		}
	}

	// Insert all the remaining values from i to mid into temp[].
	while (idxLow <= mid){
		temp[counter] = a[idxLow];
		counter++;
		idxLow++;
	}

	// Insert all the remaining values from j to high into temp[].
	while (midPlusOne <= high){
		temp[counter] = a[midPlusOne];
		counter++;
		midPlusOne++;
	}


	// Assign sorted data stored in temp[] to a[].
	for (idxLow = low; idxLow <= high; idxLow++)
		a[idxLow] = temp[idxLow-low];

}

// A function to split array into two parts.
void mergeSort(vector<int>& a, int low, int high){
	int mid;
	int reps = 0;
	if (low < high){
		mid=(low+high)/2;
		// Split the data into two half.
		mergeSort(a, low, mid);
		mergeSort(a, mid+1, high);

		// Merge them to get sorted output.
		merger(a, low, high, mid, reps);
	}
}

// Insertion Sort implementation
void insertionSort(vector<int>& A, int n){
    int i, key, j;
    for (i = 1; i < n; i++){
        key = A[i];
        j = i - 1;

        /* Move elements of arr[0..i-1], that are
        greater than key, to one position ahead
        of their current position */
        while (j >= 0 && A[j] > key){
            A[j + 1] = A[j];
            j = j - 1;
        }
        A[j + 1] = key;
    }
}

// Function to populate a vector with random numbers (1-50)
void populateRand(vector<int>& A, int n){
    for(int i = 0; i < n; i++){
        A.push_back(rand() % 50 + 1);
    }
}

// Heap Sort function
void heapSort(vector<int>& A, int n){
    int temp;

    // Heapify the first half in case of pre-sorting
    for (int i = n / 2 - 1; i >= 0; i--){
        heapify(A, n, i);
    }
    // This one focuses the last element and works
    // backwards to the 0th element to sort the heap
    for (int i = n -1; i >= 0; i--){
        temp = A[0];
        A[0] = A[i];
        A[i] = temp;
        heapify(A, i, 0);
    }
}

// Creates a max heap
void heapify(vector<int>& A, int n, int i){

    int temp;
    // i is the iterator element sent from heapSort
    // n is the size of the vector
    int largest = i;

    int left = 2 * i + 1;  // Defines of vector limits (penultimate)
    int right = 2 * i + 2; // Final vector limit  - both can be larger that n

    // If left/right are within vector limits, compare values
    // if left is larger, change largest to reflect that
    if (left < n && A[left] > A[largest])
        largest = left;
    // Now check right against largest
    if (right < n && A[right] > A[largest])
        largest = right;
    // if largest has changes, swap and re-heapify
    if (largest != i){
        temp = A[i];  // 2
        A[i] = A[largest];  // 3
        A[largest] = temp; // 2
        heapify(A, n, largest);
    }
}
