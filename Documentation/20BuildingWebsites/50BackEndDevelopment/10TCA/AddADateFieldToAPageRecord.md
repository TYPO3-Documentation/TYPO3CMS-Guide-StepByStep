# Add a Date Field to a Page Record

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

Many pages need a date for editorial workflows — when an article was published, when an event takes place, or when a campaign should go live. TCA's `datetime` type adds a date picker to page properties, so editors can select a date from a calendar instead of typing it.

## Learning objective

In this step-by-step guide you will add one custom date field to the TYPO3 `pages` record and make it editable in page properties.

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
> Replace `tx_my_site_package_publish_date` with your own custom field name. Custom fields on Core tables usually start with the prefix `tx_`.

## Add the database column

First, let's define the new field in your Site Package. TYPO3 stores dates as Unix timestamps (seconds since 1970-01-01) in an integer column.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. If the file does not exist yet, create it.
3. Add the following SQL definition:

    ```sql
    CREATE TABLE pages (
        tx_my_site_package_publish_date int(10) unsigned DEFAULT '0' NOT NULL
    );
    ```

4. Save the file.

The new field is now part of your extension's database definition.

> [!NOTE]
> If your `ext_tables.sql` already contains a `CREATE TABLE pages (...)` block from a previous guide, you can either add a second block (TYPO3 merges them at install time) or add the new column inside the existing block. Both work.

## Register the field in TCA

Next, register the field in TCA so TYPO3 renders it as a date picker in the backend form.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Below the existing TCA columns, add the following code:

    ```php
    ExtensionManagementUtility::addTCAcolumns(
        'pages',
        [
            'tx_my_site_package_publish_date' => [
                'exclude' => true,                  // hide from non-admin users by default
                'label' => 'Publish date',
                'config' => [
                    'type' => 'datetime',           // dedicated date / time field type
                    'format' => 'date',             // 'date', 'datetime', 'time' or 'timesec'
                ],
            ],
        ]
    );
    ```

3. Save the file.

TYPO3 now knows the field definition, but the field is not yet visible in page properties.

> [!TIP]
> The `format` option controls what the editor picker shows. Use `date` for day-month-year only, `datetime` to also pick hours and minutes, `time` for hours and minutes only, or `timesec` to also include seconds.

## Place the field in page properties

Now we'll add the field to the page form so editors can see and use it.

1. In the same file, below the previous code, add:

    ```php
    ExtensionManagementUtility::addToAllTCAtypes(
        'pages',
        'tx_my_site_package_publish_date',
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
4. In **Analyze Database Structure**, apply the suggested change for `tx_my_site_package_publish_date`.
5. Open the page properties of any page.
6. Verify that the new field **Publish date** appears below the **Page title** field, with a calendar icon next to it.
7. Click the calendar icon, pick a date, and save the page.

After saving, reopen the page properties — the date you selected should still be there.

> [!TIP]
> If the date picker does not appear, double-check that you ran **Analyze Database Structure** in Maintenance. The field is registered in TCA, but unusable until the database column exists.

## Summary

Congratulations! You added one custom date field to a TYPO3 page record. Editors can now pick a date from a calendar in page properties, and TYPO3 stores it efficiently as a Unix timestamp.

## Next steps

Now that you have a date field, you might like to:

* [Format a Date Value in the Frontend](FormatADateValueInTheFrontend.md) to display it on your website
* [Add a Number Field to a Page Record](AddANumberFieldToAPageRecord.md)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Datetime fields in TCA](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Datetime/Index.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
* [Page properties](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Modules/PageProperties/Index.html)
