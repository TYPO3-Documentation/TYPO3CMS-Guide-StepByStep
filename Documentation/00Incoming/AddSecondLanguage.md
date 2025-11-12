# Add a second language to your site

<!-- #Intermediary #Frontend #Language #Editing #multilingual @flicstar -->

TYPO3's multilingual support enables you to reach wider audiences by serving content in multiple languages. In this guide, we’ll start with a site in the default language of English, and add Welsh as a second language.

## Learning objective

In this step-by-step guide, you will add Welsh as a second language to your TYPO3 installation and create a translated version of a page. 

## Prerequisites

### Tools and technology

- A working TYPO3 installation
- Access to the TYPO3 backend as an administrator or editor
- A basic site already set up with English content
- At least one published page in your site to translate

### Knowledge and skills

- Familiarity with navigating the TYPO3 backend
- Understanding of pages, content elements, and site configuration

## Watch the video

Watch this video to follow along with the steps below.

[Multilanguage Setup & Localization - TYPO3 Editors Guide](https://www.youtube.com/watch?v=B9TKbc7c7oI)

## Define a new language in TYPO3

To enable Welsh on your TYPO3 site, you'll need to define it as a new language within the Site Management module.

1. In the TYPO3 backend, go to the **Site Management** > **Sites** module.

2. Select your site and click to edit it. The ‘Edit Site Configuration’ screen displays.

3. Go to the **Languages** tab.

4. Click **Create new language**.

5. Enter the language details as show below:

   | Field | Value |
   | :---- | :---- |
   | Title | Welsh |
   | Entry Point | /cy/ |
   | Locale | cy\_GB |
   | Two Letter ISO Code | Welsh |
   | Navigation Title | Cymraeg |
   | Language Tag | cy-GB |
   | Fallback Type | Strict  |

7. Select the Welsh flag icon (GB-wls).

8. Save and close the record.

## Create a Welsh version of a page

With Welsh defined, you can now translate existing pages. First, we need to create the Welsh version of a page.

1. Go to the **Web** > **Pages** module.

2. In the page tree, select the page you want to translate.

3. In the **Create a new translation of this page** list, select Welsh. The Edit Page screen displays.

4. Give the translated page a title in Welsh. 

5. Click the URL segment refresh button to update the URL. It will now include the cy prefix and Welsh title.

6. Save and close the record.

## Translate content into Welsh

Now we can start translating content.

There are two different methods for translating content in TYPO3: “Translate” and “Copy.” In this guide we'll use the “Translate” method, which creates a direct connection between the original language and translation. Find out more about [Translation modes](https://docs.typo3.org/m/typo3/tutorial-editors/13.4/en-us/Languages/Index.html#translation-modes).

1. At the top of the screen, in the **Languages** dropdown, select “All Languages.” The screen updates to display both English and Welsh versions of your page side-by-side.

2. In the Welsh section of the screen, click the **Translate** button. The Localize Page wizard displays.

3. Choose the **Translate** option. This creates placeholder content in Welsh linked to the original (English) content.

4. Click **Next** to step through the wizard. 

5. Click to edit each Welsh content element:  
   1. Enter a headline in Welsh.  
   2. Add translated body text in Welsh.  
   3. (Optional) Update or localize any images.  
   4. Click **Save** and **Close**.

6. Click the enable icon on the translated content element to display it.

7. In the Welsh section of the screen, click the page icon then choose **Enable** to display the Welsh version of the page.

## Summary

Congratulations\! You’ve successfully added Welsh as a second language to your TYPO3 site and translated a page. Your site is now multilingual and ready to serve content in both English and Welsh.

> [!NOTE]
>
> To help visitors navigate your multilingual site, you’ll need to add a [language selection menu](https://docs.typo3.org/m/typo3/guide-frontendlocalization/13.4/en-us/LanguageMenu/Index.html#language-selection-menu). The [Introduction Package](https://extensions.typo3.org/extension/introduction) comes with a text-based rendering of the language menu in the footer.


## Next steps

Now that you have multilingual support, you might like to:

* Add another language.  
* Add a language switcher to your frontend.  
* Set up language-specific SEO and metadata.

## Resources

* [Working with languages](https://docs.typo3.org/m/typo3/tutorial-editors/13.4/en-us/Languages/Index.html)  
* [Frontend Localization Guide](https://docs.typo3.org/m/typo3/guide-frontendlocalization/13.4/en-us/Index.html#start)  
* [Site Handling basics](https://docs.typo3.org/m/typo3/reference-coreapi/13.4/en-us/ApiOverview/SiteHandling/Basics.html#sitehandling-basics)  
* [TYPO3 Explained \- Localization](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/Localization/Index.html)
