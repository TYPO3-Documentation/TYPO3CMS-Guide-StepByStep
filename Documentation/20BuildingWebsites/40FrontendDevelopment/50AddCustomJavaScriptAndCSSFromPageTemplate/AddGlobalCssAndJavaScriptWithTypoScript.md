# Add Global CSS and JavaScript with TypoScript
<!-- #TYPO3v13 #Beginner #Templating #Configuration -->

Managing your website's core CSS and JavaScript files globally is an efficient way to ensure a consistent look and feel across all pages. TYPO3's TypoScript provides a powerful, centralized method for including these assets sitewide.

This guide will teach you how to link custom CSS and JavaScript files to your site package using TypoScript page configuration.

## Learning objective

In this step-by-step guide, you will learn how to create custom CSS and JavaScript files and include them globally on your site using the `page.includeCSS` and `page.includeJS` TypoScript properties.

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

## Create Your Asset Files

First, you need to create the CSS and JavaScript files within your site package's directory structure.

1.  Navigate to your site package's `Resources/Public/` directory.
2.  Create two new sub-directories: `Css` and `JavaScript`.
3.  Inside the `Css` directory, create a new file named `custom-styles.css`. Add a simple CSS rule for testing:

    ```css
    body {
      background-color: #f0f0f0;
      border: 5px solid #20c997;
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

## Include Assets Using TypoScript

This method is best for assets that should be loaded on every page of your site.

1.  Open your site package's main TypoScript setup file. This is typically located at `your_sitepackage/Configuration/TypoScript/setup.typoscript`.
2.  Add the `page.includeCSS` and `page.includeJS` properties to your page object configuration. You can assign a key (like `style` or `js`) and set the value to the path of your asset file using the `EXT:` syntax.

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
    Make sure to replace `your_sitepackage` with the actual key of your site package extension.

## Clear the Cache and Verify

Finally, clear the TYPO3 caches to ensure your changes are loaded, and then check the frontend of your website.

1.  Log in to the TYPO3 backend.
2.  Click the "Clear all caches" lightning bolt icon in the top toolbar.
3.  Open your website in a new browser tab.
    *   You should see the styles from `custom-styles.css` applied to the page (a light gray background and a green border).
    *   You should see a JavaScript alert box appear with the message "Hello from custom-scripts.js!".

## Summary

Congratulations! You have successfully added global CSS and JavaScript files to your TYPO3 site using TypoScript. This centralized approach is excellent for managing your site's core assets.

## Next steps

Now that you have experience with including assets globally, you might like to:

*   Learn how to conditionally load assets on specific pages using TypoScript conditions.
*   Explore how to configure and bundle assets for better performance.

## Resources

*   [TypoScript Reference: includeCSS](https://docs.typo3.org/permalink/t3tsref:confval-page-includecss)
*   [TypoScript Reference: includeJS](https://docs.typo3.org/permalink/t3tsref:confval-page-includejs)
