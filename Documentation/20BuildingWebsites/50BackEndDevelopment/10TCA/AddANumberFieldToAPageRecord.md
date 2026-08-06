# Add a Number Field to a Page Record

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

Some pages need a numeric value — a sort priority, a custom counter, a price, a rating. TCA's `number` type adds a numeric input to page properties with built-in validation, so editors cannot accidentally enter letters or symbols where a number belongs.

## Learning objective

In this step-by-step guide you will add one custom integer number field to the TYPO3 `pages` record and make it editable in page properties.

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
> Replace `tx_my_site_package_priority` with your own custom field name. Custom fields on Core tables usually start with the prefix `tx_`.

## Add the database column

First, let's define the new field in your Site Package as an integer column on the `pages` table.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. If the file does not exist yet, create it.
3. Add the following SQL definition:

    ```sql
    CREATE TABLE pages (
        tx_my_site_package_priority int(11) DEFAULT '0' NOT NULL
    );
    ```

4. Save the file.

The new field is now part of your extension's database definition.

> [!NOTE]
> If your `ext_tables.sql` already contains a `CREATE TABLE pages (...)` block from a previous guide, you can either add a second block (TYPO3 merges them at install time) or add the new column inside the existing block. Both work.

## Register the field in TCA

Next, register the field in TCA so TYPO3 renders it as a number input in the backend form.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Below the existing TCA columns, add the following code:

    ```php
    ExtensionManagementUtility::addTCAcolumns(
        'pages',
        [
            'tx_my_site_package_priority' => [
                'exclude' => true,                  // hide from non-admin users by default
                'label' => 'Priority',
                'config' => [
                    'type' => 'number',             // numeric input with browser-side validation
                    'format' => 'integer',          // 'integer' or 'decimal'
                    'size' => 10,                   // visible width in characters
                    'range' => [
                        'lower' => 0,               // minimum allowed value
                        'upper' => 100,             // maximum allowed value
                    ],
                    'default' => 0,
                ],
            ],
        ]
    );
    ```

3. Save the file.

TYPO3 now knows the field definition, but the field is not yet visible in page properties.

> [!TIP]
> Use `format: 'integer'` for whole numbers, or `format: 'decimal'` for floating-point values. For decimals, also change the SQL type to `decimal(10,2) DEFAULT '0.00' NOT NULL` (or similar) to store fractional values correctly.

## Place the field in page properties

Now we'll add the field to the page form so editors can see and use it.

1. In the same file, below the previous code, add:

    ```php
    ExtensionManagementUtility::addToAllTCAtypes(
        'pages',
        'tx_my_site_package_priority',
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
4. In **Analyze Database Structure**, apply the suggested change for `tx_my_site_package_priority`.
5. Open the page properties of any page.
6. Verify that the new field **Priority** appears below the **Page title** field as a numeric input.
7. Try entering a non-numeric character — it should be rejected. Try a number outside the 0–100 range — it should also be rejected.
8. Enter a value between 0 and 100 and save the page.

After saving, the value should remain stored in the page record.

> [!TIP]
> If you don't need a range, simply omit the `range` configuration. The field will then accept any integer.

## Summary

Congratulations! You added one custom number field to a TYPO3 page record with built-in range validation. Editors can now enter a numeric value in page properties and trust that out-of-range or non-numeric input will be caught.

## Next steps

Now that you have a number field, you might like to:

* [Render a Custom Page Field in a Fluid Template](RenderACustomPageFieldInAFluidTemplate.md) — number values render the same as text
* [Add a Dropdown Field to a Page Record](AddADropdownFieldToAPageRecord.md)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Number fields in TCA](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Number/Index.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
* [Page properties](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Modules/PageProperties/Index.html)
