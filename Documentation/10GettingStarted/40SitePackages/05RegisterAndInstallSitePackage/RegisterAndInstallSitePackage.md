# Register and Install the Site Package

<!-- #TYPO3v13 #Beginner #SitePackage #Backend @ninaaline -->

After creating the file structure for the Site Package, the Site Package exists on your disk but is not yet known to the TYPO3 installation.

This guide covers how to register the local directory as a Composer repository and install it into your project.

## Learning Objective

In this guide, you will learn the two essential Composer commands to link and activate your local Site Package folder within your TYPO3 installation.

## Prerequisites

* You have created the file structure in `packages/my_site_package/`
  * If you haven't done this step, follow along this Guide: [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md)
* You have access to the command line (Terminal) in your project root
* Your project is based on Composer

## 1. Register the local path

First, you must tell your project's root `composer.json` where to look for custom packages. This creates a link to your `packages/` folder.

Run this command in your project root:

**Terminal:**

```
composer config repositories.site-package path packages/my_site_package
```

* This command adds a "repositories" section to your main `composer.json` file.
* It allows Composer to treat the local folder like a remote repository.

### What happens behind the scenes?

When you run the `composer config` command, Composer modifies the `composer.json` file in your **project root**. It adds a `repositories` entry that looks like this:


```json
"repositories": [
    {
        "type": "path",
        "url": "packages/*"
    }
]
```

This tells Composer: "Before looking on the internet (Packagist), check if the requested package exists in our local `packages/` folder."


## 2. Install the package

Now you can "require" the package. Use the vendor and package name exactly as you defined them in the Site Package's own `composer.json` file.

Run the following command:

**Terminal:**

```
composer require my-vendor/my-site-package
```

* Composer will now create a symlink from the `packages/` folder to the `vendor/` directory (or `public/typo3conf/ext/`).
* The extension is now officially "installed" in the system.

## Summary

You have successfully registered and installed your Site Package. It is now recognized by TYPO3 as a valid extension and is ready to be activated.

## Next Steps

Now that the package is installed, the final step to make it functional is:

* [Activate the Site Package in the Site Configuration](ActivateSitePackage.md)
