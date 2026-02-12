# Add CSS and JavaScript to a Fluid Template
 **Tested in:** [TYPO3v13](/Tags/TYPO3v13.md) **Categories:** [Beginner](/Tags/Beginner.md) [Templating](/Tags/Templating.md) [Frontend](/Tags/Frontend.md)

Adding assets like CSS and JavaScript directly into your Fluid templates is a straightforward way to style and add interactivity to specific parts of your website. This method is ideal when your styles or scripts are tightly coupled with a particular page layout or template.

This guide will teach you how to link custom CSS and JavaScript files to your site package using Fluid's built-in Asset ViewHelpers.

## Learning objective

In this step-by-step guide, you will learn how to create custom CSS and JavaScript files and include them in your site's Fluid templates using the `f:asset.css` and `f:asset.js` ViewHelpers.

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

## Create Your Asset Files

First, you need to create the CSS and JavaScript files within your site package's directory structure.

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

## Include Assets in Your Fluid Template

Now, you will link these new files in the main Fluid layout file of your site package.

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

## Clear the Cache and Verify

Finally, clear the TYPO3 caches to ensure your changes are loaded, and then check the frontend of your website.

1.  Log in to the TYPO3 backend.
2.  Click the "Clear all caches" lightning bolt icon in the top toolbar.
3.  Open your website in a new browser tab.
    *   You should see the styles from `custom-styles.css` applied to the page (a light gray background and an orange border).
    *   You should see a JavaScript alert box appear with the message "Hello from custom-scripts.js!".

## Summary

Congratulations! You have successfully added custom CSS and JavaScript files to your TYPO3 site using Fluid Asset ViewHelpers. You can now easily manage assets that are specific to your templates.

## Next steps

Now that you know how to include assets in Fluid, you might like to:

*   [Add Global CSS and JavaScript with TypoScript](/20BuildingWebsites/40FrontendDevelopment/40JavaScriptAndCSS/AddGlobalCssAndJavaScriptWithTypoScript.md)
*   Explore using other ViewHelpers in your templates.

## Resources

*   [f:asset.css ViewHelper Reference](https://docs.typo3.org/permalink/t3viewhelper:typo3-fluid-asset-css)
*   [f:asset.js ViewHelper Reference](https://docs.typo3.org/permalink/t3viewhelper:typo3-fluid-asset-script)
