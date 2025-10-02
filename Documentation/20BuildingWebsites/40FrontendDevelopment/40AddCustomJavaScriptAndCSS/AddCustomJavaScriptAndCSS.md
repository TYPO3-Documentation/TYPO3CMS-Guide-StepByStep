# Add Custom CSS and JavaScript to Your TYPO3 Site
<!-- #TYPO3v13 #Beginner #Templating #Frontend -->

Customizing your website's appearance and behavior is a fundamental part of web development. TYPO3 offers several powerful and flexible methods for adding CSS and JavaScript assets to your frontend. You can include them directly in your Fluid templates for simplicity or manage them globally using TypoScript for more control.

This guide will teach you how to link custom CSS and JavaScript files to your site package using both Fluid templates and TypoScript, giving you the foundation to style and add interactivity to your pages.

## Learning objective

In this step-by-step guide, you will learn how to:
*   Create custom CSS and JavaScript files within your site package.
*   Include these assets using Fluid ViewHelpers in your templates.
*   Include these assets globally using TypoScript.

## Prerequisites

### Tools and technology

*   A local TYPO3 installation (v11 or newer).
*   A site package extension created for your theme.
*   Access to the file system of your TYPO3 installation.
*   A code editor.

### Knowledge and skills

*   Basic understanding of the TYPO3 backend.
*   Familiarity with the structure of a site package.
*   Basic knowledge of CSS, JavaScript, and HTML.
*   Awareness of what TypoScript is and its role in TYPO3.

## Task 1: Create Your CSS and JavaScript Files

First, you need to create the asset files within your site package's directory structure.

1.  Navigate to your site package's `Resources/Public/` directory.
2.  Create two new sub-directories: `Css` and `JavaScript`.
3.  Inside the `Css` directory, create a new file named `custom-styles.css`. Add a simple CSS rule for testing:

    ```css
    body {
      background-color: #f0f0f0;
      border: 5px solid #ff8700;
    }
    ```
4.  Inside the `JavaScript` directory, create a new file named `custom-scripts.js`. Add a simple JavaScript alert for testing:
    ```javascript
    alert('Hello from custom-scripts.js!');
    ```

    Your file structure should now look like this:

    ```text
    └── your_sitepackage/
        └── Resources/
            └── Public/
                ├── Css/
                │   └── custom-styles.css
                ├── JavaScript/
                │   └── custom-scripts.js
                └── ...
    ```

## Task 2: Include Assets Using Fluid Templates

This method is ideal for assets that are specific to a particular layout or template.

1.  Open the main HTML template file for your site's layout. This is commonly located at `your_sitepackage/Resources/Private/Layouts/Page/Default.html`.
2.  Add the `<f:asset.css>` and `<f:asset.js>` ViewHelpers inside the `<head>` section of the file. These ViewHelpers tell TYPO3 to add the respective files to the page.

    Update the code to include the new assets as shown below. The `identifier` is a unique name, and `href` points to the file location using the `EXT:` syntax.

    ```html
    <head>
        ...
        <f:asset.css identifier="my-custom-styles" href="EXT:your_sitepackage/Resources/Public/Css/custom-styles.css" />
        <f:asset.js identifier="my-custom-scripts" href="EXT:your_sitepackage/Resources/Public/JavaScript/custom-scripts.js" />
        ...
    </head>
    ```
    Make sure to replace `your_sitepackage` with the actual key of your site package extension.

## Task 3: Include Assets Using TypoScript

This method is best for assets that should be loaded on every page of your site, as it is managed globally.

1.  Open your site package's main TypoScript setup file. This is typically located at `your_sitepackage/Configuration/TypoScript/setup.typoscript`.
2.  Add the `page.includeCSS` and `page.includeJS` properties to your page object configuration. You can assign a key and set the value to the path of your asset file.

    ```typoscript
    page {
        # ... other page configuration

        includeCSS {
            style = EXT:your_sitepackage/Resources/Public/Css/custom-styles.css
        }

        includeJS {
            js = EXT:your_sitepackage/Resources/Public/JavaScript/custom-scripts.js
        }
    }
    ```

    > **Scope check time**
    >
    > For this guide, choose **either** the Fluid method (Task 2) **or** the TypoScript method (Task 3). Using both will include the files twice. If you tested the Fluid method, remove the `<f:asset...>` tags before proceeding with the TypoScript method.

## Task 4: Clear the Cache and Verify

Finally, clear the TYPO3 caches to ensure your changes are loaded, and then check the frontend of your website.

1.  Log in to the TYPO3 backend.
2.  Click the "Clear all caches" lightning bolt icon in the top toolbar.
3.  Open your website in a new browser tab.
    *   You should see the styles from `custom-styles.css` applied to the page (a light gray background and an orange border).
    *   You should see a JavaScript alert box appear with the message "Hello from custom-scripts.js!".

## Summary

Congratulations! You have successfully added custom CSS and JavaScript files to your TYPO3 site using both Fluid templates and TypoScript. You now have the flexibility to manage your frontend assets in a way that best suits your project's needs.

## Next steps

Now that you have experience including assets, you can continue to add more advanced functionality to your site:

*   Learn how to conditionally load assets on specific pages.
*   Explore using CSS pre-processors like SASS/SCSS with TYPO3.

## Resources

*   [f:asset.css ViewHelper Reference](https://docs.typo3.org/permalink/t3viewhelper:typo3-fluid-asset-css)
*   [f:asset.js ViewHelper Reference](https://docs.typo3.org/permalink/t3viewhelper:typo3-fluid-asset-script)
*   [TypoScript Reference: includeCSS](https://docs.typo3.org/permalink/t3tsref:confval-page-includecss)
*   [TypoScript Reference: includeJS](https://docs.typo3.org/permalink/t3tsref:confval-page-includejs)
