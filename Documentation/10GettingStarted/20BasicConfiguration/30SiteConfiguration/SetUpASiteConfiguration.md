# Set Up a Site Configuration

 **Tested in:** [TYPO3v13](/Tags/TYPO3v13.md) **Categories:** [Beginner](/Tags/Beginner.md) [Backend](/Tags/Backend.md) [Configuration](/Tags/Configuration.md)

In TYPO3, a site configuration is essential for defining the domain, root page, and languages for a website.

## Learning objective

This guide explains how to create and configure a new site in a TYPO3 installation.

## Prerequisites

*   A running TYPO3 instance.
*   A "root page" created in the page tree to serve as the starting point of the new website.

## Navigate to the Sites Module

1. Log in to your TYPO3 backend.
2. In the main menu, go to **SITE MANAGEMENT > Sites**.

## Create a New Site Configuration

1. Click the **"Add new site configuration"** button or the `+` icon if you already have other sites.
2. TYPO3 will often suggest creating a site based on an existing root page that is not yet configured.
3. In the *General* tab, add your information to the following fields:
    *   **Site Identifier:** A unique, lowercase name for the site (e.g., `my_website`). This is used internally by TYPO3.
    *   **Root Page ID:** This is the most important setting. Select the page from your page tree that will be the root of your website (e.g., your "Home" page).
    *   **Base URL:** The primary domain for the site, including the protocol (e.g., `https://www.example.com/`).
4. In the Languages tab, click *Create new Language*. A new language form will appear.
5. Fill in the following fields with your information:
    *   **Title:** The human-readable name of the language (e.g., "English").
    *   **Entry Point:** The URL segment for this language. The default language should use `/`. Additional languages might use a prefix (e.g., `/de/`).
    *   **Locale:** The locale for the language, which is important for date formatting and other localizations (e.g., `en_US.UTF-8`).
6. In the **Error Handling** tab, fill in the following fields with your information:
    *   Switch to the **Error Handling** tab.
    *   Define how TYPO3 should handle HTTP error status codes, such as `404 Not Found`.
    *   You can set a specific page to display, redirect to another URL, or use a custom Fluid template for each error code.
7. Click the **Save** button to store your new site configuration.

## Summary

You have successfully created a site configuration. Your website is now accessible through the configured domain, and TYPO3 knows which page tree belongs to it.

## Next Steps

*   **Add More Languages:** If your site is multilingual, you can add more languages in the *Languages* tab by repeating steps 4–5 above.
*   **Domain Variants:** Create variants for different domains or subdomains that point to the same site but might have slightly different settings.
*   **Static Routes:** For advanced URL routing, you can explore the *Static Routes* tab.
