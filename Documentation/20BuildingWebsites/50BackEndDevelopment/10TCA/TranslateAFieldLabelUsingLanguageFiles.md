# Translate a Field Label Using Language Files

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

Hardcoding the label `'Teaser text'` in TCA works fine for an English-only backend, but the moment editors switch their backend interface to German, French, or Romanian, all your custom labels stay stubbornly in English. TYPO3 solves this with **language files** — XLIFF documents that map a translation key to its source text and target translations. You reference the key from TCA with the `LLL:` prefix, and TYPO3 resolves it to the right language at request time.

## Learning objective

In this step-by-step guide you will replace the hardcoded label of `tx_my_site_package_teaser` with a translation key, define an English source string, and add a Romanian translation that appears when an editor switches their backend language to Romanian.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* A custom text field on the `pages` table, as described in [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md)
* A code editor

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)
* Familiarity with XML syntax helps, but is not required

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key.

## Create the English language file

Language files live under `Resources/Private/Language/`. The default file (no language prefix) holds the English source strings.

1. Inside your Site Package, create the folder `packages/my_site_package/Resources/Private/Language/` if it does not exist yet.
2. Create a new file at `packages/my_site_package/Resources/Private/Language/locallang_db.xlf`.
3. Paste the following content:

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <xliff version="1.0">
        <file source-language="en"
              datatype="plaintext"
              original="messages"
              date="2026-01-01T00:00:00Z"
              product-name="my_site_package">
            <header/>
            <body>
                <trans-unit id="pages.tx_my_site_package_teaser">
                    <source>Teaser text</source>
                </trans-unit>
            </body>
        </file>
    </xliff>
    ```

4. Save the file.

The `id` attribute (`pages.tx_my_site_package_teaser`) is the translation key. The convention is `<table>.<columnName>` for column labels, but any unique string works. The `<source>` element holds the English text.

> [!TIP]
> Use `locallang_db.xlf` for backend / TCA labels (database-related). Use `locallang.xlf` for general-purpose strings used in Fluid templates and frontend output. Splitting them keeps backend translations from bleeding into the frontend `xlf` file.

## Reference the translation key from TCA

Now update TCA to point at the language file instead of using a hardcoded string.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Find the `tx_my_site_package_teaser` definition.
3. Replace the hardcoded `label` with the `LLL:` reference:

    ```php
    'tx_my_site_package_teaser' => [
        'exclude' => true,
        'label' => 'LLL:EXT:my_site_package/Resources/Private/Language/locallang_db.xlf:pages.tx_my_site_package_teaser',
        'config' => [
            'type' => 'input',
            'size' => 50,
            'max' => 255,
            'eval' => 'trim',
        ],
    ],
    ```

4. Save the file.

The `LLL:` syntax is `LLL:<extension-relative path>:<translation-key>`. TYPO3 reads the file, finds the matching `<trans-unit>`, and uses its `<source>` (or `<target>`, when a translation exists for the active backend language).

## Add the Romanian translation

For each additional language, create a sibling file with the language prefix.

1. Create a new file at `packages/my_site_package/Resources/Private/Language/ro.locallang_db.xlf`.
2. Paste the following content:

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <xliff version="1.0">
        <file source-language="en"
              target-language="ro"
              datatype="plaintext"
              original="messages"
              date="2026-01-01T00:00:00Z"
              product-name="my_site_package">
            <header/>
            <body>
                <trans-unit id="pages.tx_my_site_package_teaser" approved="yes">
                    <source>Teaser text</source>
                    <target>Text teaser</target>
                </trans-unit>
            </body>
        </file>
    </xliff>
    ```

3. Save the file.

The naming convention is `<language>.locallang_db.xlf`. The two-letter language code matches TYPO3's locale codes — `ro` for Romanian, `de` for German, `fr` for French, `it` for Italian. Each `<trans-unit>` mirrors the source file, with the addition of a `<target>` element holding the translation.

> [!IMPORTANT]
> Keep the `id` exactly the same as in the source file. TYPO3 matches translations by `id`, not by `<source>` text. Translating the source string but leaving the `id` unchanged is the correct pattern; changing the `id` orphans the translation.

## Verify the translated label

Finally, switch the backend language and confirm the label changes.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Click your username in the top right corner and choose **User settings** (or open `https://<your-domain>/typo3/user/setup`).
4. In the **Language** dropdown, select **Romanian** and save.
5. Reload the page if needed.
6. Open the page properties of any page.

The field that previously read **Teaser text** should now read **Text teaser**.

> [!TIP]
> If the label still appears in English even after switching the backend language, check:
>
> * That the file path in the `LLL:` reference matches the actual file location exactly (case-sensitive on Linux).
> * That you cleared the TYPO3 caches.
> * That the Romanian language pack is installed (Admin Tools > Maintenance > Language Packs).
> * That the `<trans-unit id="...">` in the translation file matches the source file's `id`.

## Summary

Congratulations! You replaced a hardcoded TCA label with a translation key, defined an English source, and added a Romanian translation. The same pattern scales to as many languages as you need: add one `<lang>.locallang_db.xlf` file per language, all referencing the same `id`s as the source file.

## Next steps

Now that you can translate field labels, you might like to:

* [Override a Default TCA Field](OverrideADefaultTcaField.md)
* [Group Fields into a Tab in Page Properties](GroupFieldsIntoATabInPageProperties.md) — tab labels can also be translated with `LLL:` references
* Translate the labels of dropdown items (covered as an extension of the [Add a Dropdown Field to a Page Record](AddADropdownFieldToAPageRecord.md) pattern)

## Resources

* [Internationalization in TYPO3](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/Internationalization/Index.html)
* [XLIFF format reference](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/Internationalization/Translation.html)
* [Available language packs](https://typo3.org/help/document/translation-and-language-packs)
