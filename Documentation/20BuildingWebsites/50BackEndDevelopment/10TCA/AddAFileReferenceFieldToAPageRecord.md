# Add a File Reference Field to a Page Record

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

Many pages need an image — a hero banner, a teaser thumbnail, a social-sharing graphic. TCA's `file` type lets editors attach one or more files from TYPO3's File Abstraction Layer (FAL) to a page record. The file is referenced — not copied — so the same image can be reused across many pages, and updating the image once updates it everywhere.

## Learning objective

In this step-by-step guide you will add one custom file reference field to the TYPO3 `pages` record, restricted to image files, and make it editable in page properties.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* Access to the file system of your TYPO3 project
* A code editor
* A TYPO3 backend account with access to **Admin Tools > Maintenance**
* At least one image uploaded to the TYPO3 file list (`fileadmin/`)

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)
* You have completed [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key.
>
> Replace `tx_my_site_package_hero_image` with your own custom field name. Custom fields on Core tables usually start with the prefix `tx_`.

## Add the database column

First, let's define the new field. File reference fields store the *count* of references in the page record, while the actual references live in the `sys_file_reference` table — TYPO3 wires this up automatically when you use `type: file`.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. If the file does not exist yet, create it.
3. Add the following SQL definition:

    ```sql
    CREATE TABLE pages (
        tx_my_site_package_hero_image int(11) unsigned DEFAULT '0' NOT NULL
    );
    ```

4. Save the file.

The new field is now part of your extension's database definition.

> [!NOTE]
> If your `ext_tables.sql` already contains a `CREATE TABLE pages (...)` block from a previous guide, you can either add a second block (TYPO3 merges them at install time) or add the new column inside the existing block. Both work.

## Register the field in TCA

Next, register the field in TCA. TYPO3 v13 introduces the simplified `type: file`, which replaces the older verbose FAL inline-relation pattern with a single line of intent.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Below the existing TCA columns, add the following code:

    ```php
    ExtensionManagementUtility::addTCAcolumns(
        'pages',
        [
            'tx_my_site_package_hero_image' => [
                'exclude' => true,                          // hide from non-admin users by default
                'label' => 'Hero image',
                'config' => [
                    'type' => 'file',                       // simplified FAL field type (v12+)
                    'allowed' => 'common-image-types',      // expands to $GLOBALS['TYPO3_CONF_VARS']['GFX']['imagefile_ext'] (by default: gif, jpg, jpeg, png, svg, webp, tif, bmp, pdf, ai, ...)
                    'maxitems' => 1,                        // accept at most one image
                ],
            ],
        ]
    );
    ```

3. Save the file.

TYPO3 now knows the field definition, but the field is not yet visible in page properties.

> [!TIP]
> Use `'allowed' => 'common-image-types'` for images, `'common-media-types'` for images plus video and audio, or list specific extensions like `'allowed' => 'pdf,docx'` for documents. Set `maxitems` higher than 1 to allow a gallery of images.

## Place the field in page properties

Now we'll add the field to the page form so editors can see and use it.

1. In the same file, below the previous code, add:

    ```php
    ExtensionManagementUtility::addToAllTCAtypes(
        'pages',
        'tx_my_site_package_hero_image',
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
4. In **Analyze Database Structure**, apply the suggested change for `tx_my_site_package_hero_image`.
5. Open the page properties of any page.
6. Verify that the new field **Hero image** appears below the **Page title** field, with **Add file reference** and **Add image from list** buttons.
7. Click **Add image from list**, pick an image from `fileadmin/`, and save the page.

After saving, reopen the page properties — the image should still be attached, with options to fill in alternative text, title text, and a description.

> [!TIP]
> If the upload buttons do not appear, double-check that you ran **Analyze Database Structure** in Maintenance. The field is registered in TCA, but unusable until the database column exists.

## Summary

Congratulations! You added one custom file reference field to a TYPO3 page record. Editors can now attach an image to any page, and TYPO3 manages the underlying FAL relations for you.

## Next steps

Now that you have a file reference field, you might like to:

* [Display an Image from a File Reference Field](DisplayAnImageFromAFileReferenceField.md) to render the image on your website
* [Make a Field Required in TCA](MakeAFieldRequiredInTca.md)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [File fields in TCA](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/File/Index.html)
* [File Abstraction Layer (FAL)](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/Fal/Index.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
* [Page properties](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Modules/PageProperties/Index.html)
