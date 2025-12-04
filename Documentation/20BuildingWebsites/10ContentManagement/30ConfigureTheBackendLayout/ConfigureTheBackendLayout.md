# Configure The Backend Layout
<!-- #TYPO3v13 #Intermediary #Backend #BackendLayout @csabareanu -->

This guide explains how to define and use **Backend Layouts** in TYPO3 v13 using your sitepackage (`EXT:sitepackage`).

A **Backend Layout** controls how columns are displayed in the **Page** module (backend) for editors. It does **not** directly affect frontend HTML, but it’s the foundation for a structured content editing experience and can be connected to Fluid templates.

---

## Real World Scenario

You want editors to see a clear two-column structure in the backend:

* Left column: left content (colPos = 0)  
* Right column: right content (colPos = 2)  

The default “Columns” view is too generic. You want a custom backend layout called  
**“Site Layout: Two Columns”**, and you want it:

* Available in the **Page properties -> Appearance -> Backend Layout**  
* Automatically applied to all new subpages under a specific starting page  

---

## Learning Objectives

After completing this tutorial, you will be able to:

* Explain what a Backend Layout is and what it is used for  
* Define one or more Backend Layouts in **Page TSconfig**  
* Inherit a Backend Layout to subpages  

---

## Prerequisites

### Tools and Technology

* TYPO3 v13+ (Composer-based setup)  
* A sitepackage extension: `EXT:sitepackage`  

### Knowledge and Skills

You should be familiar with:

* Page tree and basic page properties  
* Editing **Page TSconfig** (via files in your sitepackage)  
* Basic understanding of `colPos` for content columns  

---

## Step 1: Decide Your Backend Layout Structure

In this tutorial, you’ll create a simple **two-column layout**:

* Column 1: “Left” (colPos = 0)  
* Column 2: “Right” (colPos = 2)  

This will be visually shown in the **Page → Columns** view as two vertical columns.

---

## Step 2: Create / Use a Page TSconfig File

You will store Backend Layout definitions in your Site Set’s Page TSconfig.

**File:** `EXT:sitepackage/Configuration/Sets/base/page.tsconfig`

If this file already exists (from previous tutorials), you will **extend** it. Otherwise, create it.

---

## Step 3: Define the Backend Layout in Page TSconfig

Add the following configuration to `page.tsconfig`:

```typoscript
# --------------------------------------------------------
# Backend Layout: Two Columns
# --------------------------------------------------------
mod.web_layout.BackendLayouts.two_columns {
  title = Site Layout: Two Columns
  config {
    backend_layout {
      colCount = 2
      rowCount = 1

      rows {
        1 {
          columns {
            1 {
              name = Left
              colPos = 0
            }
            2 {
              name = Right
              colPos = 2
            }
          }
        }
      }
    }
  }
}
```
**What does this do?**
* Defines a Backend Layout with ID: two_columns
* Creates one row with two columns: “Left” and “Right”
* After clearing caches, this layout will be available in:
* Page properties -> Appearance tab -> Backend Layout

## Step 4: Inherit the Backend Layout to All Subpages
Often, you want an entire section of the site to use the same layout automatically.
* Open the root page (or a section root)
* Page properties -> Appearance tab -> Backend Layout and select the backend layout to use for all subpages of this page
  <img width="653" height="191" alt="image" src="https://github.com/user-attachments/assets/b5fbbdb7-057b-4b64-aad9-d5b3f96c5943" />
* All subpages automatically receive the same backend layout
  <img width="652" height="48" alt="image" src="https://github.com/user-attachments/assets/e3a89a4e-203e-4ccc-bbf3-1d83d763ca2b" />
* Editors no longer need to select the layout manually, but can overwrite the backend layout if necesarry. 


<img width="675" height="179" alt="image" src="https://github.com/user-attachments/assets/45adc4a2-6d49-47f7-abb2-5cbca9114985" />
