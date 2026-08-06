# Add a Custom Field to a Content Element

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage #ContentElements @dragos_tuluc -->

Pages aren't the only TYPO3 records that benefit from custom fields. Content elements (the blocks that make up a page's body — text, images, lists) live in the `tt_content` table, and they take TCA the same way `pages` does. Adding a custom field to `tt_content` lets editors annotate individual content blocks: a custom subtitle, a CSS class hint, an internal note. The configuration pattern is identical to extending `pages` — only the table name changes.

## Learning objective

In this step-by-step guide you will add one custom subtitle field to the TYPO3 `tt_content` record and make it editable on every content element.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* At least one content element on a page (any type — Text, Text & Images, etc.)
* Access to the file system of your TYPO3 project
* A code editor
* A TYPO3 backend account with access to **Admin Tools > Maintenance**

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You have completed [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md) — the pattern is the same, only the table changes
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key.
>
> Replace `tx_my_site_package_subtitle` with your own custom field name. Custom fields on Core tables usually start with the prefix `tx_`.

## Add the database column

First, let's define the new field on the `tt_content` table.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. If the file does not exist yet, create it.
3. Add the following SQL definition (alongside any existing `CREATE TABLE pages` block):

    ```sql
    CREATE TABLE tt_content (
        tx_my_site_package_subtitle varchar(255) DEFAULT '' NOT NULL
    );
    ```

4. Save the file.

The new field is now part of your extension's database definition for content elements.

> [!NOTE]
> If your `ext_tables.sql` already contains a `CREATE TABLE tt_content (...)` block from another guide, you can either add a second block (TYPO3 merges them at install time) or add the new column inside the existing block. Both work.

## Register the field in TCA

TCA overrides for `tt_content` go in their own override file, separate from `pages.php`.

1. Create the file `packages/my_site_package/Configuration/TCA/Overrides/tt_content.php`.
2. Add the following code:

    ```php
    <?php

    declare(strict_types=1);

    defined('TYPO3') or die();

    use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

    ExtensionManagementUtility::addTCAcolumns(
        'tt_content',
        [
            'tx_my_site_package_subtitle' => [
                'exclude' => true,                  // hide from non-admin users by default
                'label' => 'Custom subtitle',
                'config' => [
                    'type' => 'input',
                    'size' => 50,
                    'max' => 255,
                    'eval' => 'trim',
                ],
            ],
        ]
    );

    ExtensionManagementUtility::addToAllTCAtypes(
        'tt_content',
        'tx_my_site_package_subtitle',
        '',
        'after:header',
    );
    ```

3. Save the file.

> [!TIP]
> The TCA configuration syntax is identical for every table. The only differences from the `pages.php` override are the file name (`tt_content.php`), the table name in the function calls (`tt_content`), and the position reference (`after:header` makes more sense for content elements than `after:title`).

## Apply the database change and verify the result

Finally, flush the caches, apply the schema change, and check the new field in the backend.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Open **Admin Tools > Maintenance**.
3. In **Flush TYPO3 and PHP Cache**, click **Flush cache**.
4. In **Analyze Database Structure**, apply the suggested change for `tx_my_site_package_subtitle`.
5. Open any page that has at least one content element.
6. Click the content element to edit it.
7. Verify that the new field **Custom subtitle** appears below the **Header** field on the **General** tab.
8. Enter a value and save.

After saving, reopen the content element — the value should still be there.

> [!TIP]
> Custom fields appear on every content element type by default (text, image, list, plugin, etc.) because of `addToAllTCAtypes`. To restrict the field to specific types, use `addToAllTCAtypes` with the fourth parameter set to a comma-separated list of `CType` values, or modify only the `types` array of the relevant content element types.

## Summary

Congratulations! You added one custom field to a TYPO3 content element. The same TCA pattern that works for pages also works for content elements, backend users, and any other table — only the table name and override file change.

## Next steps

Now that you can extend content elements, you might like to:

* [Add a Custom Field to Backend Users](AddACustomFieldToBackendUsers.md)
* [Make a Field Required in TCA](MakeAFieldRequiredInTca.md)
* [Group Fields into a Tab in Page Properties](GroupFieldsIntoATabInPageProperties.md) — same `--div--` pattern works for any table

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Customizing tt_content](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
* [tt_content table reference](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Examples/TtContent.html)
* [ext_tables.sql](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/FileStructure/ExtTablesSql.html)
