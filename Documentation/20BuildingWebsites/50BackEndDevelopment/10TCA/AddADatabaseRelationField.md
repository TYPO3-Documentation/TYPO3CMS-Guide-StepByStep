# Add a Database Relation Field

<!-- #TYPO3v13 #Beginner #Backend #Configuration #SitePackage @dragos_tuluc -->

Some pages need to be linked to a single record in another table — a "responsible editor" linked to a backend user, a "primary product" linked to a product record, an "owner team" linked to a department. TCA's `select` field with a `foreign_table` reference renders a dropdown populated from another database table, so editors pick from real records instead of typing free text.

## Learning objective

In this step-by-step guide you will add one database relation field to the TYPO3 `pages` record that lets editors pick a "responsible editor" from the list of backend users (`be_users`).

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* At least two backend users in the system
* A code editor

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You have completed [Add a Dropdown Field to a Page Record](AddADropdownFieldToAPageRecord.md) — this is a more powerful variant of the same `type: select` family
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key.
>
> Replace `tx_my_site_package_responsible_user` with your own custom field name.

## Add the database column

First, let's define the new field. A single-record relation stores the foreign record's UID as an integer.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. Add the following SQL definition (alongside any existing `CREATE TABLE pages` block):

    ```sql
    CREATE TABLE pages (
        tx_my_site_package_responsible_user int(11) DEFAULT '0' NOT NULL
    );
    ```

3. Save the file.

The new field is now part of your extension's database definition.

## Register the field in TCA

Next, register the field as a select dropdown populated from `be_users`.

1. Open the file `packages/my_site_package/Configuration/TCA/Overrides/pages.php`.
2. Below the existing TCA columns, add the following code:

    ```php
    ExtensionManagementUtility::addTCAcolumns(
        'pages',
        [
            'tx_my_site_package_responsible_user' => [
                'exclude' => true,
                'label' => 'Responsible editor',
                'config' => [
                    'type' => 'select',
                    'renderType' => 'selectSingle',                                          // single-choice dropdown
                    'foreign_table' => 'be_users',                                           // pull options from be_users
                    'foreign_table_where' => 'AND be_users.disable = 0 ORDER BY be_users.username',
                    'items' => [
                        ['label' => '— none —', 'value' => 0],                              // explicit "no selection"
                    ],
                    'minitems' => 0,
                    'maxitems' => 1,
                ],
            ],
        ]
    );
    ```

3. Save the file.

The dropdown will now list every active backend user, ordered alphabetically by username, with a leading "— none —" option for editors who don't want to pick anyone.

> [!TIP]
> The `foreign_table_where` SQL clause is appended to TYPO3's automatic query (with the leading `AND`). Use it to filter and order the records:
>
> * `AND be_users.disable = 0` — only enabled users
> * `AND be_users.usergroup IN (3,4)` — only users in specific groups (use UIDs)
> * `ORDER BY be_users.realName` — sort by full name instead of username

## Place the field in page properties

Now we'll add the field to the page form so editors can see and use it.

1. In the same file, below the previous code, add:

    ```php
    ExtensionManagementUtility::addToAllTCAtypes(
        'pages',
        'tx_my_site_package_responsible_user',
        '',
        'after:title',
    );
    ```

2. Save the file.

## Apply the database change and verify the result

Finally, flush caches, apply the schema, and check the new field.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md).
2. Open **Admin Tools > Maintenance**.
3. In **Flush TYPO3 and PHP Cache**, click **Flush cache**.
4. In **Analyze Database Structure**, apply the suggested change for `tx_my_site_package_responsible_user`.
5. Open the page properties of any page.
6. Verify that the new field **Responsible editor** appears below the **Page title** field as a dropdown.
7. Open the dropdown — you should see "— none —" plus every active backend user.
8. Pick a user and save the page.

After saving, reopen the page properties — the picked user should still be selected.

## Allow multiple selections

To let editors pick more than one related record (for example, an "editorial team" rather than a single person), change the `renderType` and increase `maxitems`:

```php
'config' => [
    'type' => 'select',
    'renderType' => 'selectMultipleSideBySide',     // two-column picker: available / selected
    'foreign_table' => 'be_users',
    'foreign_table_where' => 'AND be_users.disable = 0 ORDER BY be_users.username',
    'maxitems' => 5,
],
```

`selectMultipleSideBySide` renders the field as two side-by-side lists where the editor moves users between "available" and "selected". The picked UIDs are stored as a comma-separated string in the column — TYPO3 reads and writes the format automatically.

> [!IMPORTANT]
> A comma-separated string no longer fits the `int(11)` column defined at the beginning of this guide — MySQL would truncate `3,4,5` to `3` (or reject it in strict mode), so only one selection would survive saving. For the multi-select variant, change the column definition in `ext_tables.sql` to hold a string:
>
> ```sql
> CREATE TABLE pages (
>     tx_my_site_package_responsible_user varchar(255) DEFAULT '' NOT NULL
> );
> ```
>
> Then apply the change with **Analyze Database Structure**. (For large relation sets, an `MM` intermediate table is the more scalable alternative.)

> [!NOTE]
> `type: group` is an alternative for relations that span multiple foreign tables (`'allowed' => 'be_users,fe_users'`) or that need a different UI. For most cases — relations to a single foreign table — `select` with `foreign_table` is simpler and more flexible. Use `group` only when `select` is not enough.

## Summary

Congratulations! You added a database relation field that pulls its options from another TYPO3 table. Editors now pick from real records instead of free-text strings, so the stored value is always a real record UID.

## Next steps

Now that you can relate records, you might like to:

* [Add a Category Field with sys_category](AddACategoryFieldWithSysCategory.md) for relations through a central taxonomy
* [Create a Custom Table for Child Records](CreateACustomTableForChildRecords.md) when you need new records that belong to a parent
* [Show a Field Conditionally with displayCond](ShowAFieldConditionallyWithDisplayCond.md)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [Select fields in TCA](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Select/Index.html)
* [`foreign_table` reference](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/ColumnsConfig/Type/Select/Properties/ForeignTable.html)
* [be_users table reference](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Examples/BeUsers.html)
