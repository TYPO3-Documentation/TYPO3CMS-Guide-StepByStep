# Render Inline Child Records in the Frontend

<!-- #TYPO3v13 #Intermediary #Frontend #Templating #SitePackage @dragos_tuluc -->

Inline child records — like the `tx_my_site_package_download` records you set up in the previous guides — exist in the database, but they don't appear in the frontend on their own. To display them, you fetch them in TypoScript with a data processor and iterate over the result in your Fluid template. The `DatabaseQueryProcessor` is TYPO3's general-purpose tool for this: configure a SQL filter, give the result a name, and use it like any other Fluid variable.

This guide is the third in a three-part series:

1. [Create a Custom Table for Child Records](CreateACustomTableForChildRecords.md)
2. [Add an Inline Field That Manages Child Records](AddAnInlineFieldThatManagesChildRecords.md)
3. **Render Inline Child Records in the Frontend** — *this guide*

## Learning objective

In this step-by-step guide you will fetch every `tx_my_site_package_download` record that belongs to the current page, expose it in Fluid as `{downloads}`, and render the list as a `<ul>` with each download's title and description.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 v13 installation
* A Site Package with a working Fluid page template, as described in [Render a Custom Page Field in a Fluid Template](RenderACustomPageFieldInAFluidTemplate.md)
* You have completed [Add an Inline Field That Manages Child Records](AddAnInlineFieldThatManagesChildRecords.md)
* A page in the page tree with at least one download record attached

### Knowledge and skills

* Basic understanding of HTML
* Familiarity with Fluid ViewHelpers
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key, and `tx_my_site_package_download` / `tx_my_site_package_downloads` with the table and field names you used.

## Configure the DatabaseQueryProcessor

Let's tell TYPO3 to fetch all download records that belong to the current page.

1. Open the file `packages/my_site_package/Configuration/Sets/SitePackage/setup.typoscript`.
2. Inside the existing `page.10 = FLUIDTEMPLATE` block, extend the `dataProcessing` section:

    ```typoscript
    page.10 {
        dataProcessing {
            40 = TYPO3\CMS\Frontend\DataProcessing\DatabaseQueryProcessor
            40 {
                table = tx_my_site_package_download
                pidInList.field = uid
                where.dataWrap = parent_uid = {field:uid} AND parent_table = "pages"
                orderBy = sorting
                as = downloads
            }
        }
    }
    ```

3. Save the file.

This configuration:

* `table` — the child table to query.
* `pidInList.field = uid` — inline children of a *page* are stored with their `pid` set to the **page's own uid** (TYPO3 treats the page itself as the storage location, the same way it stores content elements). Reading the current page's `uid` attribute points the pid filter at exactly that location.
* `where.dataWrap` — the SQL filter, with `{field:uid}` substituting the current page's uid at runtime. The result is `parent_uid = 4 AND parent_table = "pages"` for a request to page uid 4.
* `orderBy = sorting` — match the editor's drag-and-drop sort order from the inline field.
* `as = downloads` — the variable name in Fluid.

> [!IMPORTANT]
> The `pidInList.field = uid` line is essential. When the parent record is a page, TYPO3 stores the child records with `pid` = the page's **uid** — not the page's own `pid`. Filtering on the wrong column returns zero records, which is the most common cause of "the data is in the database but the frontend shows nothing" with `DatabaseQueryProcessor` and IRRE.

> [!NOTE]
> The numeric key `40` is just the data processor's order. Use whatever number is free in your `dataProcessing` block — `10`, `20`, and `30` may already be taken by `FilesProcessor` / `MenuProcessor` from earlier guides. Pick the next free integer.

## Render the downloads in the template

Now let's open the page template and add a block that iterates over the fetched records.

1. Open the file `packages/my_site_package/Resources/Private/Templates/Page/Default.html`.
2. Inside the `<body>`, below the existing content, add the following block:

    ```html
    <f:if condition="{downloads}">
        <section class="downloads">
            <h2>Downloads</h2>
            <ul>
                <f:for each="{downloads}" as="download">
                    <li>
                        <strong>{download.data.title}</strong>
                        <f:if condition="{download.data.description}">
                            <p>{download.data.description}</p>
                        </f:if>
                    </li>
                </f:for>
            </ul>
        </section>
    </f:if>
    ```

