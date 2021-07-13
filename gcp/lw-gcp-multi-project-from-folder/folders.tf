/*
data "google_projects" "folder-01" {
  filter = "parent.id:270355715444"
}



output "google_projects" {
  //value = { for project in data.google_projects.folder-01.projects: project.project_id }
  value = data.google_projects.folder-01.projects[*].project_id

}
*/
