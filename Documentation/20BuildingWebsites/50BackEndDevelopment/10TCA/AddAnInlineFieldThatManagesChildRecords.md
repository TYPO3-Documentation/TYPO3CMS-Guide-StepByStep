# Add an Inline Field That Manages Child Records

<!-- #TYPO3v13 #Intermediary #Backend #Configuration #SitePackage @dragos_tuluc -->

With the child table in place, the next step is to give editors a way to add, sort and remove child records from the parent's form — without ever leaving the page properties view. TCA's `type: inline` (also known as IRRE — Inline Relational Record Editing) embeds child records directly into the parent's form, so editors manage everything in one place. Each child record gets its own collapsible block; editors can add new ones, expand and edit them, and drag-and-drop to reorder.

This guide is the second in a three-part series:

1. [Create a Custom Table for Child Records](CreateACustomTableForChildRecords.md)
2. **Add an Inline Field That Manages Child Records** — *this guide*
3. [Render Inline Child Records in the Frontend](RenderInlineChildRecordsInTheFrontend.md)

## Learning objective

In this step-by-step guide you will add a `type: inline` field on the `pages` table that lets editors manage `tx_my_site_package_download` child records directly from page properties.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* You have completed [Create a Custom Table for Child Records](CreateACustomTableForChildRecords.md)
* A code editor

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key. The field name `tx_my_site_package_downloads` (plural) is the inline collection on the page; the table name `tx_my_site_package_download` (singular) is the child record table from the previous guide.

## Add the database column on the parent table

Like other relation fields, an inline field stores the count of related child records as an integer on the parent record. The actual relations are tracked through `parent_uid` and `parent_table` on the child table.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. Add the following column to the `CREATE TABLE pages` block (or add a new block if you prefer):

    ```sql
    CREATE TABLE pages (
        tx_my_site_package_downloads int(11) unsigned DEFAULT '0' NOT NULL
    );
    ```

3. Save the file.

## Register the inline field in TCA

Now register the inline field on `pages`, pointing to the child table.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Below the existing TCA columns, add the following code:

    ```php
    ExtensionManagementUtility::addTCAcolumns(
        'pages',
        [
            'tx_my_site_package_downloads' => [
                'exclude' => true,
                'label' => 'Downloads',
                'config' => [
                    'type' => 'inline',                                          // embedded child records
                    'foreign_table' => 'tx_my_site_package_download',            // the child table
                    'foreign_field' => 'parent_uid',                             // child column that stores parent uid
                    'foreign_table_field' => 'parent_table',                     // child column that stores parent table name
                    'foreign_sortby' => 'sorting',                               // child column for explicit sort order
                    'maxitems' => 10,
                    'appearance' => [
                        'collapseAll' => 1,                                      // start with all child records collapsed
                        'expandSingle' => 1,                                     // only one child record expanded at a time
                        'newRecordLinkAddTitle' => 1,                            // show "Create new" with the table title
                        'levelLinksPosition' => 'bottom',                        // "Create new" link below the children
                    ],
                ],
            ],
        ]
    );
    ```

3. Save the file.

This configuration tells TYPO3: "On the `pages` table, the field `tx_my_site_package_downloads` is an inline relation to `tx_my_site_package_download`. Children record their parent in `parent_uid`/`parent_table`, and they're sorted by `sorting`."

> [!TIP]
> The three `foreign_*` properties together form the contract between parent and child:
>
> * `foreign_field` — the child column that stores the parent record's UID
> * `foreign_table_field` — the child column that stores the parent table name (so a child can know it belongs to a *page* and not, say, a content element)
> * `foreign_sortby` — the child column used for explicit sorting (drag-and-drop)
>
> All three columns must exist in your child table's `ext_tables.sql` — they were added in the previous guide.

## Place the field in page properties

Now we'll add the field to the page form so editors can see and use it.

1. In the same file, below the previous code, add:

    ```php
    ExtensionManagementUtility::addToAllTCAtypes(
        'pages',
        'tx_my_site_package_downloads',
        '',
        'after:title',
    );
    ```

2. Save the file.

## Apply the database change and verify the result

Finally, flush caches, apply the schema, and check the new field.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Open **Admin Tools > Maintenance**.
3. In **Flush TYPO3 and PHP Cache**, click **Flush cache**.
4. In **Analyze Database Structure**, apply the suggested change for `tx_my_site_package_downloads`.
5. Open the page properties of any page.
6. Locate the new **Downloads** section below the **Page title** field.
7. Click the **Create new Page Download** link.

A new collapsible child record should appear, with form fields for **Title**, **Description**, and **File**.

8. Fill in a title (e.g., "Annual Report 2025"), an optional description, and attach a file.
9. Click **Create new Page Download** again to add a second download.
10. Drag the second download above the first one to reorder them.
11. Save the page.

After saving, reopen the page properties — both downloads should still be there, in the order you set.

> [!TIP]
> If the **Downloads** section appears but child records cannot be created, double-check:
>
> * That the child table exists in the database (run **Analyze Database Structure** again).
> * That `foreign_field` and `foreign_table_field` values match the column names in your child table's `ext_tables.sql`.
> * That the child TCA's `'hideTable' => true` is not blocking child record creation (it shouldn't — `hideTable` only hides from List module, not inline forms).

## Summary

Congratulations! You wired up an inline relation between `pages` and `tx_my_site_package_download`. Editors can now manage an arbitrary number of child records directly from page properties, with drag-and-drop sorting and individual create/edit/delete controls.

## Next steps

Continue the series:

* [Render Inline Child Records in the Frontend](RenderInlineChildRecordsInTheFrontend.md) — display the downloads on your website

Or explore related topics:

* [Add a Database Relation Field](AddADatabaseRelationField.md) for relations to existing tables (one record per page)
* [Add a Category Field with sys_category](AddACategoryFieldWithSysCategory.md) for taxonomic relations

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Inline (IRRE) reference](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Inline/Index.html)
* [`foreign_field` reference](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Inline/Properties/ForeignField.html)
* [`appearance` properties for inline](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Inline/Properties/Appearance.html)
