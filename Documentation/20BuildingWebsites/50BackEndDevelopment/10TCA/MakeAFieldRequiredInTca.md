# Make a Field Required in TCA

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

When a custom field carries data your site cannot work without — a teaser shown on every list page, a category that drives navigation — leaving it empty silently breaks the frontend. TCA's `required` flag makes a field mandatory in the backend form: editors cannot save the page until they fill it in, with a clear visual error message.

## Learning objective

In this step-by-step guide you will mark an existing custom text field — `tx_my_site_package_teaser` — as required, so editors must enter a value before saving page properties.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* A custom text field on the `pages` table, as described in [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md)
* A code editor

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and `tx_my_site_package_teaser` with the field name you want to make required.

## Add the required flag to the field

Let's open the TCA file and add a single configuration line.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Find the `tx_my_site_package_teaser` definition inside `addTCAcolumns`.
3. Inside its `config` array, add `'required' => true`:

    ```php
    'tx_my_site_package_teaser' => [
        'exclude' => true,
        'label' => 'Teaser text',
        'config' => [
            'type' => 'input',
            'size' => 50,
            'max' => 255,
            'eval' => 'trim',
            'required' => true,                 // editor cannot save empty
        ],
    ],
    ```

4. Save the file.

The field is now declared as mandatory in TCA.

> [!TIP]
> The `required: true` flag works for `input`, `text`, `number`, `email`, `link`, `color`, and most other scalar TCA types. For `select` fields, mandate at least one selection by setting `'minitems' => 1` instead. For `file` fields, the same `minitems` approach applies.

## Verify the result in the backend

Finally, flush caches and confirm the field is enforced.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Open the page properties of any page.
4. Locate the **Teaser text** field — it should now have a red asterisk or "required" indicator next to its label.
5. Clear the field's content and click **Save**.

The save should be blocked: TYPO3 displays an error next to the empty field, and the page is not saved until you enter a value.

> [!NOTE]
> Existing pages that already had an empty teaser before you added `required` will keep their empty value until an editor opens and saves the page. The flag only enforces input on save — it does not retroactively reject existing data. Fix legacy data with a database query or a one-off cleanup script.

## Summary

Congratulations! You marked a TCA field as required. Editors can no longer save page properties without entering a value, protecting the frontend from broken layouts caused by missing data.

## Next steps

Now that you can mark fields as required, you might like to:

* [Group Fields into a Tab in Page Properties](GroupFieldsIntoATabInPageProperties.md)
* [Group Fields into a Palette in Page Properties](GroupFieldsIntoAPaletteInPageProperties.md)
* [Add a Custom Field to a Content Element](AddACustomFieldToAContentElement.md)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [`required` property in TCA](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/CommonProperties/Required.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
* [Page properties](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Configuration/Modules/PageProperties/Index.html)
