#!/bin/bash

# Function to list gcloud projects
list_projects() {
  gcloud projects list --format="value(projectId)"
}

# Function to list repositories in a project
list_repos() {
  project_id="$1"
  echo "Repositories in project: $project_id"
  gcloud source repos list --project="$project_id" --format="value(name)"
}

# Function to execute a task (example: clone a repo)
execute_task() {
  project_id="$1"
  repo_name="$2"
  task="$3"

  case "$task" in
    "clone")
      repo_url="https://source.developers.google.com/p/$project_id/r/$repo_name"  # Construct the clone URL. Adapt if needed.
      echo "Cloning $repo_url..."
      git clone "$repo_url"
      ;;
    "list-commits") # Example task: list commits
      echo "Listing commits for $repo_name in $project_id..."
      gcloud source repos list-commits "$repo_name" --project="$project_id"
      ;;
    *)
      echo "Unknown task: $task"
      ;;
  esac
}


# Main script execution

echo "Available gcloud projects:"
projects=$(list_projects)

# Check if any projects were found
if [[ -z "$projects" ]]; then
  echo "No gcloud projects found.  Exiting."
  exit 1
fi


# Display projects with numbers for user selection
i=1
project_array=() # Array to store project IDs
for project in $projects; do
  echo "$i. $project"
  project_array+=("$project")
  i=$((i + 1))
done

# Get user project choice
read -p "Enter the number of the project to explore: " project_choice

# Validate project choice
if [[ ! "$project_choice" =~ ^[0-9]+$ ]] || [[ "$project_choice" -gt ${#project_array[@]} ]] || [[ "$project_choice" -lt 1 ]]; then
  echo "Invalid project choice. Exiting."
  exit 1
fi

chosen_project="${project_array[$((project_choice - 1))]}"


echo "" # Add a newline for better readability

# List repos in the chosen project
repos=$(list_repos "$chosen_project")

# Check if any repos were found
if [[ -z "$repos" ]]; then
  echo "No repositories found in project $chosen_project."
  exit 0  # Or exit 1 if you want to indicate an error
fi

# Display repos with numbers for user selection
j=1
repo_array=() # Array to store repo names
for repo in $repos; do
  echo "  $j. $repo"
  repo_array+=("$repo")
  j=$((j + 1))
done

# Get user repo choice
read -p "Enter the number of the repository to work with: " repo_choice

# Validate repo choice
if [[ ! "$repo_choice" =~ ^[0-9]+$ ]] || [[ "$repo_choice" -gt ${#repo_array[@]} ]] || [[ "$repo_choice" -lt 1 ]]; then
  echo "Invalid repository choice. Exiting."
  exit 1
fi

chosen_repo="${repo_array[$((repo_choice - 1))]}"


# Get task choice
echo ""
echo "Available tasks:"
echo "1. clone"
echo "2. list-commits"  # Add more tasks as needed
read -p "Enter the number of the task to execute: " task_choice

# Validate task choice (add more as you add tasks)
case "$task_choice" in
  1) task="clone"; ;;
  2) task="list-commits"; ;;
  *) echo "Invalid task choice. Exiting."; exit 1 ;;
esac

# Execute the chosen task
execute_task "$chosen_project" "$chosen_repo" "$task"

echo "Task completed."

exit 0