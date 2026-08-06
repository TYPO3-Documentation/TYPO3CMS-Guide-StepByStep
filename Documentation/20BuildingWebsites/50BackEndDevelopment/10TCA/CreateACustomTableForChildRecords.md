# Create a Custom Table for Child Records

<!-- #TYPO3v13 #Intermediary #Backend #Configuration #SitePackage @dragos_tuluc -->

Sometimes a single field on a page is not enough — a page might need an arbitrary number of downloads, FAQ items, team members, or speakers. Each of those nested entries deserves its own record, with its own fields, its own sorting, and its own lifecycle. The pattern is to create a new database table dedicated to those records, so they can be edited, reordered, and deleted independently.

This guide is the first in a three-part series:

1. **Create a Custom Table for Child Records** — *this guide*
2. [Add an Inline Field That Manages Child Records](AddAnInlineFieldThatManagesChildRecords.md) — link the table to a page via an Inline (IRRE) field
3. [Render Inline Child Records in the Frontend](RenderInlineChildRecordsInTheFrontend.md) — display the records on the website

## Learning objective

In this step-by-step guide you will create a new database table — `tx_my_site_package_download` — that stores per-page download entries (a title, a description, and a file). The table will be ready to be linked to a parent record in the next guide.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* A code editor
* A TYPO3 backend account with access to **Admin Tools > Maintenance**

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You have completed [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md) — the TCA column patterns are the same
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and `tx_my_site_package_download` with your own table name. Custom tables in TYPO3 must be lowercase, prefixed with `tx_<extension_key>_`, and use underscore separators.

## Add the table to the database schema

First, let's declare the new table in `ext_tables.sql`. The file lists the custom columns; TYPO3 automatically provides the standard infrastructure columns (`uid`, `pid`, `tstamp`, `crdate`, `deleted`, `hidden`) when you reference the table in TCA.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. Add the following SQL definition (alongside any existing `CREATE TABLE` blocks):

    ```sql
    CREATE TABLE tx_my_site_package_download (
        title varchar(255) DEFAULT '' NOT NULL,
        description text,
        file int(10) unsigned DEFAULT '0' NOT NULL,

        parent_uid int(11) unsigned DEFAULT '0' NOT NULL,    -- which record this download belongs to
        parent_table varchar(63) DEFAULT '' NOT NULL,        -- which table the parent record is in
        sorting int(11) DEFAULT '0' NOT NULL                 -- explicit sort order in the parent's list
    );
    ```

3. Save the file.

The `parent_uid` and `parent_table` columns are placeholders for the inline relation that the next guide will configure. Including them now means the table is fully ready to be wired up later, with no schema changes needed.

> [!NOTE]
> The naming convention `parent_uid` / `parent_table` is a project choice — TYPO3 lets you call them anything you want, as long as the inline TCA configuration in the next guide uses the same names. Other common conventions: `pages_uid` + `pages_tablenames` (specific to one parent), `foreign_uid` + `foreign_table`.

## Define the table's TCA

Next, create the TCA file for the new table. Unlike the override files we wrote so far, this is a *full* TCA definition — the table didn't exist before, so there's nothing to override.

1. Create a new file at `packages/my_site_package/Configuration/TCA/tx_my_site_package_download.php`.
2. Paste the following content:

    ```php
    <?php

    declare(strict_types=1);

    return [
        'ctrl' => [
            'title' => 'Page Download',                                              // human label of the table
            'label' => 'title',                                                      // which column to show in lists
            'tstamp' => 'tstamp',                                                    // automatic update timestamp
            'crdate' => 'crdate',                                                    // automatic creation timestamp
            'delete' => 'deleted',                                                   // soft delete column
            'enablecolumns' => [
                'disabled' => 'hidden',
            ],
            'sortby' => 'sorting',                                                   // explicit drag-and-drop sorting
            'iconfile' => 'EXT:my_site_package/Resources/Public/Icons/Extension.svg',
            'hideTable' => true,                                                     // hide from List module unless drilled into
        ],
        'columns' => [
            'title' => [
                'label' => 'Title',
                'config' => [
                    'type' => 'input',
                    'size' => 50,
                    'max' => 255,
                    'eval' => 'trim',
                    'required' => true,
                ],
            ],
            'description' => [
                'label' => 'Description',
                'config' => [
                    'type' => 'text',
                    'rows' => 4,
                    'cols' => 40,
                ],
            ],
            'file' => [
                'label' => 'File',
                'config' => [
                    'type' => 'file',
                    'allowed' => 'common-media-types',
                    'maxitems' => 1,
                ],
            ],
        ],
        'types' => [
            '0' => [
                'showitem' => 'title, description, file',
            ],
        ],
    ];
    ```

3. Save the file.

This TCA tells TYPO3 everything it needs to know: the table's display label, which column is the record title (`title`), how to handle soft-deletes and hiding, what fields exist, and how to lay them out in the form.

> [!TIP]
> `'hideTable' => true` keeps the table out of the **List** module by default. Editors won't see "Page Download" as a top-level option — they will only edit downloads through the inline field on a page (set up in the next guide). This is the right default for inline-only child tables.

## Apply the database change and verify

Finally, flush caches and apply the schema.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Open **Admin Tools > Maintenance**.
3. In **Flush TYPO3 and PHP Cache**, click **Flush cache**.
4. In **Analyze Database Structure**, apply the suggested **CREATE TABLE** statement for `tx_my_site_package_download` along with the column changes.
5. Open the **List** module to confirm the table exists in the database. Because of `hideTable: true`, you won't see it as a clickable entry — but it's there, ready to receive records via the inline field.

The table is now created in the database with proper TCA wiring.

> [!TIP]
> If you want to test the table standalone before adding the inline field, comment out `'hideTable' => true` and use the **List** module to create one or two records directly. Restore the flag after the next guide is done.

## Summary

Congratulations! You created a custom database table for child records, complete with infrastructure columns, TCA, and a clean form layout. The table is ready to be linked to a parent record in the next guide.

## Next steps

Continue the series:

* [Add an Inline Field That Manages Child Records](AddAnInlineFieldThatManagesChildRecords.md) — link this table to a page via an Inline (IRRE) field

Or explore related topics:

* [Add a Custom Field to a Content Element](AddACustomFieldToAContentElement.md) for the same pattern on `tt_content`
* [Add a Database Relation Field](AddADatabaseRelationField.md) for one-to-one relations to existing tables

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Creating new tables in TYPO3](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/CreateNewTcaTable/Index.html)
* [TCA `ctrl` properties](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Ctrl/Index.html)
* [ext_tables.sql](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/FileStructure/ExtTablesSql.html)
