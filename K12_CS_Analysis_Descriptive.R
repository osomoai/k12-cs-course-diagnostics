# Set working directory (so relative paths work)
setwd("C:/User/User/Desktop/K12-CS-course-Analysis-descriptive") 

#Input the data with full match data (that has CDRC unmatched data)
data2 <- read.csv("nb_data_clean.csv")
str(data2)

#Import the library for data manipulation
library(dplyr)
library(tidyr)
library(scales)
library(ggplot2)

#Since year is the major classification variable that runs through,
#Then we should make sure no row has respective value missing
table(data2$SCHOOL_YEAR, useNA = "ifany")

#What is the distribution of CS course offerings among the shortlisted schools 
#across the 2020–2021 and 2021–2022 school years?

#Count of the schools shortlisted by year category
school_tab <- data2 %>%
  distinct(SCHOOL_YEAR, Combined_Key) %>%
  count(SCHOOL_YEAR, name = "Count") %>%
  mutate(
    Percent = round(Count / sum(Count) * 100, 1),
    Category = "Schools"
  )

school_tab

# Export table
write.csv(
  school_tab,
  "outputs/tables/tab1_sch.csv",
  row.names = FALSE
)

# Histogram showing the distribution of the dependent variable (CS classes offered) by school year
fig_cs_distribution <- ggplot(data2, aes(x = CS_Classes_Offered)) +
  geom_histogram(binwidth = 1, color = "black", fill = "steelblue") +
  facet_wrap(~ SCHOOL_YEAR) +
  labs(
    title = "Distribution of CS Classes Offered Across Schools by Year",
    x = "Number of CS Classes Offered",
    y = "Number of Schools"
  ) +
  theme_minimal()

fig_cs_distribution

ggsave(
  "C:\\Users\\User\\Desktop\\DataAnalysis\\fig1_his.png",
  fig_cs_distribution,
  width = 8,
  height = 6
)

#Summary statistics of schools shortlisted 
tab1 <- data2 %>%
  group_by(SCHOOL_YEAR) %>%
  summarise(
    n = sum(!is.na(CS_Classes_Offered)),
    percent_offering = mean(CS_Classes_Offered > 0, na.rm = TRUE) * 100,
    mean = mean(CS_Classes_Offered, na.rm = TRUE),
    sd = sd(CS_Classes_Offered, na.rm = TRUE),
    min = min(CS_Classes_Offered, na.rm = TRUE),
    max = max(CS_Classes_Offered, na.rm = TRUE)
  )

tab1

# Export table
write.csv(tab1,
  "outputs/tables/tab1_sch2.csv",
  row.names = FALSE
)

#Further breakdown of the Summary statistics of schools shortlisted 
#Differentiating between school with zero CS courses and schools with
#at least one CS course offering
tab2 <- data2 %>%
  group_by(SCHOOL_YEAR) %>%
  summarise(
    n = sum(!is.na(CS_Classes_Offered)),
    
    zero_n = sum(CS_Classes_Offered == 0, na.rm = TRUE),
    zero_pct = round(100 * mean(CS_Classes_Offered == 0, na.rm = TRUE), 1),
    
    oneplus_n = sum(CS_Classes_Offered >= 1, na.rm = TRUE),
    oneplus_pct = round(100 * mean(CS_Classes_Offered >= 1, na.rm = TRUE), 1),
    
    mean = round(mean(CS_Classes_Offered, na.rm = TRUE), 2),
    sd = round(sd(CS_Classes_Offered, na.rm = TRUE), 2),
    min = min(CS_Classes_Offered, na.rm = TRUE),
    max = max(CS_Classes_Offered, na.rm = TRUE)
  )

tab2

# Export table
write.csv(tab2,
          "outputs/tables/tab1_sch3.csv",
          row.names = FALSE
)

#Summary statistics for gender of students enrolled in the school
gender_tab <- data2 %>%
  group_by(SCHOOL_YEAR) %>%
  summarise(
    Female = sum(sex_female, na.rm = TRUE),
    Male   = sum(sex_male, na.rm = TRUE)
  ) %>%
  pivot_longer(
    cols = c(Female, Male),
    names_to = "Category",
    values_to = "Count"
  ) %>%
  group_by(SCHOOL_YEAR) %>%
  mutate(
    Percent = sprintf("%.2f", Count / sum(Count) * 100)
  )

gender_tab

# Export table
write.csv(gender_tab,
          "outputs/tables/tab1_gender_tab.csv",
          row.names = FALSE
)

