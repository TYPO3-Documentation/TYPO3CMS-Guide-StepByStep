# Add a Category Field with sys_category

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

TYPO3 ships with `sys_category` — a built-in taxonomy table that lets editors define a hierarchical tree of categories and assign them to records. Categories are perfect for cross-cutting classifications (topics, tags, audiences) that apply to many record types. Adding a `type: category` field to a page lets editors pick from this central taxonomy instead of typing free text or maintaining a parallel list.

## Learning objective

In this step-by-step guide you will add one custom many-to-many category field to the TYPO3 `pages` record, allowing editors to tag pages with topics from `sys_category`.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* A code editor

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You have completed [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md)
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key.
>
> Replace `tx_my_site_package_topics` with your own custom field name.

## Add the database column

First, let's define the new field. The `type: category` field stores the count of related categories in an integer column on the page record; the actual relations live in `sys_category_record_mm`, which TYPO3 manages automatically.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. Add the following SQL definition (alongside any existing `CREATE TABLE pages` block):

    ```sql
    CREATE TABLE pages (
        tx_my_site_package_topics int(11) DEFAULT '0' NOT NULL
    );
    ```

3. Save the file.

The new field is now part of your extension's database definition.

## Register the field in TCA

Next, register the field as a category picker in the backend form.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Below the existing TCA columns, add the following code:

    ```php
    ExtensionManagementUtility::addTCAcolumns(
        'pages',
        [
            'tx_my_site_package_topics' => [
                'exclude' => true,                          // hide from non-admin users by default
                'label' => 'Topics',
                'config' => [
                    'type' => 'category',                   // dedicated category field type
                    'relationship' => 'manyToMany',         // a page can have many topics, a topic many pages
                    'maxitems' => 5,                        // max five topics per page
                ],
            ],
        ]
    );
    ```

3. Save the file.

> [!TIP]
> The `relationship` option supports three values:
>
> * `manyToMany` — multiple categories per record, multiple records per category (most common)
> * `oneToMany` — multiple categories per record, stored as a comma-separated list of category UIDs directly in the record's column
> * `oneToOne` — exactly one category per record (TYPO3 enforces `maxitems = 1` automatically)
>
> Only `manyToMany` uses the `sys_category_record_mm` table. The other two store the category UID(s) directly in the record's column.

## Place the field in page properties

Now we'll add the field to the page form so editors can see and use it.

1. In the same file, below the previous code, add:

    ```php
    ExtensionManagementUtility::addToAllTCAtypes(
        'pages',
        'tx_my_site_package_topics',
        '',
        'after:title',
    );
    ```

2. Save the file.

## Apply the database change and verify the result

Finally, create some categories, attach them to a page, and check the result.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Open **Admin Tools > Maintenance** and apply the database changes (Flush cache + Analyze Database Structure).
3. Open the **List** module from the module menu.
4. Pick a folder for your categories (or use the site root for testing).
5. Click **Create new record** and choose **Category** under "System records".
6. Create at least three categories — for example, "TYPO3", "Tutorials", "Events".
7. Open the page properties of any page.
8. Locate the new **Topics** field below the **Page title** field. It should display a tree-style category picker.
9. Pick two or three of your categories and save.

After saving, reopen the page properties — the selected categories should still be there.

> [!NOTE]
> The `pages` table also has a built-in `categories` field provided by TYPO3 Core. Use it if you want to follow Core conventions and integrate with extensions like `news`. Use a custom `tx_my_site_package_topics` field (as in this guide) when you need a *separate* taxonomy that doesn't share the same category tree.

> [!TIP]
> If the field appears empty even after creating categories, check that the categories you created are not in a hidden or deleted state, and that they aren't restricted by access rights to a different backend user group.

## Summary

Congratulations! You added one custom category field to a TYPO3 page record. Editors can now tag pages with topics from a central, manageable taxonomy, and TYPO3 handles all the relation tracking through `sys_category_record_mm`.

## Next steps

Now that you can attach categories, you might like to:

* [Add a Database Relation Field](AddADatabaseRelationField.md) for relations to other tables
* [Make a Field Required in TCA](MakeAFieldRequiredInTca.md)
* Render category labels in the frontend (uses `CategoryCollection` and `<f:for>` — covered in a future guide)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Category fields in TCA](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Category/Index.html)
* [sys_category table reference](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/Categories/Index.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
