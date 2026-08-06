# Add a Dropdown Field to a Page Record

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

Many pages need a value picked from a fixed list of options — a category, a layout variant, a content style. TCA's `select` type with `selectSingle` renders a dropdown in page properties, so editors choose from predefined values instead of typing free text. This avoids typos and ensures consistent values across the site.

## Learning objective

In this step-by-step guide you will add one custom dropdown field to the TYPO3 `pages` record, with four predefined category options, and make it editable in page properties.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* Access to the file system of your TYPO3 project
* A code editor
* A TYPO3 backend account with access to **Admin Tools > Maintenance**

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)
* You have completed [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key.
>
> Replace `tx_my_site_package_category` with your own custom field name. Custom fields on Core tables usually start with the prefix `tx_`.

## Add the database column

First, let's define the new field. The dropdown stores a short string identifier (such as `news` or `event`), so a `varchar` column is appropriate.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. If the file does not exist yet, create it.
3. Add the following SQL definition:

    ```sql
    CREATE TABLE pages (
        tx_my_site_package_category varchar(50) DEFAULT '' NOT NULL
    );
    ```

4. Save the file.

The new field is now part of your extension's database definition.

> [!NOTE]
> If your `ext_tables.sql` already contains a `CREATE TABLE pages (...)` block from a previous guide, you can either add a second block (TYPO3 merges them at install time) or add the new column inside the existing block. Both work.

## Register the field in TCA

Next, register the field in TCA so TYPO3 renders it as a dropdown with four options.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Below the existing TCA columns, add the following code:

    ```php
    ExtensionManagementUtility::addTCAcolumns(
        'pages',
        [
            'tx_my_site_package_category' => [
                'exclude' => true,                          // hide from non-admin users by default
                'label' => 'Category',
                'config' => [
                    'type' => 'select',                     // dropdown / multiselect family
                    'renderType' => 'selectSingle',         // single-choice dropdown
                    'items' => [
                        ['label' => 'News',     'value' => 'news'],
                        ['label' => 'Event',    'value' => 'event'],
                        ['label' => 'Article',  'value' => 'article'],
                        ['label' => 'Tutorial', 'value' => 'tutorial'],
                    ],
                    'default' => 'news',                    // value selected by default
                ],
            ],
        ]
    );
    ```

3. Save the file.

TYPO3 now knows the field definition, but the field is not yet visible in page properties.

> [!TIP]
> Each entry in `items` has a human-readable `label` (what editors see) and a machine `value` (what TYPO3 stores in the database). Use the `value` later when you render the field in the frontend.

## Place the field in page properties

Now we'll add the field to the page form so editors can see and use it.

1. In the same file, below the previous code, add:

    ```php
    ExtensionManagementUtility::addToAllTCAtypes(
        'pages',
        'tx_my_site_package_category',
        '',
        'after:title',
    );
    ```

2. Save the file.

The field is now configured to appear right after the page title field.

## Apply the database change and verify the result

Finally, flush the caches, apply the schema change, and check the new field in the backend.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Open **Admin Tools > Maintenance**.
3. In **Flush TYPO3 and PHP Cache**, click **Flush cache**.
4. In **Analyze Database Structure**, apply the suggested change for `tx_my_site_package_category`.
5. Open the page properties of any page.
6. Verify that the new field **Category** appears below the **Page title** field as a dropdown with four options: News, Event, Article, Tutorial.
7. Pick a value other than the default and save the page.

After saving, reopen the page properties — your selection should still be there.

> [!TIP]
> When you render this field in the frontend, you will get the raw `value` (such as `news`), not the human-readable `label` (`News`). See [Show a Dropdown Selection Label in the Frontend](ShowADropdownSelectionLabelInTheFrontend.md) for how to map values back to labels.

## Summary

Congratulations! You added one custom dropdown field to a TYPO3 page record with four predefined options. Editors can now pick a category from a fixed list, ensuring consistent values across the site.

## Next steps

Now that you have a dropdown field, you might like to:

* [Show a Dropdown Selection Label in the Frontend](ShowADropdownSelectionLabelInTheFrontend.md) to display the selected option's label
* [Add a File Reference Field to a Page Record](AddAFileReferenceFieldToAPageRecord.md)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Select fields in TCA](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Select/Index.html)
* [selectSingle render type](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Select/Selectsingle.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
* [Page properties](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Modules/PageProperties/Index.html)
