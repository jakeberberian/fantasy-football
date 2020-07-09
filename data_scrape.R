passing <- data.frame()
rushing <- data.frame()
receiving <- data.frame()
fantasyAll <- data.frame()


read_html("https://www.pro-football-reference.com/years/2006/passing.htm")

i = 2006
for (i in 2006:2019) {
  passingurl <- glue("https://www.pro-football-reference.com/years/", i, "/passing.htm")
  rushingurl <- glue("https://www.pro-football-reference.com/years/", i, "/rushing.htm")
  receivingurl <- glue("https://www.pro-football-reference.com/years/", i, "/receiving.htm")
  fantasyurl <- glue("https://www.pro-football-reference.com/years/", i, "/fantasy.htm")
  
  passingYear <- read_html(passingurl) %>%
    html_nodes("table") %>%
    html_table()
  
  rushingYear <- read_html(rushingurl) %>%
    html_nodes("table") %>%
    html_table()
  
  receivingYear <- read_html(receivingurl) %>%
    html_nodes("table") %>%
    html_table()
  
  fantasyYear <- read_html(fantasyurl) %>%
    html_nodes("table") %>%
    html_table()
  
  passingYear <- passingYear[[1]]
  passingYear$year <- i
  
  rushingYear <- rushingYear[[1]]
  rushingYear$year <- i
  
  receivingYear <- receivingYear[[1]]
  receivingYear$year <- i
  
  fantasyYear <- fantasyYear[[1]]
  fantasyYear$year <- i
  
  passing <- rbind(passing, passingYear)
  rushing <- rbind(rushing, rushingYear)
  receiving <- rbind(receiving, receivingYear)
  fantasyAll <- rbind(fantasyAll, fantasyYear)
}

rm(fantasyYear, passingYear, receivingYear, rushingYear)

setwd("/Users/jakeberberian/fantasy-football/data")

write_csv(passing, "/Users/jakeberberian/fantasy-football/data/pass.csv")
write_csv(rushing, "/Users/jakeberberian/fantasy-football/data/rush.csv")
write_csv(receiving, "/Users/jakeberberian/fantasy-football/data/receive.csv")
write_csv(fantasyAll, "/Users/jakeberberian/fantasy-football/data/fantasy.csv")
