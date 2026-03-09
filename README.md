# k12-cs-course-diagnostics
This repository conducts descriptive and diagnostic analysis of key variables used to study K–12 computer science (CS) course access in U.S. public schools.
The focus is on understanding the distribution, variation, and statistical properties of the independent variable:
CS Course Offerings (CS_Classes_Offered)

Using the cleaned dataset produced in the companion repository:
k12-cs-course-data-pipeline

**Author:** Omodolapo Ojo, PhD  

---

## Focus
This project examines the following hihglighted questions. 
The goal is to ensure the independent variable used in later statistical models is well-understood, well-behaved, and properly specified.

1. **How widely available are CS courses across U.S. schools?**
2. **Does access to CS courses differ by Title I status?**
3. **How does CS availability vary across school levels (Elementary, Middle, High)?**
4. **What gender participation patterns exist in CS enrollment?**
5. **What is the racial composition of students enrolled in CS courses?**
6. **Did access to CS courses change between the 2020–21 and 2021–22 school years?**

---

## Analytical Outputs

This repository produces the following descriptive outputs:

- **Summary tables** examining CS access and participation by Title I status, school level, race, and gender  
- **Visualizations** illustrating the distribution and participation patterns of CS course offerings  

These outputs provide an overview of the **availability and demographic participation in CS education across schools**.

---

## Summary Tables

Summary tables are stored in the `output/` directory.

| File | Description |
|------|-------------|
| `titleI_summary.csv` | Summary of CS course access by Title I status |
| `grade_level_summary.csv` | CS course availability by school level |
| `gender_summary.csv` | Average gender composition of CS enrollment |
| `race_summary.csv` | Racial composition of CS enrollment |
| `cs_status_table.csv` | Number of schools offering versus not offering CS courses |
| `distribution_summary.csv` | Distribution statistics for the number of CS classes offered |

---

## Visualizations

Figures generated from the analysis are located in the `figures/` directory.

| File | Description |
|------|-------------|
| `fig1_distribution.png` | Distribution of the number of CS classes offered across schools |
| `fig_cs_status.png` | Schools offering versus not offering CS courses |
| `gender_share.png` | Gender composition of CS enrollment |
| `titleI_access.png` | CS course access by Title I status |
| `grade_level_access.png` | CS course availability by school level |
