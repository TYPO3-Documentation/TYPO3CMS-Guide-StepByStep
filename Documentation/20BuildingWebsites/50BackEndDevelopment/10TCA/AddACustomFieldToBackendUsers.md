# Add a Custom Field to Backend Users

<!-- #TYPO3v13 #Intermediary #Backend #Configuration #SitePackage @dragos_tuluc -->

Beyond the data on pages and content elements, sometimes you need to attach extra information to your backend users themselves — a phone number for the on-call editor, a job title, a department code, an internal employee ID. Backend users live in the `be_users` table, and they take TCA the same way `pages` and `tt_content` do. The pattern is identical; only the table name and override file change.

## Learning objective

In this step-by-step guide you will add one custom phone number field to the TYPO3 `be_users` record and make it editable in the backend user management module.

## Prerequisites

### Tools and technology

* A Composer-based TYPO3 installation
* A Site Package created and installed as described in [Create the Site Package File Structure](CreateTheSitePackageFileStructure.md) and [Register and Install a Site Package](RegisterAndInstallSitePackage.md)
* Access to the file system of your TYPO3 project
* A code editor
* An admin TYPO3 backend account (regular editors cannot edit `be_users` records)

### Knowledge and skills

* Basic knowledge of working with files in a Site Package
* You have completed [Add a Text Field to a Page Record](AddATextFieldToAPageRecord.md) — the pattern is the same, only the table changes
* You know how to [Log in to the TYPO3 Backend](LogInToTheTypo3Backend.md)

> [!NOTE]
> In the examples below, replace `my_site_package` with your own extension key.
>
> Replace `tx_my_site_package_phone_number` with your own custom field name. Custom fields on Core tables usually start with the prefix `tx_`.

> [!IMPORTANT]
> Backend user records contain sensitive data, so the **Backend Users** module is admin-only. Editors and regular backend users will not see your new field at all — only admins do. Plan accordingly: store admin-facing metadata here, not data that other users need to read or edit.

## Add the database column

First, let's define the new field on the `be_users` table.

1. Open the file `packages/my_site_package/ext_tables.sql`.
2. If the file does not exist yet, create it.
3. Add the following SQL definition (alongside any existing `CREATE TABLE` blocks for other tables):

    ```sql
    CREATE TABLE be_users (
        tx_my_site_package_phone_number varchar(50) DEFAULT '' NOT NULL
    );
    ```

4. Save the file.

The new field is now part of your extension's database definition for backend users.

> [!NOTE]
> If your `ext_tables.sql` already contains a `CREATE TABLE be_users (...)` block from another guide, you can either add a second block (TYPO3 merges them at install time) or add the new column inside the existing block. Both work.

## Register the field in TCA

TCA overrides for `be_users` go in their own override file.

1. Create the file `packages/my_site_package/Configuration/TCA/Overrides/be_users.php`.
2. Add the following code:

    ```php
    <?php

    declare(strict_types=1);

    defined('TYPO3') or die();

    use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

    ExtensionManagementUtility::addTCAcolumns(
        'be_users',
        [
            'tx_my_site_package_phone_number' => [
                'label' => 'Phone number',
                'config' => [
                    'type' => 'input',
                    'size' => 30,
                    'max' => 50,
                    'eval' => 'trim',
                ],
            ],
        ]
    );

    ExtensionManagementUtility::addToAllTCAtypes(
        'be_users',
        'tx_my_site_package_phone_number',
        '',
        'after:email',
    );
    ```

3. Save the file.

> [!NOTE]
> The `'exclude' => true` flag is omitted here because the entire **Backend Users** module is already admin-only — there is no non-admin role that could see backend user records. Adding `exclude` would be redundant.

## Apply the database change and verify the result

Finally, flush the caches, apply the schema change, and check the new field in the backend.

1. [Log in to the TYPO3 backend](LogInToTheTypo3Backend.md) as an admin user.
2. Open **Admin Tools > Maintenance**.
3. In **Flush TYPO3 and PHP Cache**, click **Flush cache**.
4. In **Analyze Database Structure**, apply the suggested change for `tx_my_site_package_phone_number`.
5. From the module menu, open **System > Backend Users**.
6. Click on any backend user to edit it.
7. Verify that the new field **Phone number** appears below the **Email** field.
8. Enter a phone number and save.

After saving, reopen the user record — the value should still be there.

> [!TIP]
> The same approach works for the `fe_users` table — TYPO3's frontend users. Just create `Configuration/TCA/Overrides/fe_users.php` and a matching `CREATE TABLE fe_users (...)` block in `ext_tables.sql`. Frontend user fields are useful for member-area sites where each visitor account needs custom profile data.

## Summary

Congratulations! You added one custom field to a TYPO3 backend user record. You have now seen the TCA-extension pattern applied to three different tables — `pages`, `tt_content`, and `be_users` — and confirmed that the configuration approach is identical regardless of which table you extend.

## Next steps

Now that you can extend backend users, you might like to:

* [Make a Field Required in TCA](MakeAFieldRequiredInTca.md)
* [Group Fields into a Tab in Page Properties](GroupFieldsIntoATabInPageProperties.md) — same pattern works for be_users
* [Group Fields into a Palette in Page Properties](GroupFieldsIntoAPaletteInPageProperties.md)

## Resources

* [TCA introduction](https://docs.typo3.org/permalink/t3tca:start)
* [be_users table reference](https://docs.typo3.org/m/typo3/reference-tca/main/en-us/Examples/BeUsers.html)
* [Customization Examples](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/HowTo/ExtendingTca/Examples/Index.html)
* [ext_tables.sql](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/FileStructure/ExtTablesSql.html)
