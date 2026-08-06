# Show a Field Conditionally with displayCond

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

Page properties can become cluttered when fields apply only in certain situations — a "Featured priority" only matters when "Highlight this page" is checked, an "Event date" only matters for event pages. TCA's `displayCond` evaluates a condition based on another field's value and shows or hides the field accordingly. The form stays clean, and editors are not confused by irrelevant inputs.

## Learning objective

In this step-by-step guide you will hide the **Page summary** field (`tx_my_site_package_summary`) by default, and reveal it only when the **Highlight this page** checkbox (`tx_my_site_package_highlight_page`) is enabled.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* A textarea field on the `pages` table, as described in [Add a Textarea Field to a Page Record](AddATextareaFieldToAPageRecord.md)
* A checkbox field on the `pages` table, as described in [Add a Checkbox Field to a Page Record](AddACheckboxFieldToAPageRecord.md)

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and the field names with the ones you have actually defined.

## Add a displayCond to the textarea field

Let's open the TCA file and tell TYPO3 to hide the textarea unless the checkbox is checked.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Find the `tx_my_site_package_summary` definition inside `addTCAcolumns`.
3. Add a `displayCond` key right next to `label`:

    ```php
    'tx_my_site_package_summary' => [
        'exclude' => true,
        'label' => 'Page summary',
        'displayCond' => 'FIELD:tx_my_site_package_highlight_page:!=:0',  // shown only when checkbox is on
        'config' => [
            'type' => 'text',
            'rows' => 5,
            'cols' => 40,
        ],
    ],
    ```

4. Save the file.

The `FIELD:` syntax follows the pattern `FIELD:<other_field_name>:<operator>:<value>`. In this example: show the field only when `tx_my_site_package_highlight_page` is not equal to zero (the unchecked state).

> [!TIP]
> Common operators in the string syntax:
>
> * `=` — value matches exactly
> * `!=` — value does not match
> * `>=`, `<=` — numeric comparison
> * `IN:value1,value2` — value is one of a comma-separated list
> * `BIT:value` — bitmask check (advanced)
> * `REQ:true` — field has any value (not empty)

## Verify the conditional display

Finally, flush caches and confirm the form behavior.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Open the page properties of any page where the **Highlight this page** checkbox is unchecked.
4. Confirm the **Page summary** field is **not** visible.
5. Check the **Highlight this page** checkbox and save the page.
6. Reopen the page properties.

The **Page summary** field should now be visible. Toggle the checkbox off, save, and reopen — the field disappears again.

> [!NOTE]
> `displayCond` is a backend-form behavior only. It does not affect the database: even when the field is hidden, its stored value is preserved. If you want the field to be cleared when the condition turns false, do that explicitly in your application logic — `displayCond` is purely a form-rendering convenience.

## Use array syntax for complex conditions

For conditions that combine multiple fields with AND / OR logic, use the array syntax instead of the string syntax. Replace the `displayCond` line with:

```php
'displayCond' => [
    'AND' => [
        'FIELD:tx_my_site_package_highlight_page:!=:0',
        'FIELD:tx_my_site_package_category:IN:news,event',
    ],
],
```

This shows the field only when the checkbox is on AND the category is `news` or `event`. You can nest `AND` / `OR` arbitrarily for very specific rules.

> [!TIP]
> The string syntax is more readable for simple conditions. Switch to array syntax only when you need multiple conditions combined. Mixing the two in the same TCA configuration is fine.

## Summary

Congratulations! You hid a TCA field unless another field has a specific value. Editors now see only the fields that are relevant to the page they are editing, keeping the form focused and approachable.

## Next steps

Now that you can show fields conditionally, you might like to:

* [Override a Default TCA Field](OverrideADefaultTcaField.md)
* [Group Fields into a Tab in Page Properties](GroupFieldsIntoATabInPageProperties.md)
* [Group Fields into a Palette in Page Properties](GroupFieldsIntoAPaletteInPageProperties.md)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [`displayCond` reference](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Columns/Properties/Displaycond.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
