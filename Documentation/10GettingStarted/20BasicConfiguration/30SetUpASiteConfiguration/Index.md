# Set Up a Site Configuration

This guide explains how to create and configure a new site in a TYPO3 installation. A site configuration is essential for defining the domain, root page, and languages for a website.

### **Prerequisites**

*   A running TYPO3 instance.
*   A "root page" created in the page tree to serve as the starting point of the new website.

### **Step-by-Step Guide**

1.  **Navigate to the Sites Module:**
    *   Log in to your TYPO3 backend.
    *   In the main menu, go to **SITE MANAGEMENT > Sites**.

2.  **Create a New Site Configuration:**
    *   Click the **"Add new site configuration"** button or the `+` icon if you already have other sites.
    *   TYPO3 will often suggest creating a site based on an existing root page that is not yet configured.

3.  **Configure the General Tab:**
    *   **Site Identifier:** A unique, lowercase name for the site (e.g., `my_website`). This is used internally by TYPO3.
    *   **Root Page ID:** This is the most important setting. Select the page from your page tree that will be the root of your website (e.g., your "Home" page).
    *   **Base URL:** The primary domain for the site, including the protocol (e.g., `https://www.example.com/`).

4.  **Configure Languages:**
    *   Switch to the **Languages** tab.
    *   Click **Create new Language**.
    *   **Title:** The human-readable name of the language (e.g., "English").
    *   **Entry Point:** The URL segment for this language. The default language should use `/`. Additional languages might use a prefix (e.g., `/de/`).
    *   **Locale:** The locale for the language, which is important for date formatting and other localizations (e.g., `en_US.UTF-8`).

5.  **Configure Error Handling (Optional but Recommended):**
    *   Switch to the **Error Handling** tab.
    *   Define how TYPO3 should handle HTTP error status codes, such as `404 Not Found`.
    *   You can set a specific page to display, redirect to another URL, or use a custom Fluid template for each error code.

6.  **Save the Configuration:**
    *   Click the **Save** button to store your new site configuration.

### **Summary**

You have successfully created a site configuration. Your website is now accessible through the configured domain, and TYPO3 knows which page tree belongs to it.

### **Next Steps**

*   **Add More Languages:** If your site is multilingual, you can add more languages in the **Languages** tab.
*   **Domain Variants:** Create variants for different domains or subdomains that point to the same site but might have slightly different settings.
*   **Static Routes:** For advanced URL routing, you can explore the **Static Routes** tab.
