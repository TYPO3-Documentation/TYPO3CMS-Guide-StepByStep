# Add a Text Field to a Page Record

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

Page properties are the backend form for records in TYPO3’s `pages` table. Adding one custom field there is a practical first step into [TCA](https://docs.typo3.org/permalink/t3tca:start), because you extend a TYPO3 Core record and can verify the result immediately in the backend.

## Learning objective

In this step-by-step guide you will add one custom text field to the TYPO3 `pages` record and make it editable in page properties.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* Access to the file system of your TYPO3 project
* A code editor
* A TYPO3 backend account with access to **Admin Tools > Maintenance**

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You know how to [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key.
>
> Replace `tx_my_site_package_teaser` with your own custom field name. Custom fields on Core tables usually start with the prefix `tx_`.

## Add the database column

First, define the new field in your Site Package so TYPO3 can add it to the `pages` table.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. If the file does not exist yet, create it.
3. Add the following SQL definition:

```sql
CREATE TABLE pages (
    tx_my_site_package_teaser varchar(255) DEFAULT '' NOT NULL
);
```

4. Save the file.

The new field is now part of your extension’s database definition.

## Register the field in TCA

Next, register the field in TCA so TYPO3 knows how to render it in the backend form.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. If the file does not exist yet, create it.
3. Add the following code:

```php
<?php

declare(strict_types=1);

defined('TYPO3') or die();

use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

ExtensionManagementUtility::addTCAcolumns(
    'pages',
    [
        'tx_my_site_package_teaser' => [
            'exclude' => true,
            'label' => 'Teaser text',
            'config' => [
                'type' => 'input',
                'size' => 50,
                'max' => 255,
                'eval' => 'trim',
            ],
        ],
    ]
);
```

4. Save the file.

TYPO3 now knows the field definition, but the field is not yet visible in page properties.

> [!TIP]
> The `input` field type is a good starting point for learning TCA because it adds a simple text field with very little configuration.

## Place the field in page properties

Now add the field to the page form.

1. In the same file, below the previous code, add:

```php
ExtensionManagementUtility::addToAllTCAtypes(
    'pages',
    'tx_my_site_package_teaser',
    '',
    'after:title',
);
```

2. Save the file.

The field is now configured to appear after the page title field.

## Apply the database change and verify the result

Finally, flush the caches, apply the schema change, and check the new field in the backend.

1. Log in to the TYPO3 backend.
2. Open **Admin Tools > Maintenance**.
3. In **Flush TYPO3 and PHP Cache**, click **Flush cache**.
4. In **Analyze Database Structure**, apply the suggested change for `tx_my_site_package_teaser`.
5. Open the page properties of any page.
6. Verify that the new field **Teaser text** appears below the **Page title** field.
7. Enter a value and save the page.

After saving, the value should remain stored in the page record.

## Summary

Congratulations! You added one custom text field to a TYPO3 page record and made it editable in page properties.

## Next steps

Now that you have added one custom page field, you might like to:

* [Add a Checkbox Field to a Page Record](AddACheckboxFieldToAPageRecord.md)
* [Render a Custom Page Field in a Fluid Template](RenderACustomPageFieldInAFluidTemplate.md)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
* [Page properties](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Modules/PageProperties/Index.html)
* [ext_tables.sql](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/FileStructure/ExtTablesSql.html)
