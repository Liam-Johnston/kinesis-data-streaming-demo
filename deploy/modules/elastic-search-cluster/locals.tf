locals {
  master_user_name = "admin"
  my_ip            = chomp(data.http.myip.body)
}
