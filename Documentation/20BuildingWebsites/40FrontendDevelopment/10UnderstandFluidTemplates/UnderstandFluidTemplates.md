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

## Step 3: Create the Layout
File: `EXT:sitepackage/Resources/Private/Layouts/Default.html`:
```
<html xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers" lang="en">
    <head>
        <f:render partial="Meta/Head" />
    </head>
    <body>
        <header class="site-header">
            <nav>
                <f:render partial="Nav/Main" arguments="{items: mainMenu}" />
            </nav>
        </header>
        <main class="site-main">
            <f:render section="Main" />
        </main>
        <footer class="site-footer">
            <p>&copy; {f:format.date(date: 'now', format: 'Y')}</p>
        </footer>
    </body>
</html>
```
Key points:
* `<f:render partial="Meta/Head" />` includes the meta partial
* `<f:render partial="Nav/Main" arguments="{items: mainMenu}" />` includes the nav partial with menu items
* `<f:render section="Main" />` marks where the template’s page content will appear

## Step 4: Create the Meta Partial
File: `EXT:sitepackage/Resources/Private/Partials/Meta/Head.html`
```
<title>{pageTitle -> f:format.stripTags()}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Sample Fluid template" />
```
ViewHelpers explained:
* f:format.stripTags : removes any HTML tags from pageTitle to keep <title> clean.

## Step 5: Create the Navigation Partial
File: `EXT:sitepackage/Resources/Private/Partials/Nav/Main.html`
```
<ul class="nav">
    <f:for each="{items}" as="item">
        <li class="{f:if(condition: item.active, then: 'active')}">
            <a href="{item.link}" title="{item.title}">
                {item.title}
            </a>
        </li>
    </f:for>
</ul>
```
ViewHelpers explained:
* f:for each="{items}" as="item" : loops through all menu items
* f:if(condition: item.active, then: 'active') : adds active class for the current page

## Step 6: Create the Page Template
File: `EXT:sitepackage/Resources/Private/Templates/Default/Default.html`
```
{namespace f=TYPO3\CMS\Fluid\ViewHelpers}
<f:layout name="Default" />
<f:section name="Main">
    <h1>{pageTitle}</h1>
    <!-- Render all content elements in colPos=0 -->
    <f:format.raw>{contentMain}</f:format.raw>
    <f:debug>{mainMenu}</f:debug>
</f:section>
```
ViewHelpers explained:
* <f:layout name="Default" /> : tells Fluid to use Layouts/Default.html
* <f:section name="Main"> : defines the section that the layout will render
* <f:format.raw> : outputs HTML directly (used here because contentMain already contains rendered HTML)
* <f:debug> : dumps variables for debugging during development

## Step 7: Create Child Pages for the Navigation

Before testing the frontend, make sure your page tree contains at least one
page **below** the site root. The MenuProcessor only renders visible,
non-hidden child pages.
### 1. Go to Web → Page
Open the backend module **Web → Page**.

### 2. Create a basic page structure
Create the following minimal page tree: <br/>
<img width="301" height="141" alt="image" src="https://github.com/user-attachments/assets/9f6474ae-a5d5-422b-b468-cb3b5ca64f48" />

## Step 7: Connect the Site Set to Your Site
If you are using Site Sets, make sure your site configuration depends on the set that contains this TypoScript.
File: `config/sites/<identifier>/config.yaml`
Add or update the `dependencies` section:
```
dependencies:
  - my-vendor/base
```
(where `my-vendor/base` is the `name` defined in your Site Set’s `config.yaml`).

## Step 8: Test and Verify
### Flush caches:
* `vendor/bin/typo3 cache:flush`
### Add content:
* Go to Web → Page in the backend
* On your root or subpage, add some content elements in the normal column (colPos=0)
### Check the frontend:
* You should see:
  * The HTML structure from `Layouts/Default.html`
  * The navigation built from `Partials/Nav/Main.html`
  * The `<title>` coming from `Partials/Meta/Head.html`
  * All content elements rendered (thanks to contentMain TypoScript variable)
### Use debug tools:
* The `<f:debug>{mainMenu}</f:debug>` output will show the structure of the mainMenu array.
* Remove debug outputs when done.

## Troubleshooting

| Problem                                         | Possible Cause                               | What to Check                                                                 |
|-------------------------------------------------|----------------------------------------------|--------------------------------------------------------------------------------|
| Content elements not visible                    | Wrong column                                 | Make sure elements are in **normal column** (`colPos = 0`).                    |
| “Content Element … has no rendering definition” | Fluid Styled Content TypoScript not loaded   | Ensure fluid imports are present at the top of `setup.typoscript`.              |
| Navigation empty                                | No site root or pages hidden                 | Mark the root page as **Site Root** and ensure pages are **visible** and `Access -> Page enabled in menus` is checked. |
| Template not found                              | Wrong paths or filenames                     | Check `templateRootPaths`, folder names, and `templateName = Default`.         |
| Nothing changes in frontend                     | Cache not cleared                            | Run: `vendor/bin/typo3 cache:flush`.                                           |

## Conclusion
In this tutorial, you learned how TYPO3 renders a page using **Layouts**, **Templates**, and **Partials**, and how these pieces work together through **FLUIDTEMPLATE**, **TypoScript**, and **Fluid Styled Content**.
You built a working frontend structure that includes:
* A clean HTML layout
* A reusable navigation partial
* Custom meta/head markup
* A default page template
* Automatic rendering of all content elements

## Resources
- **Fluid Templating Official Documentation**  
  https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/Fluid/Index.html  
- **Fluid Styled Content Documentation**  
  https://docs.typo3.org/c/typo3/cms-fluid-styled-content/main/en-us/  
- **TypoScript Reference**  
  https://docs.typo3.org/m/typo3/reference-typoscript/main/en-us/     
