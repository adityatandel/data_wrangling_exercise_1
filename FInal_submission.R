#View original dataset
View(refine_original)

#Separate product code and number
refine_original %>% separate("Product code / number", c("product_code", "product_number"), sep = "-")
refine_original <- refine_original %>% separate("Product code / number", c("product_code", "product_number"), sep = "-")

#Add full address for geocoding
refine_original <- unite(refine_original, "full_address", address, city, country, sep ",")

#Add product categories
refine_original %>% mutate(product_category = product_code)
refine_original <- refine_original %>% mutate(product_category = product_code)
refine_original$product_category <- gsub(pattern = "p", replacement = "Smartphone", x = refine_original$product_category)
refine_original$product_category <- gsub(pattern = "v", replacement = "TV", x = refine_original$product_category)
refine_original$product_category <- gsub(pattern = "x", replacement = "Laptop", x = refine_original$product_category)
refine_original$product_category <- gsub(pattern = "q", replacement = "Tablet", x = refine_original$product_category)

#Clean up brand names
refine_original$company <- gsub(pattern = "p.*\\ps$", replacement = "philips", x = refine_original$company)
refine_original$company <- gsub(pattern = "P.*\\ps$", replacement = "philips", x = refine_original$company)
refine_original$company <- gsub(pattern = "p.*\\pS$", replacement = "philips", x = refine_original$company)
refine_original$company <- gsub(pattern = "^A.*\\o$", replacement = "akzo", x = refine_original$company)
refine_original$company <- gsub(pattern = "^A.*\\o$", replacement = "akzo", x = refine_original$company)
refine_original$company <- gsub(pattern = "^A.*\\O$", replacement = "akzo", x = refine_original$company)
refine_original$company <- gsub(pattern = "^a.*\\O$", replacement = "akzo", x = refine_original$company)
gsub(pattern = "ak zo", replacement = "akzo", x = refine_original$company)
refine_original$company <- gsub(pattern = "ak zo", replacement = "akzo", x = refine_original$company)
refine_original$company <- gsub(pattern = "akzO", replacement = "akzo", x = refine_original$company)
refine_original$company <- gsub(pattern = "Van Houten", replacement = "van houten", x = refine_original$company)
refine_original$company <- gsub(pattern = "Unilever", replacement = "unilever", x = refine_original$company)
refine_original$company <- gsub(pattern = "akz0", replacement = "akzo", x = refine_original$company)
refine_original$company <- gsub(pattern = "fillips", replacement = "philips", x = refine_original$company)
refine_original$company <- gsub(pattern = "van Houten", replacement = "van houten", x = refine_original$company)
refine_original$company <- gsub(pattern = "unilver", replacement = "unilever", x = refine_original$company)

#Create dummy variables for company and product category
#first for companies
refine_original <- cbind(refine_original, dummy(refine_original$company, sep = "_"))
refine_original <- refine_original %>% rename(company_akzo = refine_original_akzo)
refine_original <- refine_original %>% rename(company_philips = refine_original_philips)
refine_original <- refine_original %>% rename(company_unilever = refine_original_unilever)
refine_original <- refine_original %>% rename(company_van_houten = `refine_original_van houten`)

#Next for product categories
refine_original <- cbind(refine_original, dummy(refine_original$product_category, sep = "_"))
refine_original <- refine_original %>% rename(product_laptop = refine_original_Laptop)
refine_original <- refine_original %>% rename(product_smartphone = refine_original_Smartphone)
refine_original <- refine_original %>% rename(product_tablet = refine_original_Tablet)
refine_original <- refine_original %>% rename(product_tv = refine_original_TV)

#Export cleaned up dataset to csv
write.csv(refine_original, "refine_original_tidied.csv")