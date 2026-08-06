# Add a Textarea Field to a Page Record

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

When building a TYPO3 site, editors often need to enter longer pieces of text on a page — a teaser paragraph for menus, an internal description, or a short summary. A single-line input field is not enough. TCA's `text` type lets you add a multi-line textarea right inside page properties, where editors expect to find it.

## Learning objective

In this step-by-step guide you will add one custom multi-line textarea field to the TYPO3 `pages` record and make it editable in page properties.

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
> Replace `tx_my_site_package_summary` with your own custom field name. Custom fields on Core tables usually start with the prefix `tx_`.

## Add the database column

First, let's define the new field in your Site Package so TYPO3 can add it to the `pages` table.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. If the file does not exist yet, create it.
3. Add the following SQL definition:

    ```sql
    CREATE TABLE pages (
        tx_my_site_package_summary text
    );
    ```

4. Save the file.

The new field is now part of your extension's database definition.

> [!NOTE]
> If your `ext_tables.sql` already contains a `CREATE TABLE pages (...)` block from a previous guide, you can either add a second block (TYPO3 merges them at install time) or add the new column inside the existing block. Both work.

## Register the field in TCA

Next, register the field in TCA so TYPO3 knows how to render it as a textarea in the backend form.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Below the existing TCA columns, add the following code:

    ```php
    ExtensionManagementUtility::addTCAcolumns(
        'pages',
        [
            'tx_my_site_package_summary' => [
                'exclude' => true,                  // hide from non-admin users by default
                'label' => 'Page summary',
                'config' => [
                    'type' => 'text',               // multi-line textarea
                    'rows' => 5,                    // visible height in rows
                    'cols' => 40,                   // visible width in characters
                ],
            ],
        ]
    );
    ```

3. Save the file.

TYPO3 now knows the field definition, but the field is not yet visible in page properties.

> [!TIP]
> Use `type: text` for any multi-line plain text input. To turn it into a rich text editor with a formatting toolbar, add `'enableRichtext' => true,` inside `config`.

## Place the field in page properties

Now we'll add the field to the page form so editors can see and use it.

1. In the same file, below the previous code, add:

    ```php
    ExtensionManagementUtility::addToAllTCAtypes(
        'pages',
        'tx_my_site_package_summary',
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
4. In **Analyze Database Structure**, apply the suggested change for `tx_my_site_package_summary`.
5. Open the page properties of any page.
6. Verify that the new field **Page summary** appears below the **Page title** field as a multi-line textarea.
7. Enter a few lines of text and save the page.

After saving, the textarea content should remain stored in the page record across multiple lines.

> [!TIP]
> If the field doesn't appear, double-check that you ran **Analyze Database Structure** in Maintenance. The field is registered in TCA, but unusable until the database column exists.

## Summary

Congratulations! You added one custom textarea field to a TYPO3 page record and made it editable in page properties. Editors can now enter multi-line text directly in the page form.

## Next steps

Now that you have a multi-line text field, you might like to:

* [Add a Date Field to a Page Record](AddADateFieldToAPageRecord.md)
* [Render a Custom Page Field in a Fluid Template](RenderACustomPageFieldInAFluidTemplate.md) to display the new field on your website
* [Render a Rich Text Field as HTML](RenderARichTextFieldAsHtml.md) if you enabled the rich text editor

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Text fields in TCA](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Text/Index.html)
* [Enabling the rich text editor](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Text/Properties/EnableRichtext.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
* [Page properties](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Modules/PageProperties/Index.html)
