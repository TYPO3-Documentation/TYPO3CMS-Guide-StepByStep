# Group Fields into a Tab in Page Properties

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

Page properties already have several built-in tabs — General, SEO, Social media, Access. When you add many custom fields, scattering them across the existing tabs creates confusion. TCA's `--div--` showitem token lets you create a new tab for your own fields, so they live in a clearly labeled section instead of being squeezed in among Core fields.

## Learning objective

In this step-by-step guide you will create a new tab called **Custom Fields** in page properties, and place several existing custom fields under it.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* At least two custom fields on the `pages` table, such as those from [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md) and [Add a Textarea Field to a Page Record](AddATextareaFieldToAPageRecord.md)
* A code editor

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* Basic understanding of TCA `addToAllTCAtypes`
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and the field names with the ones you have actually defined.

## Replace the existing field placement with a tab block

Earlier guides used `addToAllTCAtypes` once per field, placing each one `after:title`. To group fields under a new tab, we replace those individual calls with a single call that defines the tab and lists the fields.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Find every existing `addToAllTCAtypes(...)` call for your custom fields and remove them.
3. Below the `addTCAcolumns` block, add a single call that creates the tab and places the fields:

    ```php
    ExtensionManagementUtility::addToAllTCAtypes(
        'pages',
        '
            --div--;Custom Fields,
            tx_my_site_package_teaser,
            tx_my_site_package_summary,
            tx_my_site_package_publish_date,
            tx_my_site_package_category
        ',
        '',
        'after:title',
    );
    ```

4. Save the file.

The `--div--;Custom Fields` token marks the start of a new tab named "Custom Fields". Every field listed after it (until the next `--div--`) is placed inside that tab.

> [!TIP]
> Multiple `--div--` tokens in the same `showitem` string create multiple tabs. For example, `--div--;Tab A, field1, --div--;Tab B, field2` creates two tabs each with one field. This is how TYPO3 Core's standard tabs (General, SEO, Access) are defined internally.

## Verify the tab in page properties

Finally, flush the caches and confirm the tab appears.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Open the page properties of any page.
4. Across the top of the form, find the new **Custom Fields** tab among the existing ones (General, SEO, etc.).
5. Click the tab.

All four fields you listed should appear inside, stacked vertically.

> [!NOTE]
> Tab labels can use `LLL:EXT:my_site_package/Resources/Private/Language/locallang_db.xlf:tabs.custom` references for translation, instead of hardcoded English strings. That is beyond the scope of this guide.

## Summary

Congratulations! You created a dedicated **Custom Fields** tab in page properties and grouped your custom fields under it. Editors now see custom data in a clearly labeled section, separate from TYPO3 Core fields.

## Next steps

Now that you can group fields into tabs, you might like to:

* [Group Fields into a Palette in Page Properties](GroupFieldsIntoAPaletteInPageProperties.md) to display fields side-by-side
* [Make a Field Required in TCA](MakeAFieldRequiredInTca.md)
* [Add a Custom Field to a Content Element](AddACustomFieldToAContentElement.md)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [showitem syntax and `--div--`](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Types/Properties/Showitem.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
* [Page properties](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Modules/PageProperties/Index.html)
