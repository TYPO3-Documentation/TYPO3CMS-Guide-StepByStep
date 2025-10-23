# Implementing Site Sets
<!-- #TYPO3v13 #Intermediary #Backend #Configuration @csabareanu -->

This guide explains how to define, configure and use **Site Sets** in TYPO3 v13+.
Site Sets are modular building blocks for site configuration that combine TypoScript, TSconfig,
and site settings into reusable packages.

They replace many older static TypoScript includes and simplify configuration management
for multi-site TYPO3 installations.

## Real World Scenario
You’re building multiple websites for the same company. Each site should share a default page setup, meta tags, 
and some backend configuration (for example some RTE settings). 
Instead of copying code manually, you’ll create a Site Set called `my-vendor/base` that can be reused anywhere.


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

* TYPO3 v13+ is installed (composer-based setup is recommended)  

### Knowledge and skills

You should be familiar with:

* TYPO3 site configuration (``config/sites/``)
* Basic TypoScript syntax and file structure
* YAML configuration format
* Extension or site package conventions (``EXT:site_package``)

## Step-by-step instructions

### Step 1: Create a folder for your Site Set
Inside your site package or custom extension, you should create `Configuration/Sets/base` folder.

### Step 2: Add a config.yaml file
Every Site Set must include a ``config.yaml`` that defines metadata and dependencies. It can have the following fields:
* ``name`` – unique name: `my-vendor/base` (recommended format: ``vendor/set-name``)  
* ``label`` – displayed in backend, in the site module. Should be as unique as possible - `Base Site Set`
* ``dependencies`` – required sets (must exist). Loads ``setup.typoscript``, ``constants.typoscript``, ``page.tsconfig`` and ``config.yaml`` from the site set definitions of this or other extensions. 
* ``optionalDependencies`` – loaded if available (if extension is not installed, no errors are reported, in contrast to ``dependencies``)
* ``hidden`` – hides the set from backend set selection and the console command `bin/typo3 site:sets:list` (optional)

### Step 3: Add TypoScript configuration
Create ``setup.typoscript`` to define frontend behavior. Optionally, constants can be defined in ``constants.typoscript``

### Step 4: Add TSconfig and site settings
Add a ``page.tsconfig`` file for backend settings.
Define global settings in ``settings.yaml``.
Optionally, you can provide definitions for the TYPO3 backend Settings Editor in ``settings.definitions.yaml``

### Step 5: Register the Site Set in your site configuration
Open your site configuration in ``config/sites/<identifier>/config.yaml`` and register your Site Set:
```
dependencies:
     - my-vendor/base
```
TYPO3 automatically merges TypoScript, TSconfig, and settings from all sets in ``dependencies``.


### Step 6: Test and verify
1. Clear all caches.  
2. List available Site Sets using the CLI: `vendor/bin/typo3 site:sets:list`
3. Confirm that your Site Set appears in the list (if ``hidden: false``) and reports no missing dependencies.  
4. Visit the frontend to verify that TypoScript and settings were applied correctly.
5. Default settings appear in the backend module **Site Configuration → Settings** (if ``hidden: false``).

If not:
* Check YAML indentation
* Ensure filenames match exactly
* Confirm the Site Set is listed in ``dependencies``

## Summary

You have successfully created a **Site Set** and linked it to your TYPO3 site.

**You learned how to:**

* Define a Site Set’s metadata and dependencies  
* Add TypoScript, TSconfig, and YAML settings  
* Register and verify the Site Set in the site configuration
* Create a reusable **Site Set** in an extension
* Quickly replicate configurations across all the websites

## Conclusion - Why Site Sets Matter in Real Projects
In the context of the real-world scenario — managing multiple websites for the same company — Site Sets save you from copying TypoScript, TSconfig 
and settings across projects. Instead of manually configuring every new site, you define everything once in EXT:site_package/Configuration/Sets/base/ 
and simply activate it in each new site configuration. This way, you will obtain:
* **Consistency accross projects** - all websites start with the same trusted configuration defined in your Site Set
* **Time savings** - by not creating additional configuration files
* **Easy Maintenance** - if changes needs to be done, you have to modify the Site Set once and all connected sites will inherit the updates
* **Scalability** - as the project grows, you can split features into multiple Site Sets and add only what each site needs.

In short: **Site Sets turn your TYPO3 instance
into a modular, maintainable, future-proof system — ideal for building multiple websites.**

## Resources
- [Site Sets Reference](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/SiteHandling/SiteSets.html)  
- [Site Settings Reference](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/SiteHandling/SiteSettings.html)  
- [Step by step guide: Setup a Site Configuration](https://docs.typo3.org/m/typo3/guide-step-by-step/main/en-us/10GettingStarted/20BasicConfiguration/30SiteConfiguration/SetUpASiteConfiguration.html)
- [Changelog: Feature 103437 – Introduce Site Sets](https://docs.typo3.org/c/typo3/cms-core/13.4/en-us/Changelog/13.1/Feature-103437-IntroduceSiteSets.html)  
