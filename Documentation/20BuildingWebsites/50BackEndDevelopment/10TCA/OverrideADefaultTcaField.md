# Override a Default TCA Field

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

Most TYPO3 Core fields work fine out of the box, but every project eventually needs small tweaks: a shorter title length to enforce design constraints, a relabeled field that matches the team's vocabulary, a default field made required for editorial discipline. You don't need to fork TYPO3 or duplicate the field — TCA is a global configuration array, and surgical overrides in a Site Package are the standard way to adjust Core behavior.

## Learning objective

In this step-by-step guide you will override two properties of the Core `title` field on the `pages` table: change its label from "Page title" to "Page name", and limit its maximum length from 255 to 100 characters.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* A code editor

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key.

## Override the field's label and max length

Core TCA lives in `$GLOBALS['TCA']`. To change a property, assign directly to the right key — the global is loaded by the time TCA Override files run.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Below any existing `addTCAcolumns` calls, add the override statements:

    ```php
    // Change the visible label of the title field
    $GLOBALS['TCA']['pages']['columns']['title']['label'] = 'Page name';

    // Limit the title to 100 characters in the form
    $GLOBALS['TCA']['pages']['columns']['title']['config']['max'] = 100;
    ```

3. Save the file.

Each line edits one property of the `title` field's TCA configuration. You can override anything Core defines — labels, validations, render types, even the field's `type`.

> [!IMPORTANT]
> `max` only restricts what the editor can type into the form. It does **not** change the database column's length. The column on the `pages` table is `varchar(255)` and stays that way. If you want to actually shorten the column, redefine it in your `ext_tables.sql` — but that's a destructive change on existing data and is usually not what you want.

## Verify the overrides in the backend

Finally, flush caches and check the result.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Open the page properties of any page.
4. Confirm the field above the URL slug now reads **Page name** instead of **Page title**.
5. Try typing more than 100 characters into the field — input should be cut off at the limit.

> [!TIP]
> If the label still shows "Page title", make sure no other extension is overriding it later in the load order. TCA is processed in extension dependency order: your Site Package's overrides run after the Core extensions it depends on, but other Site Packages or third-party extensions loaded after yours can re-override the same property. List your Site Package last in `composer.json` constraints if you need it to win.

## Common overrides you might want

The same pattern works for any TCA property:

```php
// Make a Core field required
$GLOBALS['TCA']['pages']['columns']['description']['config']['required'] = true;

// Hide a Core field from non-admin users
$GLOBALS['TCA']['pages']['columns']['nav_hide']['exclude'] = true;

// Change a field's render type (e.g., from selectSingle to selectCheckBox)
$GLOBALS['TCA']['pages']['columns']['categories']['config']['renderType'] = 'selectCheckBox';

// Add a default value for a Core field
$GLOBALS['TCA']['pages']['columns']['hidden']['config']['default'] = 1;  // pages disabled by default
```

> [!NOTE]
> Override surgically — only the property you actually want to change. Replacing the entire `config` array of a Core field with your own is fragile: TYPO3 minor releases occasionally add new keys, and a wholesale replacement strips them silently. Setting one nested key (like the examples above) preserves everything else.

## Summary

Congratulations! You overrode two properties of a Core TCA field from your Site Package. The technique scales: any TCA property of any field on any table can be tweaked the same way, without forking TYPO3 or maintaining a custom Core build.

## Next steps

Now that you can override Core fields, you might like to:

* [Show a Field Conditionally with displayCond](ShowAFieldConditionallyWithDisplayCond.md)
* [Make a Field Required in TCA](MakeAFieldRequiredInTca.md)
* [Group Fields into a Tab in Page Properties](GroupFieldsIntoATabInPageProperties.md)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Pages table TCA reference](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Examples/Pages.html)
* [TCA columns properties](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Columns/Index.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
