# Register and Install a Site Package

 **Tested in:** [TYPO3v13](/Tags/TYPO3v13.md) **Categories:** [Beginner](/Tags/Beginner.md) [SitePackage](/Tags/SitePackage.md) [Backend](/Tags/Backend.md) **Author:** [@ninaaline](https://my.typo3.org/u/ninaaline)

After [creating the file structure for the Site Package](/10GettingStarted/40SitePackages/10CreateABasicSitePackage/CreateTheSitePackageFileStructure.md), the Site Package exists on your disk but is not yet known to the TYPO3 installation.

This guide covers how to register the local directory as a Composer repository and install it into your project.

## Learning Objective

In this guide, you will learn the two essential Composer commands to link and activate your local Site Package folder within your TYPO3 installation.

## Prerequisites

### Tools and technology

* Access to the command line (Terminal) in your project root
* A Composer-based TYPO3 installation (as explained in [Installing TYPO3 with Composer](https://docs.typo3.org/permalink/t3coreapi:installation-composer))

### Knowledge and skills

* You have completed the [Create the Site Package File Structure](/10GettingStarted/40SitePackages/10CreateABasicSitePackage/CreateTheSitePackageFileStructure.md) guide.
* Basic knowledge of how to use a Terminal

## Register the local package path

First, you must tell your project's root `composer.json` where to look for custom packages. This creates a link to your `packages/` folder.

1. In your Terminal, make sure you are in your project root by running `pwd`.
2. Run the following command:

```bash
composer config repositories.site-package path packages/my_site_package
```

This command adds a "repositories" section to your main `composer.json` file. It allows Composer to treat the local folder like a remote repository.

> [!NOTE]
> When you run the `composer config` command, Composer modifies the `composer.json` file in your **project root**. It adds a `repositories` entry that looks like this:
>
> ```json
> "repositories": [
>     {
>         "type": "path",
>         "url": "packages/*"
>     }
> ]
> ```
>
> This tells Composer: "Before looking on the internet (Packagist), check if the requested package exists in our local `packages/` folder."


## Install the package

Installing a package with Composer means adding it to your package’s requirements. Use the vendor and package name exactly as you defined them in the Site Package's `composer.json` file.

1. Run the following command in your Terminal:

```bash
composer require my-vendor/my-site-package
```

The extension is now officially installed in the system.

## Summary

You have successfully registered and installed your Site Package. It is now recognized by TYPO3 as a valid extension and is ready to be activated.

## Next Steps

Now that the package is installed, the final step to make it functional is:

* [Activate the Site Package in the Site Configuration](/10GettingStarted/40SitePackages/10CreateABasicSitePackage/ActivateSitePackage.md)

## Resources

* [Composer Documentation](https://getcomposer.org/doc/)