#Summary statistics of races/ethnicity of students enrolled in school
race_tab <- data2 %>%
  group_by(SCHOOL_YEAR) %>%
  summarise(
    American_Indian = sum(race_american_indian, na.rm = TRUE),
    Asian           = sum(race_asian, na.rm = TRUE),
    Black           = sum(race_black, na.rm = TRUE),
    Hispanic        = sum(race_hispanic, na.rm = TRUE),
    Multiracial     = sum(race_multiracial, na.rm = TRUE),
    White           = sum(race_white, na.rm = TRUE)
  ) %>%
  pivot_longer(
    cols = -SCHOOL_YEAR,
    names_to = "Category",
    values_to = "Count"
  ) %>%
  group_by(SCHOOL_YEAR) %>%
  mutate(
    Percent = round(Count / sum(Count) * 100, 2)
  )

race_tab

# Export table
write.csv(race_tab,
          "outputs/tables/tab1_race_tab.csv",
          row.names = FALSE
)

#Summary statistics of students enrolled in school based on title 1 status
# Title I status describes the distribution of shortlisted schools by federal Title I program classification:
# Not_TitleI (schools not receiving Title I funds), Schoolwide (schools implementing schoolwide Title I programs),
# Targeted (schools providing Title I services to identified eligible students), and Mixed (schools with multiple Title I classifications).
title1_tab <- data2 %>%
  count(SCHOOL_YEAR, TitleI_Status, name = "Count") %>%
  group_by(SCHOOL_YEAR) %>%
  mutate(
    Percent = round(Count / sum(Count) * 100, 2)
  ) %>%
  rename(Category = TitleI_Status)

title1_tab

# Export table
write.csv(title1_tab,
          "outputs/tables/tab1_title1_tab.csv",
          row.names = FALSE
)

#Summary statistics of students enrolled in school based on juvenile status
jj_tab <- data2 %>%
  count(SCHOOL_YEAR, Juvenile_Justice_School, name = "Count") %>%
  group_by(SCHOOL_YEAR) %>%
  mutate(
    Percent = round(Count / sum(Count) * 100, 2)
  ) %>%
  rename(Category = Juvenile_Justice_School)

jj_tab

# Export table
write.csv(jj_tab,
          "outputs/tables/tab1_jj_tab.csv",
          row.names = FALSE
)

#Summary statistics of students enrolled in school based on grade levels
grade_tab <- data2 %>%
  group_by(SCHOOL_YEAR) %>%
  summarise(
    Total_Schools = n(),
    Elementary = sum(Elementary, na.rm = TRUE),
    Middle = sum(Middle, na.rm = TRUE),
    High = sum(High, na.rm = TRUE)
  ) %>%
  pivot_longer(
    cols = c(Elementary, Middle, High),
    names_to = "Category",
    values_to = "Count"
  ) %>%
  mutate(
    Percent = round(Count / Total_Schools * 100, 2)
  ) %>%
  select(SCHOOL_YEAR, Category, Count, Percent)

grade_tab

# Export table
write.csv(grade_tab,
          "outputs/tables/tab1_grade_tab.csv",
          row.names = FALSE
)

##Summary statistics of students enrolled in school based on states
state_tab <- data2 %>%
  count(SCHOOL_YEAR, State_Code, name = "Count") %>%
  group_by(SCHOOL_YEAR) %>%
  mutate(
    Percent = sprintf("%.2f", Count / sum(Count) * 100)
  )

state_tab

# Export table
write.csv(state_tab,
          "outputs/tables/tab1_state_tab.csv",
          row.names = FALSE
)

#Bar plot of schools with and without CS offerings by year
library(viridis)

cs_zero_plot <- data2 %>%
  mutate(
    CS_Status = ifelse(CS_Classes_Offered == 0,
                       "No CS Classes",
                       "At Least One CS Class")
  ) %>%
  count(SCHOOL_YEAR, CS_Status) %>%
  group_by(SCHOOL_YEAR) %>%
  mutate(
    Percent = n / sum(n) * 100
  ) %>%
  ggplot(aes(x = SCHOOL_YEAR, y = Percent, fill = CS_Status)) +
  geom_col(position = "dodge") +
  geom_text(
    aes(label = sprintf("%.1f%%", Percent)),
    position = position_dodge(width = 0.9),
    vjust = -0.3,
    size = 3.5
  ) +
  scale_fill_viridis_d(option = "D") +
  labs(
    title = "Percentage of Schools With and Without CS Course Offerings by Year",
    x = "School Year",
    y = "Percentage of Schools",
    fill = "CS Offering Status"
  ) +
  theme_minimal()

cs_zero_plot

ggsave(
  "C:\\Users\\User\\Desktop\\DataAnalysis\\fig1_cs_zero_plot.png",
  cs_zero_plot,
  width = 8,
  height = 6
)

