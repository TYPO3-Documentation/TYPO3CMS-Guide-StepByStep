# Create the Site Package File Structure

<!-- #TYPO3v13 #Beginner #Backend # SitePackage @ninaaline -->

A Site Package is a custom TYPO3 extension that bundles all your project-specific configurations, templates, and assets. This guide focuses on the single task of creating the minimal file structure required for TYPO3 to recognize your Site Package.

## Learning objective

In this step-by-step guide you will learn how to manually create the essential directory structure and the `composer.json` file for a TYPO3 site package.

### Prerequisites

### Tools and technology

* Access to your TYPO3 installation's file system
* A code editor (e.g., VS Code or PhpStorm)
* A Composer-based TYPO3 installation (as explained in [Installing TYPO3 with Composer](https://docs.typo3.org/permalink/t3coreapi:installation-composer))

### Knowledge and skills

* Basic knowledge of Composer
* Basic knowledge of JSON and YAML

## Create the Directory Structure

1. Navigate to the root of your TYPO3 installation. In a standard setup, custom extensions are placed in a folder named `packages/`.
2. If the `packages/` folder does not exist yet, create it in the root of your TYPO3 installation`.
3. Create a new directory for your Site Package (e.g., `my_site_package`) with the following minimal structure:

```
packages/my_site_package/
├── Configuration/
│   └── Sets/
│       └── SitePackage/
├── Resources/
│   ├── Private/
│   └── Public/
└── composer.json
```

* **Configuration/Sets/:** Used for configuration bundles called [Site sets](https://docs.typo3.org/permalink/t3coreapi:site-sets).
* **Resources/:** Stores your HTML templates ([Private](https://docs.typo3.org/permalink/t3coreapi:extension-resources-private)) and assets like CSS or images ([Public](https://docs.typo3.org/permalink/t3coreapi:extension-resources-public)).

## Create the composer.json file

The `composer.json` file is the most critical component. It tells TYPO3 that this directory is a valid extension.

1. Create the file at `packages/my_site_package/composer.json`.
2. Copy the following content into the file:

```json
{
    "name": "my-vendor/my-site-package",
    "description": "Minimal Site Package for TYPO3 v13",
    "type": "typo3-cms-extension",
    "license": ["GPL-2.0-or-later"],
    "require": {
        "typo3/cms-core": "^13.4"
    },
    "autoload": {
        "psr-4": {
            "MyVendor\\MySitePackage\\": "Classes/"
        }
    },
    "extra": {
        "typo3/cms": {
            "extension-key": "my_site_package"
        }
    }
}
```

*Key information:*

* **name:** The Composer [package name](https://docs.typo3.org/permalink/t3coreapi:ext-composer-json-property-name) (lowercase, using hyphens).
* **extension-key:** The [internal TYPO3 extension key](https://docs.typo3.org/permalink/t3coreapi:ext-composer-json-property-extension-key) (using underscores).

3. Save the file.

## Create a Site Set

For TYPO3 to identify your Site Package as a configuration source, you must define a [Site Set](https://docs.typo3.org/permalink/t3coreapi:site-sets).

1. Create a file at `packages/my_site_package/Configuration/Sets/SitePackage/config.yaml`.
2. Add the following content:

```yaml
name: 'my-vendor/my-site-package'
label: 'My Site Package'
dependencies:
    - typo3/fluid-styled-content
```

3. Save the file.

> [!NOTE]
> This set will later be selectable in the TYPO3 Backend under **Site Management > Sites**.

## Summary

You have successfully created the skeletal structure of a TYPO3 Site Package. TYPO3 will now be able to recognize this folder as a valid extension once it is registered via Composer.

## Next steps

Now that the basic structure is ready, you might like to:

* [Register and Install the Site Package via Composer](InstallTheSitePackage.md)
* [Activating the Site Set in the Site Configuration](ActivatingSiteSet.md)

## Resources

* [Generate a site package](https://docs.typo3.org/m/typo3/tutorial-sitepackage/main/en-us/MinimalExample/Index.html)
* [Resources folder](https://docs.typo3.org/permalink/t3coreapi:extension-resources)
* [composer.json in TYPO3](https://docs.typo3.org/permalink/t3coreapi:files-composer-json)
* [Site sets](https://docs.typo3.org/permalink/t3coreapi:site-sets)
