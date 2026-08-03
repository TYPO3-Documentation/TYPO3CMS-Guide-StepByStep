# Create a new language in TYPO3

<!-- #TYPO3v14 #Beginner #Backend #Configuration #Localization @dhubert974 -->

TYPO3 provides built-in multilingual capabilities that allow you to manage websites in multiple languages from a single installation. Adding a new language enables editors to translate pages and content while giving visitors access to localized versions of the website.

Creating a new language in TYPO3 helps you expand your website for international audiences and organize translated content efficiently.

## Learning objective

In this step-by-step guide you will learn how to:

* Add a new language to a TYPO3 site configuration
* Configure localization settings

## Prerequisites

### Tools and technology

* TYPO3 v14 installation
* Administrator access to the TYPO3 backend

### Knowledge and skills

* Basic understanding of TYPO3 backend modules
* Familiarity with TYPO3 page and content management
* Basic knowledge of TYPO3 Site Management

## Add a new language to the site configuration

This section focuses on configuring the language in TYPO3 Site Management. Without this configuration, TYPO3 cannot generate localized frontend pages.

TYPO3 manages frontend languages through the Site Configuration module.

1. Open the TYPO3 backend.
2. Navigate to Site Management > Sites.
3. Select the site you want to configure.
4. Open the Languages tab.
5. Click Add language.
6. Configure the language settings:
   * Enabled: Activate the language
   * Language ID: Enter a unique ID such as `1`
   * Title: Enter the language name, for example `French`
   * Navigation Title: Optional shorter title
   * Base: Define the language path, for example `/fr/`
   * Locale: Enter the locale, for example `fr_FR.UTF-8`
   * Flag: Select a flag icon
   * Fallback type: Choose the fallback behavior
7. Save the configuration.

Expected outcome:

* TYPO3 now recognizes the new language.
* Frontend URLs can be generated for the language.

Example configuration generated in `config/sites/<site>/config.yaml`:

```yaml
languages:
 - title: French
   enabled: true
   languageId: 1
   base: /fr/
   locale: fr_FR.UTF-8
   navigationTitle: FR
   flag: fr
```

## Translate pages

After adding the language, you can create translated versions of pages.

1. Navigate to the Page module.
2. Select a page from the page tree.
3. Use the language selector in the top toolbar.
4. Select the newly created language.
5. Click Translate for the page.
6. Choose Create new translation.
7. Save the translated page properties.

Expected outcome:

* The page now exists in multiple languages.
* TYPO3 displays language overlays in the backend.

## Summary

Congratulations! You now have a multilingual TYPO3 v14 website with a newly configured language, translated pages, and frontend language switching.

## Next steps

Now that you have configured a new language, you might like to:

* [Translate a page in TYPO3](TranslateAPageInTypo3.md)
* [Translate existing content](TranslateExistingContent.md)
* [Manage language fallbacks](ManageLanguageFallbacks.md)

## Resources

* [TYPO3 Localization Documentation](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/Localization/Index.html)
* [TYPO3 Site Handling Documentation](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/SiteHandling/Index.html)
* [TYPO3 v14 Documentation](https://docs.typo3.org)
