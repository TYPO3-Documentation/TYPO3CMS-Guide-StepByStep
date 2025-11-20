# Understand Fluid Templates in TYPO3 v13 – A Practical, Step-by-Step Guide
<!-- #TYPO3v13 #Intermediary #Frontend #Fluid @csabareanu -->

This guide shows how TYPO3 renders pages using Fluid templates, and how to build a clean template structure in your sitepackage (EXT:sitepackage) using:
* Layouts (global page shell)
* Templates (page-specific content)
* Partials (reusable snippets)
You will also learn how to render navigation and all content elements of a page using TypoScript + Fluid + Fluid Styled Content

## Real-world Goal
You are building a custom frontend for a TYPO3 website. Throughout this guide we will build:
* A shared page layout (header, navigation, footer)
* A default page template that renders all content in the main column
* Reusable partials for meta tags and navigation
* A basic understanding of common Fluid ViewHelpers

## Learning Objectives
After completing this tutorial, you will be able to:
* Explain the difference between Layout, Template, and Partial in Fluid
* Configure FLUIDTEMPLATE in TypoScript (with Fluid Styled Content loaded)
* Render all content elements from a column with TypoScript and Fluid
* Use partials for meta tags and navigation
* Use common Fluid ViewHelpers in templates

## Prerequisites
#### Tools and Technology
* TYPO3 v13+ (Composer-based setup recommended)
* A sitepackage extension (`EXT:sitepackage`)
* `typo3/cms-fluid-styled-content` installed via Composer

#### Knowledge and Skills
You should be familiar with:
* Basic TYPO3 concepts (pages, content elements, site configuration)
* TypoScript basics (what `PAGE` and `FLUIDTEMPLATE` are)
* File structure inside a sitepackage (`Resources/Private`, `Configuration/Sets`)

## Step 0: Understand Layouts, Templates, and Partials
Before touching code, it’s important to understand the three Fluid building blocks you’ll use:

#### Layout
A Layout defines the global HTML structure shared by multiple templates.
* Contains `<html>`, `<head>`, `<body>`, `<header>`, `<footer>`
* Provides a placeholder for template content via <f:render section="Main" />
##### Example behavior:
All pages have the same header/footer, but different main content.

#### Template
A Template defines the content for a specific page type.
* References a layout via `<f:layout name="Default" />`
* Defines one or more sections, e.g. `<f:section name="Main">`
###### Example behavior:
A “Default” template shows page title and main column content. Another template might show a special landing page.

#### Partial
A Partial is a reusable snippet of Fluid code.
* Small building blocks: navigation, meta head, teaser card, etc.
* Can be used by multiple templates and layouts via `<f:render partial="...">`

##### Example behavior:
A `Nav/Main.html` partial used both on the homepage and subpages.

## Step 1: Create the Folder Structure
Inside your sitepackage (`EXT:sitepackage`), create the following files:
* Resources/Private/Layouts/Default.html
* Resources/Private/Partials/Meta/Head.html
* Resources/Private/Partials/Nav/Main.html
* Resources/Private/Templates/Default/Default.html

## Step 2: Configure FLUIDTEMPLATE and FSC in TypoScript
Create or edit the TypoScript file for your Site Set:

File: `EXT:sitepackage/Configuration/Sets/base/setup.typoscript`:
```
@import 'EXT:fluid_styled_content/Configuration/TypoScript/constants.typoscript'
@import 'EXT:fluid_styled_content/Configuration/TypoScript/setup.typoscript'

page = PAGE
page.10 = FLUIDTEMPLATE
page.10 {

  templateName = Default

  templateRootPaths.10 = EXT:sitepackage/Resources/Private/Templates/
  partialRootPaths.10  = EXT:sitepackage/Resources/Private/Partials/
  layoutRootPaths.10   = EXT:sitepackage/Resources/Private/Layouts/

  dataProcessing {

    # MAIN MENU
    10 = TYPO3\CMS\Frontend\DataProcessing\MenuProcessor
    10 {
      levels = 1
      includeSpacer = 0
      as = mainMenu
    }
  }

  variables {

    # PAGE TITLE
    pageTitle = TEXT
    pageTitle.field = title

    # MAIN CONTENT ELEMENTS (colPos = 0)
    contentMain = CONTENT
    contentMain {
      table = tt_content
      select {
        pidInList = this
        where = colPos=0
        orderBy = sorting
      }
      renderObj = < tt_content
    }
  }
}
```
What does this code do?
* Imports Fluid Styled Content TypoScript
* Configures page.10 as a FLUIDTEMPLATE
* Defines:
  * `mainMenu` : navigation data
  * `contentMain` : all content elements from colPos=0
  * `pageTitle` : current page title