3. Save the file.

The template renders a `<section>` with a heading and an unordered list, with one `<li>` per download. The description is shown only when it has a value.

> [!IMPORTANT]
> Inside the `<f:for>` loop, the child record's columns are nested under the `data` key — access them as `{download.data.title}`, `{download.data.description}`, `{download.data.uid}`, etc. `DatabaseQueryProcessor` wraps each result row inside the cObject's standard structure, so the raw columns live one level deeper than you might expect. Accessing `{download.title}` directly returns an empty string and is the second most common cause of "iteration runs three times but every entry is blank".

## Verify the result in the frontend

Finally, clear the caches and check the frontend.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Click the **Clear all caches** lightning bolt icon in the top toolbar.
3. Open the page properties of a page where you added one or more downloads.
4. Confirm the downloads are still attached, then save the page.
5. Visit the same page in your browser's frontend.

You should see a `<section class="downloads">` with the heading "Downloads" and one `<li>` per download record, in the order you set them in the backend.

> [!TIP]
> If the downloads do not appear, check:
>
> * That the **Title** field on each download has a value (the SQL `where` clause is not strict, but our Fluid `<f:if>` is).
> * That the values of `parent_uid` and `parent_table` on the child records match what your `where.dataWrap` filter expects (look in the database directly via phpMyAdmin or `SELECT * FROM tx_my_site_package_download`).
> * That you cleared the TYPO3 caches after both the TypoScript and template changes.
> * That the data processor key (`40` in the example) doesn't conflict with another processor on the same number.

## Render the file attached to each download

Each download has a `file` field (count of attached files), but the actual file reference must be fetched separately. Add a second `FilesProcessor` *inside* the iteration to expose each download's file. Replace the previous template block with:

```html
<f:if condition="{downloads}">
    <section class="downloads">
        <h2>Downloads</h2>
        <ul>
            <f:for each="{downloads}" as="download">
                <li>
                    <strong>{download.data.title}</strong>
                    <f:if condition="{download.data.description}">
                        <p>{download.data.description}</p>
                    </f:if>
                    <!-- The download.data.file column stores the count of file references;
                         the actual file objects must be fetched separately. For nested file
                         references, the cleanest approach is to use the FILES content
                         object inside the loop. -->
                </li>
            </f:for>
        </ul>
    </section>
</f:if>
```

> [!NOTE]
> Rendering files attached to inline child records is a slightly more advanced topic (you need a nested cObject or a custom dataProcessor that resolves files for each child). It is intentionally out of scope for this guide. For a beginner-friendly start, keep title and description on each download, and link to a separate file manager later.

## Summary

Congratulations! You closed the loop on inline relations: editors create downloads in the backend, the frontend fetches them via `DatabaseQueryProcessor`, and Fluid renders them as a clean list. The same pattern works for any inline child table — FAQ items, team members, speakers, gallery slides — just change the table name and the iterated columns.

## Next steps

Now that you can render inline relations, you might like to:

* [Format a Date Value in the Frontend](FormatADateValueInTheFrontend.md)
* [Display an Image from a File Reference Field](DisplayAnImageFromAFileReferenceField.md)
* [Show a Custom Field Only When It Has a Value](ShowACustomFieldOnlyWhenItHasAValue.md)

## Resources

* [`DatabaseQueryProcessor` reference](https://docs.typo3.org/m/typo3/reference-typoscript/main/en-us/ContentObjects/Fluidtemplate/Dataprocessing/DatabaseQueryProcessor.html)
* [`<f:for>` ViewHelper](https://docs.typo3.org/other/typo3/view-helper-reference/main/en-us/typo3/fluid/latest/For.html)
* [Fluid templating engine](https://docs.typo3.org/permalink/t3coreapi:fluid)
