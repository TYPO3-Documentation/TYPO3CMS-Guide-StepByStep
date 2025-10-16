# Implementing Site Sets in TYPO3
<!-- #TYPO3v13 #Beginner #Intermediary #Backend #Configuration @csabareanu -->

This guide explains how to define, configure, and use **Site Sets** in TYPO3 v13 and later.
Site Sets are modular building blocks for site configuration that combine TypoScript, TSconfig,
and site settings into reusable packages.

They replace many older static TypoScript includes and simplify configuration management
for multi-site TYPO3 installations.

## Learning objective

After completing this tutorial, you will be able to:

* Explain the purpose and benefits of Site Sets in TYPO3  
* Create a Site Set inside an extension or site package  
* Define dependencies and optional dependencies  
* Add TypoScript, TSconfig, and default settings to a Site Set  
* Register the Site Set in a site configuration  
* Verify and troubleshoot Site Set loading via CLI  


## Prerequisites

### Tools and technology

Before beginning this step by step guide, ensure that:

* TYPO3 v13 or later is installed (composer-based setup is recommended)  

### Knowledge and skills

You should be familiar with:

* TYPO3 site configuration (``config/sites/``)
* Basic TypoScript syntax and file structure
* YAML configuration format
* Extension or site package conventions (``EXT:site_package``)

## Watch the video

{**Optional**. If available, embed the YouTube video version of this tutorial from the TYPO3 official channel.}

Watch this video to follow along with the steps below.

## Step-by-step instructions

### Step 1: Create a folder for your Site Set
Inside your site package or custom extension, you should create Configuration/Sets/BaseSite folder.

### Step 2: Add a config.yaml file
Every Site Set must include a ``config.yaml`` that defines metadata and dependencies. It can have the following fields:
* ``name`` – unique name (recommended format: ``vendor/set-name``)  
* ``label`` – displayed in backend Site Set lists  
* ``dependencies`` – required sets (must exist)  
* ``optionalDependencies`` – loaded if available  
* ``hidden`` – hides the set from backend UI (optional)

 ### Step 3: Add TypoScript configuration
 Create ``setup.typoscript`` to define frontend behavior. Optionally , constants can be defined in ``constants.typoscript``

 ### Step 4: Add TSconfig and site settings
 Add a ``page.tsconfig`` file for backend settings.
 Define global settings in ``settings.yaml``.
 Optionally, you can provide definitions for the TYPO3 backend Settings Editor in ``settings.definitions.yaml``

 ### Step 5: Register the Site Set in your site configuration
Open your site configuration in ``config/sites/<identifier>/config.yaml`` and register your Site Set:
dependencies:
     - my-vendor/base-site
TYPO3 automatically merges TypoScript, TSconfig, and settings from all sets in ``dependencies``.


 ### Step 6: Test and verify
 1. Clear all TYPO3 caches.  
 2. List available Site Sets using the CLI: `vendor/bin/typo3 site:sets:list`
 3. Confirm that your Site Set appears in the list and reports no missing dependencies.  
 4. Visit the frontend to verify that TypoScript and settings were applied correctly.
 5. Default settings appear in the backend module **Site Configuration → Settings**.

 If not:
* Check YAML indentation.  
* Ensure filenames match exactly (case-sensitive).  
* Confirm the Site Set is listed in ``dependencies``.  

## Summary

You have successfully created a **Site Set** and linked it to your TYPO3 site.

**You learned how to:**

* Define a Site Set’s metadata and dependencies  
* Add TypoScript, TSconfig, and YAML settings  
* Register and verify the Site Set in the site configuration  

This modular approach allows cleaner configuration management and improved reuse across projects.

## Resources
- [Site Sets Reference](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/SiteHandling/SiteSets.html)  
- [Site Settings Reference](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/SiteHandling/SiteSettings.html)  
- [Step by step guide: Setup a Site Configuration](https://docs.typo3.org/m/typo3/guide-step-by-step/main/en-us/10GettingStarted/20BasicConfiguration/30SiteConfiguration/SetUpASiteConfiguration.html)
- [Changelog: Feature 103437 – Introduce Site Sets](https://docs.typo3.org/c/typo3/cms-core/13.4/en-us/Changelog/13.1/Feature-103437-IntroduceSiteSets.html)  