#Table: Among schools with different Title I classifications, what proportion
title1_cs_tab <- data2 %>%
  mutate(
    CS_Status = ifelse(
      CS_Classes_Offered == 0,
      "No CS Classes",
      "At Least One CS Class"
    )
  ) %>%
  count(SCHOOL_YEAR, TitleI_Status, CS_Status, name = "Count") %>%
  group_by(SCHOOL_YEAR, TitleI_Status) %>%
  mutate(
    Percent = round(Count / sum(Count) * 100, 2)
  ) %>%
  ungroup()

title1_cs_tab

# Export table
write.csv(title1_cs_tab,
          "outputs/tables/tab1_title1_cs_tab.csv",
          row.names = FALSE
)

#Figure: Among schools with different Title I classifications, what proportion
#offer at least one CS course versus no CS courses, and does this pattern differ across school years?
title1_cs_plot <- data2 %>%
  mutate(
    CS_Status = ifelse(
      CS_Classes_Offered == 0,
      "No CS Classes",
      "At Least One CS Class"
    )
  ) %>%
  count(SCHOOL_YEAR, TitleI_Status, CS_Status, name = "Count") %>%
  group_by(SCHOOL_YEAR, TitleI_Status) %>%
  mutate(
    Percent = Count / sum(Count) * 100
  ) %>%
  ggplot(aes(
    x = TitleI_Status,
    y = Percent,
    fill = CS_Status
  )) +
  geom_col(position = "dodge") +
  geom_text(
    aes(label = sprintf("%.1f%%", Percent)),
    position = position_dodge(width = 0.9),
    vjust = -0.3,
    size = 3.5
  ) +
  facet_wrap(~SCHOOL_YEAR) +
  scale_fill_viridis_d(option = "D") +
  labs(
    title = "CS Course Offering Status by Title I Classification and School Year",
    x = "Title I Status",
    y = "Percentage of Schools",
    fill = "CS Offering Status"
  ) +
  theme_minimal()

title1_cs_plot

ggsave(
  "C:\\Users\\User\\Desktop\\DataAnalysis\\fig1_title1_cs_plot.png",
  title1_cs_plot,
  width = 8,
  height = 6
)

