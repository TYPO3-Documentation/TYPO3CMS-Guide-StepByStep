# Add a Custom Doktype

<!-- #TYPO3v13 #Intermediary #Backend #Configuration #SitePackage @dragos_tuluc -->

Every TYPO3 page has a *doktype* — a numeric identifier for what *kind* of page it is. Standard pages (doktype 1), shortcuts (4), folders (254), external links (3), and a handful more come with TYPO3 Core. When your site needs a kind of page that isn't on the Core list — a "News Article", an "Event", a "Product Detail" — you register a custom doktype. Editors then see a new option in the page-tree creation menu, with its own icon, its own form fields, and its own backend layout, semantically separate from generic pages.

## Learning objective

In this step-by-step guide you will register a new doktype `130` for "News Article" pages, give it a custom icon and a tailored set of fields in page properties, and verify it appears in the page-tree creation menu.

## Why and when to use a custom doktype

**Use a custom doktype when:**

* Different page kinds need *different fields*. A news article needs a publish date and an author; an event needs a start and end date and a location. Forcing one kind of page to display unrelated fields confuses editors and clutters the form.
* Different page kinds need *different rendering*. With FLUIDTEMPLATE or PAGEVIEW, the page-rendering selects a template based on the page's backend layout — and doktypes pair naturally with backend layouts.
* You want the page-tree icon to *look different* for instant visual identification (a news icon for articles, a calendar icon for events).
* You want certain page kinds to be *excluded from menus or sitemaps by default*. The doktype is the natural switch.

**Avoid a custom doktype when:**

* You only need a *different visual layout* for the same data — use [Backend Layouts](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/BackendLayout/Index.html) instead. They control the layout without changing the page's identity.
* You want to add *one custom field* to all pages — just extend `pages` (see [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md)). A doktype is overkill for a single field.
* You're modeling *content blocks* on a page — those are content elements (`tt_content`), not new doktypes.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* At least one custom field on the `pages` table, such as those from [Add a Date Field to a Page Record](AddADateFieldToAPageRecord.md) and [Add a Textarea Field to a Page Record](AddATextareaFieldToAPageRecord.md)
* A code editor

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)
* Basic understanding of TCA `types[]` arrays (helpful, not required)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and `130` with your own doktype number. Custom doktypes should use values 100 and above to avoid conflicts with TYPO3 Core (which uses 1–254 sparsely).

## Define the doktype constant

Adding a doktype is purely a TCA change — no SQL is needed because the `doktype` column already exists on the `pages` table.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Below any existing TCA changes, add the doktype registration:

    ```php
    use TYPO3\CMS\Core\Imaging\IconProvider\SvgIconProvider;
    use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

    // Register the doktype constant (the value `130` becomes available wherever
    // the `doktype` column appears in the backend).
    ExtensionManagementUtility::addTcaSelectItem(
        'pages',
        'doktype',
        [
            'label' => 'News Article',
            'value' => 130,
            'icon' => 'pages-news-article',                // referenced below
            'group' => 'default',                          // grouping in the page-tree creation menu
        ],
        '1',                                               // place after doktype 1 (Standard)
        'after',
    );

    // Tell TYPO3 which icon to use for this doktype in the page tree.
    $GLOBALS['TCA']['pages']['ctrl']['typeicon_classes']['130'] = 'pages-news-article';
    ```

3. Save the file.

The doktype is now registered, but TYPO3 doesn't yet know which fields to show on its page properties form.

## Configure which fields appear on the new doktype

Each doktype has a `types[]` entry in TCA that lists the fields shown on its form. By default a custom doktype inherits the standard `types['1']` configuration — but customizing it is the whole point.

1. In the same file, below the previous code, add:

    ```php
    $GLOBALS['TCA']['pages']['types']['130'] = [
        'showitem' => '
            --div--;General,
                title, slug, hidden,
                tx_my_site_package_publish_date,
                tx_my_site_package_summary,
            --div--;Access,
                --palette--;;access,
            --div--;Categories,
                categories
        ',
    ];
    ```

