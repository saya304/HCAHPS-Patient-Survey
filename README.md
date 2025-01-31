# HCAHPS Patient Survey

# 📌 Overview
This Power BI project analyzes the **HCAHPS (Hospital Consumer Assessment of Healthcare Providers and Systems)** Patient Survey dataset, provided by Maven Analytics. The project aims to uncover insights into patient satisfaction and hospital performance across various metrics, helping healthcare administrators improve service quality.

# 📂 Dataset
* **Source:** Maven Analytics (HCAHPS Patient Survey)
* **Format & Size:** csv (224KB)
* **Data Type:** Structured survey responses
* **Metrics:** Patient satisfaction scores, hospital ratings, response rates, and more

# 🛠️ Technologies Used
* **Power BI** (for visualization & reporting)
* **SQL** (for data transformation & querying)

# 📌 Dashboard
![HCAHPS Dashboard](https://github.com/user-attachments/assets/fb7a33f9-671a-4d49-98de-f772b9b7d366)

# 🔍 SQL Queries
The SQL queries are available in the 'hcahps sql code.sql' file in the project repository. 

The SQL script **cleans and standardizes** the HCAHPS patient survey data by converting mixed data types into consistent numeric values. It extracts **nationwide patient satisfaction trends** using SQL joins and unions. Views are created to compare **Top Box Ratings** between **2013 and 2022** for each state. A final view calculates the **improvement in patient satisfaction** over time. The cleaned data is ready for **Power BI visualization**. 🚀

# 📈 Analysis
**1) Have hospitals made improvements in their quality of care over the past 9 years?**

The quality of care in hospitals showed gradual improvement from 2014 to 2019. However, there was a noticeable decline after 2020. This indicates that while hospitals were making progress in enhancing patient experiences, external factors (possibly the COVID-19 pandemic) may have contributed to the decline in quality post-2020. Overall, hospitals have not made any significant improvements over the past nine years.

**2) Are there any specific areas where hospitals have made more progress than others?**

Hospitals have shown the most improvement in the following areas:
* **Discharge Information (86.76%)**
* **Communication with Doctors (81.38%)**
* **Communication with Nurses (80.14%)**
  
These areas suggest that hospitals have made efforts to ensure that patients receive clear instructions upon discharge and have better communication with healthcare providers.

**3) Are there still any major areas of opportunity?**

Despite the progress, some areas still require significant improvement:
* **Care Transition (52.65%)** – Ensuring smoother transitions between different levels of care.
* **Quietness of the Hospital Environment (61.56%)** – Maintaining a more restful and peaceful setting for patients.
* **Communication about Medicines (64.83%)** – Providing better explanations regarding medications, including side effects and usage instructions.
  
**4) What recommendations can you make to hospitals to help them further improve the patient experience?**

* **Enhance Care Transition:** Develop better discharge planning, follow-up care strategies, and coordination with primary care providers to ensure continuity of care.
* **Improve Quietness in Hospital Environments:** Implement noise reduction strategies, such as designated quiet hours, soundproofing, and staff training to minimize unnecessary disturbances.
* **Strengthen Communication About Medicines:** Educate both patients and caregivers on medication use, potential side effects, and adherence through written instructions and verbal discussions.
