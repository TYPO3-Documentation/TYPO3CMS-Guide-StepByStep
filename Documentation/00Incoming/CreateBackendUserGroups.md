# Create backend user groups in TYPO3

<!-- #TYPO3v14 #Beginner #Backend #Configuration #Editing @dhubert974 -->

Backend user groups in TYPO3 help administrators manage permissions and access rights for editors and backend users. Instead of assigning permissions individually to each user, groups allow you to define reusable access rules.

## Learning objective

In this step-by-step guide, you will learn how to create backend user groups and configure permissions for backend users in TYPO3.

## Prerequisites

### Tools and technology

* Access to a TYPO3 v14 backend
* Administrator privileges or permission to manage backend users and groups

### Knowledge and skills

* Basic familiarity with navigating the TYPO3 backend
* Understanding of TYPO3 users and permissions

## Explore the Users module

Backend user groups define shared permissions that can be assigned to multiple backend users.

1. Open the **Administration > Users** module.

![The TYPO3 module menu with the Users module highlighted under Administration](Images/CreateBackendUserGroups/administration-module.png)

You will be redirected to the **Users** page, which lists all backend users of the site.

In the **doc header** section:

1. You'll find a drop-down menu with submodules
2. An option to create a new backend user
3. An option to create a new administrator

![The doc header of the Users page, with the submodule drop-down, "Create editor" and "Create admin" buttons numbered 1 to 3](Images/CreateBackendUserGroups/users-page-doc-header.png)

You will also find a search section with filters:

4. A field for searching for a user by their username
5. Filter by **type**: All, Admin or normal user
6. Filter by **status**: All, Enable or Disabled
7. Filter by **login state**: All, Logged in before, Never logged in, Currently logged in
8. Filter by **group**: All the groups you will create

![The search section of the Users page, with the username field and the Type, Status, Login state and Group filters numbered 4 to 8](Images/CreateBackendUserGroups/users-page-search-filters.png)

Finally, you'll see every user in the backend, with options:

9. Username and an indicator showing whether a user is online
10. Edit a user profile, enable or disable a user, or delete a user
11. Reset password (key icon), view user details, and access additional information such as the creation date, last modification date, creator, general summary, and assigned backend user groups.

![The user list on the Users page, with the username column and the row action buttons numbered 9 to 12](Images/CreateBackendUserGroups/users-page-content-setting.png)

## Create backend user groups

Now, we will create new backend user groups.

1. Select sub-module: **Backend user groups**

![The submodule drop-down on the Users page opened, with "Backend user groups" highlighted](Images/CreateBackendUserGroups/users-page-select-submodule.png)

The Users page features similar elements: a group search filter, an edit button, options to enable, disable, or delete a group, and a details/information and compare button.

2. In the **doc header**, click **Create new backend user group**.

![The Backend user groups page with the "Create new backend user group" button highlighted](Images/CreateBackendUserGroups/create-backend-user-group.png)

There are seven tabs available. In this guide, we will focus on the following tabs: **General**, **Record Permissions**, **Module Permissions**, and **Mounts**. The remaining tabs are:

* **Options**: Add group-specific TSConfig settings
* **Access**: Enable or disable the group
* **Notes**: Add notes about the group

![The "Create new Backend usergroup" form showing the seven tabs: General, Record Permissions, Module Permissions, Mounts, Options, Access and Notes](Images/CreateBackendUserGroups/create-new-backend-usergroup.png)

### General tab

1. You must name the group (required field).
2. This group will inherit permissions from the parent group.
3. You have two options for multi-factor authentication.

![The General tab with the Title field, "Inherit settings from groups" and Authentication sections numbered 1 to 3](Images/CreateBackendUserGroups/general-tabs.png)

### Record permissions tab

#### Table permissions

This section allows you to set general backend permissions, such as **no access**, **read**, or **read and write** for various items.

![The Table permissions section of the Record Permissions tab](Images/CreateBackendUserGroups/record-permissions-table.png)

#### Allowed fields

This section allows you to grant access to specific fields for items enabled in the **Table permissions** section.

![The Allowed fields section of the Record Permissions tab](Images/CreateBackendUserGroups/record-permissions-allowed-fields.png)

#### Specific permissions

**Allowed page types:** Allows you to grant access to specific page types depending on the group's role.

Example:

The **Publisher** group may only have access to standard pages, shortcuts, and links, while a more advanced **Editor** group may also access folders and menu separators.

**Explicitly allow field values:** Allows access to specific content element types. For example, some groups may not require access to **HTML content elements**.

![The Specific permissions section of the Record Permissions tab, showing allowed page types and explicitly allowed field values](Images/CreateBackendUserGroups/record-permissions-specific-permissions.png)

#### Language permissions

If your website is available in multiple languages, you can grant a group access to specific languages.

![The Language permissions section of the Record Permissions tab](Images/CreateBackendUserGroups/record-permissions-languages.png)

### Module permissions tab

This section grants access to TYPO3 backend modules, such as **Content > Layout**, **Content > Records**, or the **Media** module.

![The Module Permissions tab showing the list of allowed backend modules](Images/CreateBackendUserGroups/module-permissions-allowed-modules.png)

The rest of this section provides access to widgets such as RSS feeds, TYPO3 news, bookmarks, and more.

![The Module Permissions tab showing the list of allowed dashboard widgets](Images/CreateBackendUserGroups/module-permissions-allowed-dashboard-widgets.png)

### Mounts tab

#### Page tree entry points

You can choose which pages the group will have access to in the page tree.

Example:

The **Publisher HR (Human Resources)** group might have access only to the **Careers** section to manage job postings and recruitment content, while the **Publisher Communications** group could have access to the **News** and **Events** pages to publish announcements and updates.

![The Mounts tab with a page added to the Page Tree Entry Points list](Images/CreateBackendUserGroups/mounts-page-tree-entry-points.png)

#### Fileoperation permissions

You can grant access to specific folders in the **Media module**. This allows users to upload, edit, and manage files only in designated locations.

Example:

The **Publisher HR** group may only have access to the **/media/hr/** folder for recruitment documents and employee-related images, while the **Publisher Communications** group could manage files in **/media/news/** and **/media/events/** for announcements and promotional content.

![The Mounts tab showing the Page Tree Entry Points and Fileoperation permissions sections with Directory and Files options](Images/CreateBackendUserGroups/mounts.png)

## Summary

Congratulations! You now know how to create backend user groups in TYPO3 and assign permissions to backend users.

## Next steps

Now that you have created backend user groups, you might like to:

* Create backend users

## Resources

* [TYPO3 backend user management documentation](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/Administration/UserManagement/Index.html)
* [TYPO3 permissions documentation](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/Fal/Administration/Permissions.html)
