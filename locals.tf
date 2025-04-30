locals {
  defaults_main_hash = md5(file("${path.module}/ansible/roles/elasticsearch/defaults/main.yml"))
  task_install_hash  = md5(file("${path.module}/ansible/roles/elasticsearch/tasks/1_install.yml"))
  disk_mount_hash    = md5(file("${path.module}/ansible/diskmount.yml"))
  config_template    = md5(file("${path.module}/ansible/elasticsearch.yml.j2"))
}
