package com.example.bst;

import java.util.*;

public class BST {

    /*--------------------------------------------------------------
                          I. Structural Classes
    ________________________________________________________________

    CLASSES:  Node, myBST

    Node: creates the node class with key, left, and right children
    MyBST: Creates the BST holder

     -------------------------------------------------------------*/

    // Define Node class
    static class Node {
        // Key is a data packet
        int value;
        // Each BST node has a right/left child:
        // left child < root node <= right child
        Node left, right;
        // Node constructor
        public Node(int item) {
            value = item;
            left = null;
            right = null;
        }
    }

    // Create root of BST
    Node root;

    // Root Constructor
    MyBST(){
        root = null;
    }

    /*--------------------------------------------------------------
                        II. Utility Classes
    ________________________________________________________________

    CLASSES:  insert, insertNode, deleteEle, deleteNode

    insert: Helper class to call insertNode
    insertNode: Adds a node and key to the BST
    deleteEle: Helper class to call deleteNode
    deleteNode: Deletes a node and key from BST

     -------------------------------------------------------------*/

    // Calls insert class
    void insert(int value) {
        root = insertNode(root, value);
    }

    // Recursive function to add a node and given value to the BST
    Node insertNode(Node root, int value) {

        // If the tree is empty, return the root
        if (root == null) {
            root = new Node(value);
            return root;
        }
        // If value is less than root, recurse to the left
        if (value < root.value)
            root.left = insertNode(root.left, value);
        // Otherwise recurse to the right
        if (value >= root.value)
            root.right = insertNode(root.right, value);

        // Return the node pointer
        return root;
    }

    // DELETION CLASSES
    // This method calls deleteNode()
    void deleteKey(int key) {
        root = deleteNode(root, key);
    }

    /* A recursive function to
      delete an existing key in BST
     */
    Node deleteNode(Node root, int key) {
        /* Base Case: If the tree is empty
        if (root == null)
            return root; */

        /* Otherwise, recur down the tree */
        if (key < root.value)
            root.left = deleteNode(root.left, key);
        else if (key > root.value)
            root.right = deleteNode(root.right, key);

            // if key is same as root's
            // key, then This is the
            // node to be deleted
        else {
            // node with only one child or no child
            if (root.left == null)
                return root.right;
            else if (root.right == null)
                return root.left;

            // node with two children: Get the inorder
            // successor (smallest in the right subtree)
            root.value = minValue(root.right);

            // Delete the inorder successor
            root.right = deleteNode(root.right, root.value);
        }

        return root;
    }

    int minValue(Node root) {
        int minv = root.value;
        while (root.left != null) {
            minv = root.left.value;
            root = root.left;
        }
        return minv;
    }


    /*--------------------------------------------------------------
                        III. Traversal Procedures
    ________________________________________________________________

    CLASSES:  inorder, postorder, preorder, inOrderTrav,
              preOrderTrav, postOrderTrav

    inorder: Helper class to call inOrderTrav
    postorder: Helper class to call postOrderTrav
    preorder: Helper class to call preOrderTrav
    inOrderTrav: traverses BST inorder
    postOrderTrav: traverses BST in postorder
    preOrderTrav: traverse BST in preorder

     -------------------------------------------------------------*/

    // Calls inorder class
    void inorder() {
        inorderTrav(root);
    }

    // Calls preorder class
    void preorder(){
        preorderTrav(root);
    }

    // Calls postorder class
    void postorder(){
        postorderTrav(root);
    }

    // Inorder traversal
    // Explore Nodes in order -> Left-Node-Right
    void inorderTrav(Node root) {
        if (root != null) {
            inorderTrav(root.left);
            System.out.print(root.value + " ");
            inorderTrav(root.right);
        }
    }
    // PreOrder Traversal
    // Explore Nodes in order -> Node-Left-Right
    void preorderTrav(Node node){
        if (node == null)
            return;

        System.out.print(node.value + " ");
        preorderTrav(node.left);
        preorderTrav(node.right);
    }
    // PostOrder Traversal
    // Explore Nodes in order -> Left-Right-Node
    void postorderTrav(Node node){
        if (node == null)
            return;
        postorderTrav(node.left);
        postorderTrav(node.right);
        System.out.print(node.value + " ");
    }


    /*--------------------------------------------------------------
                             IV. Program Driver
    ________________________________________________________________
      CLASSES:  main

      main: Driver class which instantiates all others

       -------------------------------------------------------------*/
    // Driver Code
    public static void main(String[] args) {
        // Instantiate our tree
        BST tree = new BST();
        // Instantiate random numbers to populate tree
        Random r = new Random();
        // Set number of nodes for the tree
        int num = 10;

        System.out.println("Let's populate a Binary Search Tree with random integers (1-25) and print each number as it is inserted:");
        // Populate tree with random ints (1-25)
        for(int i = 0; i < num; i++){
            int n = r.nextInt(25) + 1;
            tree.insert(n);
            System.out.println(i+1 + ". Randomized n = " + n);
        }

        // Traversal calls
        System.out.println("\nIn-Order traversal of the tree:");
        tree.inorder();
        System.out.println("\n\nPost-Order traversal of the tree:");
        tree.postorder();
        System.out.println("\n\nPre-Order traversal of the tree:");
        tree.preorder();

        // Now we'll collect the smallest, largest, middle, and random
        // Delete the selections and recompile the lists.
    }
}




