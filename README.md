# K–12 Computer Science Course Offerings: A Descriptive Analysis (2020–2022)

This repository contains the descriptive analyses and visualizations used to characterize K–12 public schools included in the study of Computer Science (CS) course offerings during the 2020–2021 and 2021–2022 school years.

The analyses summarize the distribution of CS course offerings, school characteristics, student demographics, and geographic representation, providing a comprehensive overview of the study sample prior to inferential modeling.

The analyses are based on the cleaned dataset produced in the companion repository:

https://github.com/osomoai/k12-cs-course-pipeline-analysis

**Author:** Omodolapo Ojo, PhD  

---

## Focus
This repository addresses the following descriptive questions:
1. **What are the characteristics of the shortlisted schools and the distribution of CS course offerings across the 2020–2021 and 2021–2022 school years?**
2. **What are the demographic and institutional characteristics of the shortlisted schools across the two school years?**
3. **How are the shortlisted schools geographically distributed across U.S. states?**
4. **Among schools with different Title I classifications, what proportion offer at least one CS course versus no CS courses, and does this pattern differ across school years?**
5. **Among students of different racial and ethnic groups, what proportion are enrolled in schools with versus without CS course offerings across school years?**
6. **Among female and male students, what proportion are enrolled in schools with versus without CS course offerings across school years?**

---

## Analytical Outputs

This repository produces:
- **Descriptive summary tables** of school characteristics, student demographics, and CS course offerings.
- **Exploratory visualizations** illustrating the distribution of CS course offerings and equity-related patterns across school years.
- **Summary statistics** describing the frequency, variability, and distribution of CS course offerings.

Together, these outputs provide a descriptive overview of the study sample and establish the empirical context for subsequent statistical analyses.

---

## Summary Tables

| Table | Description |
|-------|-------------|
| [Table 1: Distribution of CS Course Offerings](Tables/Table1_descriptive_statistics.csv) | Distribution and summary statistics of CS course offerings by school year |
| [Table 2: School Characteristics](Tables/Table2_categorical_characteristics.csv) | Student demographics and school characteristics |
| [Table 3: Geographic Distribution](Tables/Table3_state_distribution.csv) | Distribution of shortlisted schools across U.S. states |
| [Table 4: CS Offering by Title I Status](Tables/Table4_CS_by_TitleI.csv) | CS offering status by Title I classification |
| [Table 5: CS Offering by Race/Ethnicity](Tables/Table5_CS_by_Race.csv) | CS offering status by race/ethnicity |
| [Table 6: CS Offering by Gender](Tables/Table6_CS_by_Gender.csv) | CS offering status by gender |                                                                                      |

---

## Visualizations

Figures generated from the analysis are located in the `outputs/figures/` directory.

## Figures

| Figure | Description |
|--------|-------------|
| [Figure 1: Distribution of CS Course Offerings](Figures/fig1_his.png) | Histogram of CS classes offered across schools by school year |
| [Figure 2: Schools With and Without CS Offerings](Figures/cs_zero_plot.png) | Percentage of schools with and without CS course offerings |
| [Figure 3: CS Offering by Title I Status](Figures/title1_cs_plot.png) | CS offering status by Title I classification |
| [Figure 4: CS Offering by Gender](Figures/gender_cs_plot.png) | CS offering status by student gender |
| [Figure 5: CS Offering by Race/Ethnicity](Figures/race_cs_plot.png) | CS offering status by race/ethnicity |
| [Figure 6: Geographic Distribution of Schools](Figures/state_plot.png) | Distribution of shortlisted schools across U.S. states |
