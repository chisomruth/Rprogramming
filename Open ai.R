remotes::install_github("irudnyts/openai")
install.packages(glue)
#reticulate::py_config()

library(openai)
library( httr)
library(stringr)
library(glue)
library(tidyverse)
library(data.table)
#library(fuzzywuzzyR)


#api key
api_key = "sk-proj-hbQB47oQbkrnP0ZN4oLYT3BlbkFJx##############

african_names = read.csv("C:/Users/Open User/Downloads/african_names.csv")
names(african_names)
head(african_names)
glimpse(african_names)
tail(african_names)

ask_chatgpt = function(prompt){
  response = POST(
    url = 'https://api.openai.com/v1/chat/completions',
    add_headers(Authorization = paste('Bearer', api_key)),
    content_type_json(),
    encode = 'json',
    body = list(
      model = 'GPT-4o mini',
      messages = list(list(
        role = 'user',
        content = prompt
      ))
    )
  )

  str_trim(content(response)$choices[[1]]$message$content)
}

for (i in 1:nrow(african_names)){
  oruko = african_names$oruko[i]
  
  prom = 'Which country will the name {oruko} most likely come from?'
  prom1 = glue(prom)
  
  ilu = ask_chatgpt(prom1)
  cat(ilu)
  
  african_names$country_predicted[i] = ilu
}

write.csv(african_names, 'african_names_predicted_country.csv')


african_name = read.csv('african_names_predicted_country.csv')
view(african_name)

nigerians = grepl('Nigeria',african_name$Country)

nigerian_citizens = african_name[nigerians, ]
view(nigerian_citizens)
