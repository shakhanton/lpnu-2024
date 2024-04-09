######

output "module_bucket_id" {
    value = module.s3.bucket_id
}

output "module_bucket_best_ever_arn" {
    value = module.s3.my_best_arn
}

output "module_bucket_domain_name" {
    value = module.s3.bucket_domain_name
}

output "module_bucket_regional_domain_name" {
    value = module.s3.bucket_regional_domain_name
}

###

output "courses_table_name" {
    value = module.table_courses.id
}

output "courses_table_arn" {
    value = module.table_courses.arn
}

output "authors_table_name" {
    value = module.table_authors.id
}

output "authors_table_arn" {
    value = module.table_authors.arn
}
