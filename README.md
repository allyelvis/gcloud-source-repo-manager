# gcloud-source-repo-manager

This bash script provides an interactive way to manage Google Cloud Source Repositories. It allows you to list available projects, select a project, list repositories within that project, and execute various tasks on those repositories (e.g., cloning, listing commits).

## Features

* Lists available Google Cloud projects.
* Allows the user to select a project.
* Lists repositories within the selected project.
* Allows the user to select a repository.
* Supports extensible tasks (currently includes `clone` and `list-commits`).
* Input validation for project and repository choices.
* Basic error handling for `gcloud` commands and tasks.
* More robust repository cloning, including checking for existing clones and offering to pull updates.
* Uses `gcloud` to generate clone URLs.

## Prerequisites

* [gcloud CLI](https://cloud.google.com/sdk/docs/install) installed and configured.  Make sure you have authenticated with `gcloud auth login` and set a default project (if desired) with `gcloud config set project YOUR_PROJECT_ID`.
* [git](https://git-scm.com/) installed (required for the `clone` task).

## Installation

1. Clone the repository:

   ```bash
   git clone [https://github.com/YOUR_USERNAME/gcloud-source-repo-manager.git](https://www.google.com/search?q=https://github.com/YOUR_USERNAME/gcloud-source-repo-manager.git)  # Replace with your repo URL
   cd gcloud-source-repo-manager