#Table: Among students of each racial/ethnic group, what percentage are enrolled 
#in schools with versus without CS course offerings, and how does this differ across school years
race_cs_tab <- data2 %>%
  mutate(
    CS_Status = ifelse(
      CS_Classes_Offered == 0,
      "No CS Classes",
      "At Least One CS Class"
    )
  ) %>%
  group_by(SCHOOL_YEAR, CS_Status) %>%
  summarise(
    American_Indian = sum(race_american_indian, na.rm = TRUE),
    Asian = sum(race_asian, na.rm = TRUE),
    Black = sum(race_black, na.rm = TRUE),
    Hispanic = sum(race_hispanic, na.rm = TRUE),
    Multiracial = sum(race_multiracial, na.rm = TRUE),
    White = sum(race_white, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  pivot_longer(
    cols = c(
      American_Indian,
      Asian,
      Black,
      Hispanic,
      Multiracial,
      White
    ),
    names_to = "Race_Ethnicity",
    values_to = "Count"
  ) %>%
  group_by(SCHOOL_YEAR, Race_Ethnicity) %>%
  mutate(
    Percent = round(Count / sum(Count) * 100, 2)
  ) %>%
  select(
    SCHOOL_YEAR,
    Race_Ethnicity,
    CS_Status,
    Count,
    Percent
  )

race_cs_tab

# Export table
write.csv(race_cs_tab,
          "outputs/tables/tab1_race_cs_tab.csv",
          row.names = FALSE
)

# Chart: Among students of each racial/ethnic group, what percentage are enrolled 
#in schools with versus without CS course offerings, and how does this differ across school years
race_cs_plot <- data2 %>%
  mutate(
    CS_Status = ifelse(
      CS_Classes_Offered == 0,
      "No CS Classes",
      "At Least One CS Class"
    )
  ) %>%
  group_by(SCHOOL_YEAR, CS_Status) %>%
  summarise(
    American_Indian = sum(race_american_indian, na.rm = TRUE),
    Asian = sum(race_asian, na.rm = TRUE),
    Black = sum(race_black, na.rm = TRUE),
    Hispanic = sum(race_hispanic, na.rm = TRUE),
    Multiracial = sum(race_multiracial, na.rm = TRUE),
    White = sum(race_white, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  pivot_longer(
    cols = c(
      American_Indian,
      Asian,
      Black,
      Hispanic,
      Multiracial,
      White
    ),
    names_to = "Race_Ethnicity",
    values_to = "Count"
  ) %>%
  group_by(SCHOOL_YEAR, Race_Ethnicity) %>%
  mutate(
    Percent = Count / sum(Count) * 100
  ) %>%
  ggplot(aes(
    x = Race_Ethnicity,
    y = Percent,
    fill = CS_Status
  )) +
  geom_col(position = "dodge") +
  geom_text(
    aes(label = sprintf("%.1f%%", Percent)),
    position = position_dodge(width = 0.9),
    vjust = -0.3,
    size = 3
  ) +
  facet_wrap(~SCHOOL_YEAR) +
  scale_fill_viridis_d(option = "D") +
  labs(
    title = "CS Course Offering Status by Student Race/Ethnicity and School Year",
    x = "Race/Ethnicity",
    y = "Percentage of Students",
    fill = "CS Offering Status"
  ) +
  theme_minimal()

race_cs_plot

ggsave(
  "C:\\Users\\User\\Desktop\\DataAnalysis\\fig1_race_cs_plot.png",
  race_cs_plot,
  width = 8,
  height = 6
)

#Table:Among female and male students, what proportion are enrolled
#in schools with versus without CS course offerings, and does this differ across school years?
gender_cs_tab <- data2 %>%
  mutate(
    CS_Status = ifelse(
      CS_Classes_Offered == 0,
      "No CS Classes",
      "At Least One CS Class"
    )
  ) %>%
  group_by(SCHOOL_YEAR, CS_Status) %>%
  summarise(
    Female = sum(sex_female, na.rm = TRUE),
    Male = sum(sex_male, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  pivot_longer(
    cols = c(Female, Male),
    names_to = "Gender",
    values_to = "Count"
  ) %>%
  group_by(SCHOOL_YEAR, Gender) %>%
  mutate(
    Percent = round(Count / sum(Count) * 100, 2)
  ) %>%
  select(
    SCHOOL_YEAR,
    Gender,
    CS_Status,
    Count,
    Percent
  )

gender_cs_tab

# Export table
write.csv(gender_cs_tab,
          "outputs/tables/tab1_gender_cs_tab.csv",
          row.names = FALSE
)

#Chart:Among female and male students, what proportion are enrolled
#in schools with versus without CS course offerings, and does this differ across school years?
gender_cs_plot <- gender_cs_tab %>%
  ggplot(aes(
    x = Gender,
    y = Percent,
    fill = CS_Status
  )) +
  geom_col(position = "dodge") +
  geom_text(
    aes(label = sprintf("%.1f%%", Percent)),
    position = position_dodge(width = 0.9),
    vjust = -0.3,
    size = 3.5
  ) +
  facet_wrap(~SCHOOL_YEAR) +
  scale_fill_viridis_d(option = "D") +
  labs(
    title = "CS Course Offering Status by Student Gender and School Year",
    x = "Gender",
    y = "Percentage of Students",
    fill = "CS Offering Status"
  ) +
  theme_minimal()

gender_cs_plot

ggsave(
  "C:\\Users\\User\\Desktop\\DataAnalysis\\fig1_gender_cs_plot.png",
  gender_cs_plot,
  width = 8,
  height = 6
)

#State: What is the geographic distribution of the shortlisted schools across
#U.S. states during the 2020–2021 and 2021–2022 school years?
state_summary <- state_tab %>%
  mutate(
    Percent = sprintf("%.2f", as.numeric(Percent))
  ) %>%
  pivot_wider(
    names_from = SCHOOL_YEAR,
    values_from = c(Count, Percent),
    names_glue = "{SCHOOL_YEAR}_{.value}"
  ) %>%
  select(
    State_Code,
    `2020-2021_Count`,
    `2020-2021_Percent`,
    `2021-2022_Count`,
    `2021-2022_Percent`
  ) %>%
  arrange(State_Code)

state_summary

#Naming the columns properly
colnames(state_summary) <- c(
  "State",
  "Count (2020–2021)",
  "Percent (2020–2021)",
  "Count (2021–2022)",
  "Percent (2021–2022)"
)

state_summary

write.csv(
  state_summary,
  "outputs/tables/Table3_State_Distribution.csv",
  row.names = FALSE
)

#Graph: What is the geographic distribution of the shortlisted schools across
#U.S. states during the 2020–2021 and 2021–2022 school years?
state_plot <- state_tab %>%
  mutate(
    Percent = as.numeric(Percent)
  ) %>%
  ggplot(aes(
    x = reorder(State_Code, Percent),
    y = Percent
  )) +
  geom_col(fill = "steelblue") +
  geom_text(
    aes(label = sprintf("%.1f%%", Percent)),
    hjust = -0.1,
    size = 2.8
  ) +
  facet_wrap(~SCHOOL_YEAR) +
  coord_flip() +
  labs(
    title = "Distribution of Shortlisted Schools by State and School Year",
    x = "State",
    y = "Percentage of Schools"
  ) +
  theme_minimal()

state_plot

ggsave(
  "C:\\Users\\User\\Desktop\\DataAnalysis\\fig1_state_plot.png",
  state_plot,
  width = 8,
  height = 6
)

