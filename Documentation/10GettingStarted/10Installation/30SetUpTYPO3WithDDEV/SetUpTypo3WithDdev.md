# Set Up TYPO3 with DDEV

<!-- #TYPO3v13 #Beginner #Installation @philippefekete -->

DDEV enables you to quickly spin up a complete TYPO3 development environment without complex manual setup, providing a ready-to-use, containerized setup that mirrors a real server. Setting up TYPO3 with DDEV helps you start projects faster, ensure consistency across different machines, and streamline your development workflow by automating the configuration of PHP, the web server, and the database — all with just a few simple commands.

## Learning objective

In this step-by-step guide, you will learn to install and configure DDEV, create and run a TYPO3 project locally with Composer, and manage your development environment using essential DDEV commands.

## Prerequisites

### Tools and technology

* A computer with a command-line interface
* Docker installed on your machine as [explained in the Docker documentation](https://docs.docker.com/get-started/get-docker/).
* DDEV installed on your machine as [explained in the DDEV documentation](https://ddev.readthedocs.io/en/stable/users/install/ddev-installation/).

### Knowledge and skills

* How to use a command-line interface

## Watch the video

[Watch this video](https://www.youtube.com/watch?v=HW7J3G1SqZw) to follow along with the steps below.

## Create the installation directory

Create an empty directory for your TYPO3 project and change into it:

```
mkdir my_project
cd my_project
```

> [!Note]
> The directory where you run the following commands must be empty.
>
> Do not initialize Git or open the folder in an IDE before running the commands, as these may create files in the directory (for example hidden files).


## Create a New DDEV Project

1. Initialize a new DDEV project. The `ddev config` command will prompt you for details of your setup. TYPO3 is included in the list of preconfigured project types.

    ```
    ddev config --php-version 8.4 --docroot public --project-type typo3
    ```

* **Docroot Location** — The docroot is the folder containing the files accessible to the webserver, including the entry point `index.php`. It is commonly named public. Do not change the docroot during this installation process. You can change it later if necessary, however most guides assume your docroot is called `public`.
* **Project Type** — Always set the project type to `typo3`.


## Start the DDEV

1. Start the DDEV project:

   `ddev start`

The webserver environment is now running, but TYPO3 is not yet installed.

## Install TYPO3

1. Install TYPO3 using Composer:

   `ddev composer create "typo3/cms-base-distribution:^13"`

You now have a **Composer-based TYPO3 installation**.

## Directory structure after composer installation

At this point, your project folder should contain the following files and directories:

```
config/
packages/
public/
vendor/
LICENSE
.ddev
.gitignore
composer.json
composer.lock
README.md
```

Additional folders like `var` and subfolders like `config/sites` will be created during the setup process.

## Set up TYPO3 using the console

At this point, important files and folders are still missing, and your database does not yet contain any tables.

All of these will be created during the setup process.

1. To perform an interactive guided setup, run:

   `ddev typo3 setup --server-type=other --driver=mysqli --host=db --port=3306 --dbname=db --username=db --password=db`

2. When prompted, provide the following answers to match the default DDEV configuration:

    ```
    Admin username (user will be "system maintainer") ? j.doe
    Admin user and installer password ?
    Admin user email ? j.doe@example.org
    Give your project a name [default: New TYPO3 Project] ? My Project
    Create a basic site? Please enter a URL [default: no] https://my-project.ddev.site
    ✓ Congratulations - TYPO3 Setup is done.
    ```

## Summary

Congratulations! You now have a fully functional TYPO3 project running in a local DDEV environment, complete with a Composer-based installation, configured database, and ready-to-use development setup that mirrors a real-world server.

## Next steps

Now that you have a working TYPO3 project running locally with DDEV, you might like to:

* [Backend Basics](https://docs.typo3.org/m/typo3/guide-step-by-step/main/en-us/10GettingStarted/20BasicConfiguration/10BackendBasics/Index.html#backend-basics)

## Resources

* [Docker: Installation Guide](https://docs.docker.com/get-started/get-docker/)
* [DDEV: Get Started](https://ddev.com/get-started/)
* [DDEV: Installation](https://ddev.readthedocs.io/en/stable/users/install/ddev-installation/)
