# Create a Site Set with Editable Settings and Custom CSS

<!-- #TYPO3v13 #Beginner #Backend #Configuration @csabareanu -->

TYPO3's Site Sets are reusable packages of site configuration that streamline multi-site management. It replaces older methods and allows you to bundle and apply settings across multiple sites or projects.

## Learning objective

In this guide, you will build a practical, working site set named `my-vendor/base` inside your site package (`EXT:sitepackage`). The site set will:

* Add a default meta description and site contact info (editable in backend)
* Add a simple backend configuration
* Render them in a simple Fluid template
* Load a custom CSS file to style the title

## Prerequisites

### Tools and technology

* A computer with a local TYPO3 installation and a site package extension as described in [Create a Site Package](CreateASitePackage.md).
* An IDE or plain text editor.

### Knowledge and skills

* {Conceptual knowledge}
* {Prior learning}

## Create the Site Set folder and manifest

Every site set is defined inside a manifest that defines its name and dependencies.

1. Inside your extension, create a folder called `base` inside of your extension's site sets folder: `EXT:sitepackage/Configuration/Sets`
2. Inside the `base` folder, create a plain text file called `config.yaml`.
3. Copy the following YAML into the `config.yaml` file:

    ``` yaml
    name: 'my-vendor/base'
    label: 'Base Site Set'
    dependencies: []
    optionalDependencies: []
    hidden: false
    ```

    > [!TIP]
    > The meaning of the configuration properties is explained in the [Site Set Definition](https://docs.typo3.org/permalink/t3coreapi:site-sets-definition) section of the TYPO3 documentation.

4. Save the file.

## Add editable site settings

We will now define custom site settings. These can be edited and customized for each site in the *Sites* module in the TYPO3 backend.

1. Inside the `base` folder, create a file called `settings.yaml`. This file will contain the custom setting properties.
2. Copy the following YAML into the `settings.yaml` file:

    ``` yaml
    settings:
      site:
        meta:
          description: 'Default meta description from settings.yaml'
        contact:
          email: 'contact@example.com'
    ```

    > [!TIP]
    > Read more about [Custom Site Settings](https://docs.typo3.org/permalink/t3coreapi:sitehandling-settings) in the TYPO3 documentation.

3. Save the file.
4. Inside the `base` folder, create another file, this time called `settings.definitions.yaml`. This file defines how the custom settings in the `settings.yaml` file should be displayed in the backend.
5. Copy the following YAML into the `settings.definitions.yaml` file:

    ``` yaml
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

    > [!TIP]
    > Read more about [Site Settings Definitions](https://docs.typo3.org/permalink/t3coreapi:site-settings-definition) in the TYPO3 documentation.

6. Save the file.

## Add TypoScript for page rendering

Site sets can also contain TypoScript configurations. In this case we will define page rendering and include a CSS file.

1. Inside the `base` folder, create a file called `setup.typoscript`.
2. Copy the following TypoScript into the `setup.typoscript` file:

    ``` TypoScript
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

3. Save the file.

> [!TIP]
> Read more about [TypoScript](https://docs.typo3.org/permalink/t3coreapi:typoscript) in the TYPO3 documentation.

## Add backend configuration

Site sets can also reconfigure the TYPO3 backend. In this case we will change the header of the *Common* section of the [New Content Element Wizard](https://docs.typo3.org/permalink/t3coreapi:content-element-wizard) by modifying the [Page TSConfig configuration options](https://docs.typo3.org/permalink/t3tsref:pagetoplevelobjects).

1. Inside the `base` folder, create a file called `page.tsconfig`.
2. Copy the following TypoScript into the `page.tsconfig` file:

``` TypoScript
mod.wizards.newContentElement.wizardItems.common.header = Common Elements (Site Set active)
```

3. Save the file.

## Add a CSS file

Site sets can also include frontend resources, like images and CSS files. Previously, we defined TypoScript that included a CSS file. Now we will create this file inside the site package's *Resources* folder.

1. Inside your site package extension, create these three folders inside each other: `Resources/Public/Css`. (Don't worry if the folders already exist.)
2. Inside the `Css` folder, create a plain text file called `base.css`.
3. Copy the following CSS into the `base.css` file:

``` css
/* Base Site Set Styles */
h1 {
  color: darkred;
  font-weight: 700;
}
```

4. Save the file.

## Create a simple Fluid template to test the settings

Site sets can also include Fluid templates. In this case we will create a simple template that displays the custom site settings we have defined. This is thanks to the `SiteProcessor` we defined in our TypoScript. It allows us to access the settings at `site.settings` in the fluid template.

1. Inside the site package extension, create the folders `Resources/Private/Templates/Default` inside each other. (Don't worry if the folders already exist.)
2. Inside the `Default` folder, create an HTML file called `Default.html`.
3. Copy the following HTML into the `Default.html` file:

```
<html xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers">
<body>
  <h1>Site Settings Test</h1>

  <p><strong>Meta Description:</strong> {site.settings.site.meta.description}</p>
  <p><strong>Contact Email:</strong> {site.settings.site.contact.email}</p>

</body>
</html>
```

4. Save the file.

> [!TIP]
> Read more about [Fluid](https://docs.typo3.org/permalink/t3coreapi:fluid) and the [SiteProcessor](https://docs.typo3.org/permalink/t3tsref:siteprocessor) in the TYPO3 documentation.

## Register the Site Set in your site configuration

1. Open your site configuration file. It is located in `config/sites/<your-site>/config.yaml`, where `<your-site>` is your site’s identifier.
2. Add the following line to the `dependencies` section:

    ``` yaml
    dependencies:
      - my-vendor/base
    ```

3. Save the file.

## Clear caches and verify

1. Clear caches as described in [Clearing the Frontend Cache in the TYPO3 Backend](ClearingFrontendCacheInTypo3Backend.md).
2. Open **Backend → Site → Settings** module. You’ll see your *Base Settings: Meta Description* and *Contact Email* fields.
3. Change the value of the fields.
4. Save the settings.
5. Visit your site’s frontend. You should see.

    ```
    Site Settings Test
    Meta Description: (your value from step 3)
    Contact Email: (your value from step 3)
    ```

6. Confirm that the H1 title appears in *dark red*. This confirms that the CSS file is loaded.
7. Go back to the TYPO3 backend.
8. Create a new content element to bring up the New Content Element Wizard. Check the wizard’s Common section and confirm that the title has changed to "Common Elements (Site Set active)." This confirms that the Page TSConfig configuration is loaded.

![A screenshot of TYPO3’s New Content Element Wizard with the Common Elements (Site Set active) section selected. Content element icons are visible: Header Only, Regular Text Element, Text & Images, Images Only, and Text & Media, each with icons and brief descriptions.](Images/implementSiteSets/NewContentElementWizardChangedSectionTitle.png)

## Summary

You now have a complete Site Set that provides:

* Editable custom site settings (in **Backend → Sites → Settings**)
* Custom TypoScript that loads a custom Fluid template and CSS file.
* A working Fluid template that displays site settings.
* Automatically included CSS styling.

This Site Set can now be reused across any project — just add `- my-vendor/base` to the `dependencies:` section of another site’s `config.yaml`.

Next steps

Now that you have created your site set, you might like to:

* Explore the [Site Set Reference](https://docs.typo3.org/permalink/t3coreapi:site-sets) to learn more about all the available options.
* [Include CSS through the Fluid Template](AddCSSAndJavaScriptToAFluidTemplate.md) instead of through TypoScript.

## Resources

* [Site Sets Reference](https://docs.typo3.org/permalink/t3coreapi:site-sets)
* [Custom Site Settings](https://docs.typo3.org/permalink/t3coreapi:sitehandling-settings)
* [Site Settings Definitions](https://docs.typo3.org/permalink/t3coreapi:site-settings-definition)
* [TypoScript](https://docs.typo3.org/permalink/t3coreapi:typoscript)
* [Fluid](https://docs.typo3.org/permalink/t3coreapi:fluid)
* [SiteProcessor](https://docs.typo3.org/permalink/t3tsref:siteprocessor)