2. Save the file.

This `showitem` definition tells TYPO3: "When editing a News Article page, show the title, slug, hidden flag, publish date, and summary on the General tab; the standard access controls on the Access tab; and the categories field on the Categories tab." Anything *not* listed is omitted from the form, even if it exists on the `pages` table — keeping the form focused on what's relevant for news articles.

> [!TIP]
> The `--div--;Label` token starts a new tab. The `--palette--;;palette_name` token references a TCA palette. The standard palette `access` (defined by Core) groups the publication-window fields nicely.

## Register the icon

The `'icon' => 'pages-news-article'` reference needs an actual icon file. Register it with TYPO3's icon registry.

1. Place an SVG icon at `packages/my_site_package/Resources/Public/Icons/pages-news-article.svg` (or use an existing TYPO3 Core icon — see the tip below).
2. Create or open the file `packages/my_site_package/Configuration/Icons.php`.
3. Set the file content to:

    ```php
    <?php

    use TYPO3\CMS\Core\Imaging\IconProvider\SvgIconProvider;

    return [
        'pages-news-article' => [
            'provider' => SvgIconProvider::class,
            'source' => 'EXT:my_site_package/Resources/Public/Icons/pages-news-article.svg',
        ],
    ];
    ```

4. Save the file.

TYPO3 v13 auto-discovers `Configuration/Icons.php` — no further wiring is needed.

> [!TIP]
> If you don't have an SVG handy, reuse an existing TYPO3 Core icon by referencing its identifier instead. For example, change `'icon' => 'pages-news-article'` in the `addTcaSelectItem` call to `'icon' => 'mimetypes-x-content-news'` (a built-in icon) and skip the `Icons.php` registration entirely. The full icon catalog is at the [TYPO3 Backend Icons](https://typo3.github.io/typo3-icons/) reference.

## Verify the new doktype in the backend

Finally, flush caches and confirm the doktype is selectable.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Open the **Page** module from the left menu.
4. Right-click any existing page in the page tree and choose **New > Page**.
5. Look for **News Article** in the list of page types — it should appear right after **Standard**.
6. Pick **News Article** and create a page.
7. Open the new page's page properties.

The form should show only the fields you listed in the `types['130']` showitem — title, slug, hidden, publish date, summary, access controls, categories — and nothing else.

> [!TIP]
> If the **News Article** option doesn't show up:
>
> * Confirm `addTcaSelectItem` ran successfully (no PHP errors in the TYPO3 log).
> * Confirm you cleared all caches and reloaded the backend page.
> * Check that the user has permission to create pages of this doktype — admins always do; for non-admins, add the doktype to the backend group's **Page types** allow-list (in the group's Access Lists), and optionally add it to the page tree's drag-area with the User TSConfig `options.pageTree.doktypesToShowInNewPageDragArea := addToList(130)`.

## Summary

Congratulations! You registered a custom doktype `130`, gave it a tailored field layout, and put a custom icon on it. Editors now see a clearly distinct **News Article** option in the page tree, with a focused form that only shows the fields relevant to news articles.

## Next steps

Now that you have a custom doktype, you might like to:

* Add a custom backend layout that is selected automatically when this doktype is used (covered in a future guide)
* [Override a Default TCA Field](OverrideADefaultTcaField.md) to add a default value for fields on this doktype
* [Group Fields into a Palette in Page Properties](GroupFieldsIntoAPaletteInPageProperties.md) to refine the form layout

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Pages table reference](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Examples/Pages.html)
* [Adding doktypes](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/AddNewDoktype/Index.html)
* [TYPO3 Backend icons reference](https://typo3.github.io/typo3-icons/)
* [Backend layouts](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/PageTsconfig/Mod/SHARED.html)
