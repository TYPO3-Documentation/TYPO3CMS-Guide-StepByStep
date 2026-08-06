# Group Fields into a Palette in Page Properties

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

When two or three short fields belong logically together — a publish date with a category, a width with a height, a first name with a last name — stacking them vertically wastes space and visually separates information that should be read as a unit. TCA palettes display multiple fields side-by-side on the same row, so related fields look related.

## Learning objective

In this step-by-step guide you will define a TCA palette named `my_site_package_meta` that groups two existing custom fields — `tx_my_site_package_publish_date` and `tx_my_site_package_category` — and place that palette in page properties so the two fields appear on a single row.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* At least two custom fields on the `pages` table, such as those from [Add a Date Field to a Page Record](AddADateFieldToAPageRecord.md) and [Add a Dropdown Field to a Page Record](AddADropdownFieldToAPageRecord.md)
* A code editor

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* Basic understanding of TCA showitem syntax (see [Group Fields into a Tab in Page Properties](GroupFieldsIntoATabInPageProperties.md))
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and the field names with the ones you have actually defined.

## Define the palette

A palette has a name (used to reference it later) and a list of fields it contains. Define it once in TCA, then reuse it wherever you want those fields shown together.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Below the `addTCAcolumns` block (and before any `addToAllTCAtypes` call), add the palette definition:

    ```php
    $GLOBALS['TCA']['pages']['palettes']['my_site_package_meta'] = [
        'label' => 'Publish settings',
        'showitem' => 'tx_my_site_package_publish_date, tx_my_site_package_category',
    ];
    ```

3. Save the file.

The palette is now registered. Its `label` shows as a sub-heading above the row, and `showitem` lists the fields rendered side-by-side in the order given.

> [!TIP]
> You can insert a `--linebreak--` token inside `showitem` to force the next field onto a new row. For example, `'field1, field2, --linebreak--, field3'` puts `field1` and `field2` on the first row, and `field3` alone on a second row. Use this when a palette has more fields than fit on one row.

## Place the palette in page properties

Now reference the palette from `addToAllTCAtypes` using the `--palette--` token.

1. In the same file, replace the previous `addToAllTCAtypes` call (the one that listed individual fields) with a call that uses the palette token:

    ```php
    ExtensionManagementUtility::addToAllTCAtypes(
        'pages',
        '
            --div--;Custom Fields,
            tx_my_site_package_teaser,
            tx_my_site_package_summary,
            --palette--;;my_site_package_meta
        ',
        '',
        'after:title',
    );
    ```

2. Save the file.

The `--palette--` token has three semicolon-separated parts: `--palette--;<override_label>;<palette_name>`. The middle part is left empty here, so the palette uses its own `label` from the definition. Fill it in to override per usage location.

> [!TIP]
> A single palette definition can be reused in many places — for example, the same `my_site_package_meta` palette can appear under page properties, content element forms, and backend user records, just by referencing it via `--palette--` in each TCA showitem string. Define once, use everywhere.

## Verify the palette in page properties

Finally, flush caches and confirm the layout.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Open the page properties of any page.
4. Click the **Custom Fields** tab.
5. Find the **Publish settings** sub-heading.

Below it, the **Publish date** picker and the **Category** dropdown should appear side-by-side on the same row, instead of stacked vertically.

## Summary

Congratulations! You defined a reusable TCA palette and used it to group two related fields side-by-side in page properties. Related fields now look visually related, and the palette can be reused on other tables too.

## Next steps

Now that you can group fields into palettes, you might like to:

* [Make a Field Required in TCA](MakeAFieldRequiredInTca.md)
* [Add a Custom Field to a Content Element](AddACustomFieldToAContentElement.md)
* [Add a Custom Field to Backend Users](AddACustomFieldToBackendUsers.md)

## Resources

* [TCA palettes reference](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Palettes/Index.html)
* [showitem syntax](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Types/Properties/Showitem.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
* [Page properties](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Modules/PageProperties/Index.html)
