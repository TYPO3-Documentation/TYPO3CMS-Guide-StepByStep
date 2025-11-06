# Implementing a Site Set with Editable Settings and Custom CSS

This guide shows how to build a **practical, working Site Set** for TYPO3 v13.  
You’ll create a Site Set named `my-vendor/base` inside your site package (`EXT:sitepackage`) that:

* Adds a default meta description and site contact info (editable in backend)  
* Renders them in a simple Fluid template  
* Loads a custom CSS file to style the title

## Step 1: Create the Site Set folder
Inside your extension, create the folder:
`EXT:sitepackage/Configuration/Sets/base/`

## Step 2: Create `config.yaml`
Every Site Set needs a manifest that defines its name and dependencies.

**File:** `EXT:sitepackage/Configuration/Sets/base/config.yaml`
```
name: 'my-vendor/base'
label: 'Base Site Set'
dependencies: []
optionalDependencies: []
hidden: false
```
## Step 3: Add editable site settings
These files define the default settings and make them editable in the backend.

**File:** `EXT:sitepackage/Configuration/Sets/base/settings.yaml`
```
settings:
  site:
    meta:
      description: 'Default meta description from settings.yaml'
    contact:
      email: 'contact@example.com'
```
**File:** `EXT:sitepackage/Configuration/Sets/base/settings.definitions.yaml`
```
settings:
  site.meta.description:
    type: string
    label: 'Base Settings: Meta Description'
    default: 'Default meta description from definitions'
  site.contact.email:
    type: string
    label: 'Base Settings: Contact Email'
    default: 'contact@example.com'
```
## Step 4: Add TypoScript (setup.typoscript)
This TypoScript defines your page rendering, meta description, CSS, and settings processor.

**File:** `EXT:sitepackage/Configuration/Sets/base/setup.typoscript`
```
page = PAGE
page.10 = FLUIDTEMPLATE
page.10 {
  templateName = Default
  templateRootPaths.10 = EXT:sitepackage/Resources/Private/Templates/
  partialRootPaths.10 = EXT:sitepackage/Resources/Private/Partials/
  layoutRootPaths.10 = EXT:sitepackage/Resources/Private/Layouts/

  dataProcessing {
    10 = TYPO3\CMS\Frontend\DataProcessing\SiteProcessor
  }
}

# Include custom CSS
page.includeCSS.base = EXT:sitepackage/Resources/Public/Css/base.css
```

## Step 5: Backend configuration (page.tsconfig)
Rename the Common section in the New Content Element Wizard

**File:** `EXT:sitepackage/Configuration/Sets/base/page.tsconfig`
```
mod.wizards.newContentElement.wizardItems.common.header = Common Elements (Site Set active)
```
## Step 6: Add your CSS file
**File:** `EXT:sitepackage/Resources/Public/Css/base.css`
```
/* Base Site Set Styles */
h1 {
  color: darkred;
  font-weight: 700;
}
```

## Step 7: Create a simple Fluid template
**File:** `EXT:sitepackage/Resources/Private/Templates/Default/Default.html`
```
<html xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers">
<body>
  <h1>Site Settings Test</h1>

  <p><strong>Meta Description:</strong> {site.settings.site.meta.description}</p>
  <p><strong>Contact Email:</strong> {site.settings.site.contact.email}</p>

</body>
</html>
```
Thanks to the `SiteProcessor` in TypoScript, you can access `{site.settings}` here.

## Step 8: Register the Site Set in your site configuration
**File:** `config/sites/your-site/config.yaml`
```
dependencies:  
  - my-vendor/base
```

## Step 9: Clear caches and verify
1. Clear caches
2. Open **Backend → Site → Settings**  . You’ll see your **Base Settings: Meta Description** and **Contact Email** fields.
3. Change them and save.   
4. Visit your site’s frontend — you should see:
```
Site Settings Test
Meta Description: (your value from backend)
Contact Email: (your value)
```
5. The `<h1>` title appears **dark red** — proving the CSS loaded.
6. Check the Common section in the New Content Element Wizard and see the title changed


## Summary
You now have a **complete Site Set** that provides:

* Editable Site Settings (in **Backend → Sites → Settings**)  
* Custom TypoScript  
* A working Fluid template with `{site.settings}`  
* Automatically included CSS styling

This Site Set can now be reused across any project —  just add `- my-vendor/base` to another site’s `config.yaml`.

## Resources
- [Site Sets Reference](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/SiteHandling/SiteSets.html)  
